import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import '../providers/invite_link_providers.dart';
import '../../domain/entities/invite_link.dart';

/// Custom overlay shape for QR scanner
class QrScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final double borderLength;
  final double borderRadius;
  final double cutOutSize;

  const QrScannerOverlayShape({
    this.borderColor = Colors.white,
    this.borderWidth = 4.0,
    this.borderLength = 40.0,
    this.borderRadius = 10.0,
    this.cutOutSize = 300.0,
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: rect.center, width: cutOutSize, height: cutOutSize),
          Radius.circular(borderRadius),
        ),
      )
      ..fillType = PathFillType.evenOdd;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRect(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final backgroundPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    final cutOutRect = Rect.fromCenter(center: rect.center, width: cutOutSize, height: cutOutSize);

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(rect),
        Path()..addRRect(RRect.fromRectAndRadius(cutOutRect, Radius.circular(borderRadius))),
      ),
      backgroundPaint,
    );

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final left = cutOutRect.left;
    final top = cutOutRect.top;
    final right = cutOutRect.right;
    final bottom = cutOutRect.bottom;

    // Top-left corner
    canvas.drawPath(
      Path()
        ..moveTo(left, top + borderLength)
        ..lineTo(left, top + borderRadius)
        ..arcToPoint(Offset(left + borderRadius, top), radius: Radius.circular(borderRadius))
        ..lineTo(left + borderLength, top),
      borderPaint,
    );

    // Top-right corner
    canvas.drawPath(
      Path()
        ..moveTo(right - borderLength, top)
        ..lineTo(right - borderRadius, top)
        ..arcToPoint(Offset(right, top + borderRadius), radius: Radius.circular(borderRadius))
        ..lineTo(right, top + borderLength),
      borderPaint,
    );

    // Bottom-left corner
    canvas.drawPath(
      Path()
        ..moveTo(left, bottom - borderLength)
        ..lineTo(left, bottom - borderRadius)
        ..arcToPoint(Offset(left + borderRadius, bottom), radius: Radius.circular(borderRadius))
        ..lineTo(left + borderLength, bottom),
      borderPaint,
    );

    // Bottom-right corner
    canvas.drawPath(
      Path()
        ..moveTo(right - borderLength, bottom)
        ..lineTo(right - borderRadius, bottom)
        ..arcToPoint(Offset(right, bottom - borderRadius), radius: Radius.circular(borderRadius))
        ..lineTo(right, bottom - borderLength),
      borderPaint,
    );
  }

  @override
  ShapeBorder scale(double t) => QrScannerOverlayShape(
    borderColor: borderColor,
    borderWidth: borderWidth * t,
    borderLength: borderLength * t,
    borderRadius: borderRadius * t,
    cutOutSize: cutOutSize * t,
  );
}

