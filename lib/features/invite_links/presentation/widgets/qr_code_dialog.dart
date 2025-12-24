import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../../../core/errors/failures.dart';
import '../providers/invite_links_providers.dart';

class QRCodeDialog extends ConsumerWidget {
  const QRCodeDialog({super.key, required this.conversationId, required this.linkId, required this.token});

  final int conversationId;
  final int linkId;
  final String token;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.qr_code, color: colors.primary),
                const SizedBox(width: 12),
                Text('QR Code', style: textTheme.titleLarge),
                const Spacer(),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),

            const SizedBox(height: 24),

            // QR Code Image
            FutureBuilder<Uint8List>(
              future: _loadQRCode(ref),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(height: 300, child: Center(child: CircularProgressIndicator()));
                }

                if (snapshot.hasError) {
                  return SizedBox(
                    height: 300,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 48, color: colors.error),
                          const SizedBox(height: 16),
                          Text('Không thể tải QR code', style: textTheme.bodyMedium),
                          const SizedBox(height: 8),
                          Text(
                            snapshot.error.toString(),
                            style: textTheme.bodySmall?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final imageBytes = snapshot.data!;

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Image.memory(imageBytes, width: 300, height: 300, fit: BoxFit.contain),
                );
              },
            ),

            const SizedBox(height: 16),

            // Token
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: colors.surfaceContainerHighest, borderRadius: BorderRadius.circular(8)),
              child: Text(
                token,
                style: textTheme.bodyMedium?.copyWith(fontFamily: 'monospace', fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 24),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _saveQRCode(context, ref),
                    icon: const Icon(Icons.download),
                    label: const Text('Lưu'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _shareQRCode(context, ref),
                    icon: const Icon(Icons.share),
                    label: const Text('Chia sẻ'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _loadQRCode(WidgetRef ref) async {
    final useCase = ref.read(getQRCodeUseCaseProvider);

    final result = await useCase(conversationId: conversationId, linkId: linkId, size: 600);

    return result.fold((failure) {
      final f = failure as Failure;
      throw Exception(f.userMessage);
    }, (bytes) => Uint8List.fromList(bytes));
  }

  Future<void> _saveQRCode(BuildContext context, WidgetRef ref) async {
    try {
      final imageBytes = await _loadQRCode(ref);

      // Save to temporary file first
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/invite_link_$token.png');
      await file.writeAsBytes(imageBytes);

      // Save to gallery using gal
      await Gal.putImage(file.path, album: 'Chattrix');

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã lưu QR code vào thư viện')));
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    }
  }

  Future<void> _shareQRCode(BuildContext context, WidgetRef ref) async {
    try {
      final imageBytes = await _loadQRCode(ref);

      // Save to temp directory
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/invite_qr_$token.png');
      await file.writeAsBytes(imageBytes);

      // Share
      await Share.shareXFiles([XFile(file.path)], text: 'QR Code link mời vào nhóm');
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
    }
  }
}
