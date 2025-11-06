import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/chat_info/media_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MediaGridWidget extends HookConsumerWidget {
  const MediaGridWidget({
    super.key,
    required this.conversationId,
  });

  final String conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMediaType = useState<String>('ALL');
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final messagesAsync = ref.watch(messagesProvider(conversationId));

    return Column(
      children: [
        // Media type filter
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border(
              bottom: BorderSide(
                color: colors.onSurface.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _MediaTypeChip(
                  label: 'Tất cả',
                  isSelected: selectedMediaType.value == 'ALL',
                  onTap: () => selectedMediaType.value = 'ALL',
                ),
                const SizedBox(width: 8),
                _MediaTypeChip(
                  label: 'Photos',
                  icon: Icons.image,
                  isSelected: selectedMediaType.value == 'IMAGE',
                  onTap: () => selectedMediaType.value = 'IMAGE',
                ),
                const SizedBox(width: 8),
                _MediaTypeChip(
                  label: 'Videos',
                  icon: Icons.videocam,
                  isSelected: selectedMediaType.value == 'VIDEO',
                  onTap: () => selectedMediaType.value = 'VIDEO',
                ),
                const SizedBox(width: 8),
                _MediaTypeChip(
                  label: 'File',
                  icon: Icons.insert_drive_file,
                  isSelected: selectedMediaType.value == 'DOCUMENT',
                  onTap: () => selectedMediaType.value = 'DOCUMENT',
                ),
                const SizedBox(width: 8),
                _MediaTypeChip(
                  label: 'Audio',
                  icon: Icons.audiotrack,
                  isSelected: selectedMediaType.value == 'AUDIO',
                  onTap: () => selectedMediaType.value = 'AUDIO',
                ),
              ],
            ),
          ),
        ),

        // Media grid
        Expanded(
          child: messagesAsync.when(
            data: (messages) {
              // Filter messages by media type
              final mediaMessages = messages.where((m) {
                if (selectedMediaType.value == 'ALL') {
                  return m.mediaUrl != null;
                }
                return m.type.toUpperCase() == selectedMediaType.value;
              }).toList();

              if (mediaMessages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.photo_library_outlined,
                        size: 64,
                        color: colors.onSurface.withValues(alpha: 0.3),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No media yet',
                        style: textTheme.bodyLarge?.copyWith(
                          color: colors.onSurface.withValues(alpha: 0.6),
                        ),
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
                  final message = mediaMessages[index];
                  return MediaGridItem(message: message);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(
              child: Text(
                'Failed to load media',
                style: textTheme.bodyMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MediaTypeChip extends StatelessWidget {
  const _MediaTypeChip({
    required this.label,
    this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary : colors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? colors.primary : colors.onSurface.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isSelected ? colors.onPrimary : colors.onSurface,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: textTheme.labelMedium?.copyWith(
                color: isSelected ? colors.onPrimary : colors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