/// Page for scanning QR codes to join groups via invite links
class QrScannerPage extends HookConsumerWidget {
  const QrScannerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final controller = useMemoized(
      () => MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates, formats: [BarcodeFormat.qrCode]),
    );
    final hasScanned = useState(false);
    final isProcessing = useState(false);

    // Request camera permission on mount
    useEffect(() {
      _requestCameraPermission(context);
      return null;
    }, []);

    // Dispose controller
    useEffect(() {
      return () => controller.dispose();
    }, []);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Scan QR Code', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Toggle flash
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, state, child) {
                final isFlashOn = state.torchState == TorchState.on;
                return Icon(isFlashOn ? Icons.flash_on : Icons.flash_off, color: Colors.white);
              },
            ),
            onPressed: () => controller.toggleTorch(),
            tooltip: 'Toggle flash',
          ),
          // Pick from gallery button
          IconButton(
            icon: const Icon(Icons.photo_library, color: Colors.white),
            onPressed: () => _pickImageFromGallery(context, ref, controller, hasScanned, isProcessing),
            tooltip: 'Pick from gallery',
          ),
        ],
      ),
      body: Stack(
        children: [
          // QR Scanner with overlay
          Stack(
            children: [
              MobileScanner(
                controller: controller,
                onDetect: (capture) async {
                  if (hasScanned.value || isProcessing.value) return;

                  final List<Barcode> barcodes = capture.barcodes;
                  if (barcodes.isEmpty) return;

                  final barcode = barcodes.first;
                  final String? code = barcode.rawValue;

                  if (code == null || code.isEmpty) return;

                  hasScanned.value = true;
                  isProcessing.value = true;

                  // Stop scanning
                  await controller.stop();

                  // Extract token from URL
                  final token = _extractTokenFromUrl(code);

                  if (token != null && context.mounted) {
                    await _showInviteLinkInfo(context, ref, token, controller, hasScanned);
                  } else if (context.mounted) {
                    final inviteBaseUrl = dotenv.env['INVITE_BASE_URL'] ?? 'https://chattrix.app';
                    _showErrorDialog(
                      context,
                      'Invalid QR code. Please scan a valid invite link.\n\nExpected format:\n$inviteBaseUrl/join/{token}',
                    );
                    await controller.start();
                    hasScanned.value = false;
                  }

                  isProcessing.value = false;
                },
              ),
              // Custom overlay
              Container(
                decoration: ShapeDecoration(
                  shape: QrScannerOverlayShape(
                    borderColor: theme.colorScheme.primary,
                    borderRadius: 16,
                    borderLength: 40,
                    borderWidth: 8,
                    cutOutSize: 300,
                  ),
                ),
              ),
            ],
          ),

          // Instructions
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Point your camera at a QR code to scan',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _requestCameraPermission(BuildContext context) async {
    final status = await Permission.camera.request();

    if (status.isDenied && context.mounted) {
      _showErrorDialog(context, 'Camera permission is required to scan QR codes.');
    } else if (status.isPermanentlyDenied && context.mounted) {
      _showPermissionSettingsDialog(context);
    }
  }

  String? _extractTokenFromUrl(String? url) {
    if (url == null || url.isEmpty) return null;

    debugPrint('🔍 Scanning QR code: $url');

    // Get base URL from env, default to chattrix.app
    var inviteBaseUrl = dotenv.env['INVITE_BASE_URL'] ?? 'https://chattrix.app';
    // Remove trailing slash if present
    if (inviteBaseUrl.endsWith('/')) {
      inviteBaseUrl = inviteBaseUrl.substring(0, inviteBaseUrl.length - 1);
    }
    debugPrint('📝 Expected base URL: $inviteBaseUrl');

    // Expected formats:
    // 1. {inviteBaseUrl}/join/{token} (user-friendly URL)
    // 2. {inviteBaseUrl}/api/v1/invite-links/{token} (API endpoint with /api prefix)
    // 3. {inviteBaseUrl}/v1/invite-links/{token} (API endpoint without /api prefix)
    final uri = Uri.tryParse(url);
    if (uri == null) {
      debugPrint('❌ Failed to parse URL');
      return null;
    }

    debugPrint('🌐 Parsed URI - Host: ${uri.host}, Path: ${uri.path}, Segments: ${uri.pathSegments}');

    // Extract host from inviteBaseUrl for comparison
    final expectedUri = Uri.tryParse(inviteBaseUrl);
    if (expectedUri == null) {
      debugPrint('❌ Failed to parse expected URL');
      return null;
    }

    debugPrint('✅ Expected URI - Host: ${expectedUri.host}');

    // Check if host matches
    if (uri.host != expectedUri.host) {
      debugPrint('❌ Host mismatch: ${uri.host} != ${expectedUri.host}');
      return null;
    }

    // Check for user-friendly format: /join/{token}
    if (uri.pathSegments.length >= 2 && uri.pathSegments[0] == 'join') {
      final token = uri.pathSegments[1];
      debugPrint('✅ Token extracted from /join/ format: $token');
      return token;
    }

    // Check for API endpoint format with /api prefix: /api/v1/invite-links/{token}
    if (uri.pathSegments.length >= 4 &&
        uri.pathSegments[0] == 'api' &&
        uri.pathSegments[1] == 'v1' &&
        uri.pathSegments[2] == 'invite-links') {
      final token = uri.pathSegments[3];
      debugPrint('✅ Token extracted from /api/v1/invite-links/ format: $token');
      return token;
    }

    // Check for API endpoint format without /api prefix: /v1/invite-links/{token}
    if (uri.pathSegments.length >= 3 && uri.pathSegments[0] == 'v1' && uri.pathSegments[1] == 'invite-links') {
      final token = uri.pathSegments[2];
      debugPrint('✅ Token extracted from /v1/invite-links/ format: $token');
      return token;
    }

    debugPrint('❌ URL validation failed - Path segments: ${uri.pathSegments}');
    return null;
  }

  Future<void> _showInviteLinkInfo(
    BuildContext context,
    WidgetRef ref,
    String token,
    MobileScannerController controller,
    ValueNotifier<bool> hasScanned,
  ) async {
    final useCase = ref.read(getInviteLinkInfoUseCaseProvider);
    final result = await useCase(token: token);

    if (!context.mounted) return;

    result.fold(
      (failure) {
        _showErrorDialog(context, failure.message);
        controller.start();
        hasScanned.value = false;
      },
      (linkInfo) {
        _showJoinConfirmationBottomSheet(context, ref, token, linkInfo, controller, hasScanned);
      },
    );
  }

  void _showJoinConfirmationBottomSheet(
    BuildContext context,
    WidgetRef ref,
    String token,
    InviteLinkInfo linkInfo,
    MobileScannerController controller,
    ValueNotifier<bool> hasScanned,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: colors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(Icons.group, size: 48, color: colors.primary),
            ),

            const SizedBox(height: 20),

            // Title
            Text('Join Group?', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),

            const SizedBox(height: 12),

            // Group info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: colors.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  _buildInfoRow(Icons.people, '${linkInfo.memberCount} members', colors),
                  const SizedBox(height: 8),
                  _buildInfoRow(Icons.person, 'Created by ${linkInfo.createdByFullName}', colors),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      controller.start();
                      hasScanned.value = false;
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await _joinGroup(context, ref, token, linkInfo.groupId);
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Join'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, ColorScheme colors) {
    return Row(
      children: [
        Icon(icon, size: 20, color: colors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 14, color: colors.onSurface)),
        ),
      ],
    );
  }

  Future<void> _joinGroup(BuildContext context, WidgetRef ref, String token, int conversationId) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final useCase = ref.read(joinViaInviteLinkUseCaseProvider);
    final result = await useCase(token: token);

    if (!context.mounted) return;

    // Dismiss loading
    Navigator.pop(context);

    result.fold(
      (failure) {
        _showErrorDialog(context, failure.message);
      },
      (joinResult) async {
        debugPrint('✅ Join successful - conversationId: ${joinResult.conversationId}');

        // Save router before popping
        final router = GoRouter.of(context);

        // Pop scanner page first
        if (context.mounted) {
          Navigator.pop(context);
        }

        // Wait a bit for navigation to settle
        await Future.delayed(const Duration(milliseconds: 100));

        // Navigate using saved router - use correct route path
        debugPrint('🚀 Navigating to conversation ${joinResult.conversationId}');
        router.push('/chat/${joinResult.conversationId}');

        // Show success message after navigation
        await Future.delayed(const Duration(milliseconds: 500));
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(joinResult.message), duration: const Duration(seconds: 2)));
        }
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
      ),
    );
  }

  void _showPermissionSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Camera Permission Required'),
        content: const Text(
          'Camera permission is permanently denied. Please enable it in app settings to scan QR codes.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromGallery(
    BuildContext context,
    WidgetRef ref,
    MobileScannerController controller,
    ValueNotifier<bool> hasScanned,
    ValueNotifier<bool> isProcessing,
  ) async {
    if (hasScanned.value || isProcessing.value) return;

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image == null || !context.mounted) return;

      hasScanned.value = true;
      isProcessing.value = true;

      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Analyze image using mobile_scanner
      final BarcodeCapture? capture = await controller.analyzeImage(image.path);

      if (!context.mounted) return;

      // Dismiss loading
      Navigator.pop(context);

      if (capture != null && capture.barcodes.isNotEmpty) {
        final barcode = capture.barcodes.first;
        final String? qrCode = barcode.rawValue;

        if (qrCode != null && qrCode.isNotEmpty) {
          // Extract token from URL
          final token = _extractTokenFromUrl(qrCode);

          if (token != null && context.mounted) {
            await _showInviteLinkInfo(context, ref, token, controller, hasScanned);
          } else if (context.mounted) {
            final inviteBaseUrl = dotenv.env['INVITE_BASE_URL'] ?? 'https://chattrix.app';
            _showErrorDialog(
              context,
              'Invalid QR code. Please select an image with a valid invite link.\n\nExpected format:\n$inviteBaseUrl/join/{token}',
            );
            hasScanned.value = false;
          }
        } else if (context.mounted) {
          _showErrorDialog(context, 'No QR code found in the selected image.');
          hasScanned.value = false;
        }
      } else if (context.mounted) {
        _showErrorDialog(context, 'No QR code found in the selected image.');
        hasScanned.value = false;
      }

      isProcessing.value = false;
    } catch (e) {
      debugPrint('Error scanning image: $e');
      if (context.mounted) {
        // Dismiss loading if still showing
        Navigator.of(
          context,
          rootNavigator: true,
        ).popUntil((route) => route.isFirst || route.settings.name == '/qr-scanner');
        _showErrorDialog(context, 'Failed to scan QR code from image. Please try again.');
      }
      hasScanned.value = false;
      isProcessing.value = false;
    }
  }
}
