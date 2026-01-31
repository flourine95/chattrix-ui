import 'package:chattrix_ui/features/chat/presentation/pages/files_links_page.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/media_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/chat_info/media_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MediaGridWidget extends HookConsumerWidget {
  const MediaGridWidget({super.key, required this.conversationId});

  final int conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Fetch media statistics
    final statsAsync = ref.watch(conversationMediaStatisticsProvider(conversationId));
    
    // Fetch media preview (only images and videos, limit 6)
    final mediaAsync = ref.watch(
      conversationMediaProvider(
        conversationId,
        limit: 6,
        types: const ['IMAGE', 'VIDEO'],
      ),
    );

    return Column(
      children: [
        // Statistics row
        statsAsync.when(
          data: (stats) {
            if (stats.totalMedia == 0) {
              return const SizedBox.shrink();
            }
            
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border(bottom: BorderSide(color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1))),
              ),
              child: Row(
                children: [
                  _StatChip(
                    icon: Icons.image,
                    count: stats.totalImages,
                    label: 'Photos',
                    colors: colors,
                  ),
                  const SizedBox(width: 12),
                  _StatChip(
                    icon: Icons.videocam,
                    count: stats.totalVideos,
                    label: 'Videos',
                    colors: colors,
                  ),
                  const SizedBox(width: 12),
                  _StatChip(
                    icon: Icons.insert_drive_file,
                    count: stats.totalFiles,
                    label: 'Files',
                    colors: colors,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilesLinksPage(conversationId: conversationId),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('View All', style: TextStyle(color: colors.primary, fontWeight: FontWeight.w600)),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios, size: 14, color: colors.primary),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),

        // Media grid preview
        Expanded(
          child: mediaAsync.when(
            data: (result) {
              final mediaMessages = result.messages;

              if (mediaMessages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_library_outlined, size: 64, color: colors.onSurface.withValues(alpha: 0.3)),
                      const SizedBox(height: 16),
                      Text(
                        'No media yet',
                        style: textTheme.bodyLarge?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: mediaMessages.length,
                itemBuilder: (context, index) {
                  final media = mediaMessages[index];
                  final isVideo = media.type == 'VIDEO';
                  final imageUrl = media.metadata?.thumbnailUrl ?? media.metadata?.mediaUrl;

                  return GestureDetector(
                    onTap: () {
                      // TODO: Open media viewer
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (imageUrl != null)
                            Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: colors.surfaceContainerHighest,
                                  child: Icon(
                                    isVideo ? Icons.videocam : Icons.broken_image,
                                    color: colors.onSurface.withValues(alpha: 0.3),
                                  ),
                                );
                              },
                            )
                          else
                            Container(
                              color: colors.surfaceContainerHighest,
                              child: Icon(
                                isVideo ? Icons.videocam : Icons.image,
                                color: colors.onSurface.withValues(alpha: 0.3),
                              ),
                            ),
                          if (isVideo)
                            Container(
                              color: Colors.black26,
                              child: const Center(
                                child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: colors.error),
                  const SizedBox(height: 12),
                  Text('Failed to load media', style: textTheme.bodyMedium?.copyWith(color: colors.error)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.count,
    required this.label,
    required this.colors,
  });

  final IconData icon;
  final int count;
  final String label;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: colors.onSurface.withValues(alpha: 0.6)),
        const SizedBox(width: 4),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: colors.onSurface,
          ),
        ),
      ],
    );
  }
}
