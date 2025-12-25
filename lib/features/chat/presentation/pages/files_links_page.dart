import 'package:chattrix_ui/core/widgets/bottom_sheets.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/media_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/media_date_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class FilesLinksPage extends ConsumerStatefulWidget {
  const FilesLinksPage({super.key, required this.conversationId});

  final String conversationId;

  @override
  ConsumerState<FilesLinksPage> createState() => _FilesLinksPageState();
}

class _FilesLinksPageState extends ConsumerState<FilesLinksPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedMediaFilter = 'All'; // All, Today, This Week, This Month
  String _selectedFilesFilter = 'All';
  String _selectedLinksFilter = 'All';
  String _selectedVoiceFilter = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  // Helper: Get file icon and color based on extension
  Map<String, dynamic> _getFileIconAndColor(String? fileName) {
    if (fileName == null) return {'icon': Icons.insert_drive_file, 'color': Colors.grey};

    final ext = fileName.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf':
        return {'icon': Icons.picture_as_pdf, 'color': Colors.red};
      case 'doc':
      case 'docx':
        return {'icon': Icons.description, 'color': Colors.blue};
      case 'xls':
      case 'xlsx':
        return {'icon': Icons.table_chart, 'color': Colors.green};
      case 'ppt':
      case 'pptx':
        return {'icon': Icons.slideshow, 'color': Colors.orange};
      case 'zip':
      case 'rar':
      case '7z':
        return {'icon': Icons.folder_zip, 'color': Colors.purple};
      case 'txt':
        return {'icon': Icons.text_snippet, 'color': Colors.blueGrey};
      default:
        return {'icon': Icons.insert_drive_file, 'color': Colors.grey};
    }
  }

  // Helper: Format file size
  String _formatFileSize(int? bytes) {
    if (bytes == null) return 'Unknown size';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // Helper: Format duration for voice messages
  String _formatDuration(int? seconds) {
    if (seconds == null) return '0:00';
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }

  // Helper: Extract URLs from message content
  List<String> _extractUrls(String content) {
    final urlPattern = RegExp(r'https?://[^\s]+', caseSensitive: false);
    return urlPattern.allMatches(content).map((m) => m.group(0)!).toList();
  }

  // Helper: Get time ago string
  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inDays > 365) return '${diff.inDays ~/ 365}y ago';
    if (diff.inDays > 30) return '${diff.inDays ~/ 30}mo ago';
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        scrolledUnderElevation: 2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text('Files & Links', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
        bottom: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          tabs: const [
            Tab(icon: Icon(Icons.photo), text: 'Media'),
            Tab(icon: Icon(Icons.insert_drive_file), text: 'Files'),
            Tab(icon: Icon(Icons.link), text: 'Links'),
            Tab(icon: Icon(Icons.mic), text: 'Voice'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Media Tab (Photos & Videos)
          _buildMediaTab(colors, textTheme),

          // Files Tab
          _buildFilesTab(colors, textTheme),

          // Links Tab
          _buildLinksTab(colors, textTheme),

          // Voice Tab
          _buildVoiceTab(colors, textTheme),
        ],
      ),
    );
  }

  // Media Tab Builder
  Widget _buildMediaTab(ColorScheme colors, TextTheme textTheme) {
    // Cache the types list to avoid provider recreation
    const types = ['IMAGE', 'VIDEO'];

    // Calculate date range based on filter
    DateTime? startDate;
    DateTime? endDate;
    final now = DateTime.now();

    switch (_selectedMediaFilter) {
      case 'Today':
        startDate = DateTime(now.year, now.month, now.day);
        endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
        break;
      case 'This Week':
        startDate = now.subtract(const Duration(days: 7));
        endDate = now;
        break;
      case 'This Month':
        startDate = now.subtract(const Duration(days: 30));
        endDate = now;
        break;
      case 'All':
      default:
        startDate = null;
        endDate = null;
    }

    // Fetch media from API with date filter
    final mediaAsync = ref.watch(
      conversationMediaProvider(
        int.parse(widget.conversationId),
        limit: 100,
        types: types,
        startDate: startDate,
        endDate: endDate,
      ),
    );

    return mediaAsync.when(
      data: (mediaItems) {
        if (mediaItems.isEmpty) {
          return Column(
            children: [
              // Filter button
              _buildFilterButton(
                context,
                colors,
                textTheme,
                _selectedMediaFilter,
                (filter) => setState(() => _selectedMediaFilter = filter),
              ),
              Expanded(
                child: _buildEmptyState(
                  icon: Icons.photo,
                  message: _selectedMediaFilter == 'All' ? 'No media yet' : 'No media in $_selectedMediaFilter',
                  colors: colors,
                  textTheme: textTheme,
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            // Filter button
            _buildFilterButton(
              context,
              colors,
              textTheme,
              _selectedMediaFilter,
              (filter) => setState(() => _selectedMediaFilter = filter),
            ),

            // Media grid (no need to filter again, API already filtered)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(4),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: mediaItems.length,
                itemBuilder: (context, index) {
                  final item = mediaItems[index];
                  final isVideo = item.type == 'VIDEO';
                  final imageUrl = item.thumbnailUrl ?? item.url;

                  return GestureDetector(
                    onTap: () {
                      // TODO: Open media viewer
                    },
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
                            child: const Center(child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40)),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colors.error),
            const SizedBox(height: 16),
            Text('Failed to load media', style: TextStyle(color: colors.error)),
          ],
        ),
      ),
    );
  }

  // Files Tab Builder
  Widget _buildFilesTab(ColorScheme colors, TextTheme textTheme) {
    final messagesAsync = ref.watch(messagesProvider(widget.conversationId));

    return messagesAsync.when(
      data: (messages) {
        // Extract file messages (type: FILE or messages with fileName but not IMAGE/VIDEO/AUDIO)
        final fileMessages = messages.where((msg) {
          if (msg.type.toUpperCase() == 'FILE') return true;
          if (msg.fileName != null && msg.fileName!.isNotEmpty) {
            final type = msg.type.toUpperCase();
            return type != 'IMAGE' && type != 'VIDEO' && type != 'AUDIO';
          }
          return false;
        }).toList();

        // Apply date filter
        final filteredFiles = _applyDateFilter(fileMessages, _selectedFilesFilter);

        if (filteredFiles.isEmpty) {
          return Column(
            children: [
              // Filter button
              _buildFilterButton(
                context,
                colors,
                textTheme,
                _selectedFilesFilter,
                (filter) => setState(() => _selectedFilesFilter = filter),
              ),
              Expanded(
                child: _buildEmptyState(
                  icon: Icons.folder_outlined,
                  message: filteredFiles.isEmpty && fileMessages.isNotEmpty
                      ? 'No files in $_selectedFilesFilter'
                      : 'No files shared yet',
                  colors: colors,
                  textTheme: textTheme,
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            // Filter button
            _buildFilterButton(
              context,
              colors,
              textTheme,
              _selectedFilesFilter,
              (filter) => setState(() => _selectedFilesFilter = filter),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredFiles.length,
                itemBuilder: (context, index) {
                  final msg = filteredFiles[index];
                  final iconData = _getFileIconAndColor(msg.fileName);

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: (iconData['color'] as Color).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(iconData['icon'] as IconData, color: iconData['color'] as Color),
                      ),
                      title: Text(
                        msg.fileName ?? 'Unknown file',
                        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        '${_formatFileSize(msg.fileSize)} • ${msg.senderFullName ?? msg.senderUsername ?? 'Unknown'} • ${_getTimeAgo(msg.createdAt)}',
                        style: textTheme.bodySmall,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.more_vert, color: colors.onSurface),
                        onPressed: () => _showFileOptionsFromMessage(context, msg, colors, textTheme),
                      ),
                      onTap: () async {
                        if (msg.mediaUrl != null) {
                          final uri = Uri.parse(msg.mediaUrl!);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          }
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colors.error),
            const SizedBox(height: 16),
            Text('Failed to load files', style: TextStyle(color: colors.error)),
          ],
        ),
      ),
    );
  }

  // Links Tab Builder
  Widget _buildLinksTab(ColorScheme colors, TextTheme textTheme) {
    final messagesAsync = ref.watch(messagesProvider(widget.conversationId));

    return messagesAsync.when(
      data: (messages) {
        // Extract messages with URLs in content
        final linkMessages = messages.where((msg) {
          final urls = _extractUrls(msg.content);
          return urls.isNotEmpty;
        }).toList();

        // Apply date filter
        final filteredLinks = _applyDateFilter(linkMessages, _selectedLinksFilter);

        if (filteredLinks.isEmpty) {
          return Column(
            children: [
              // Filter button
              _buildFilterButton(
                context,
                colors,
                textTheme,
                _selectedLinksFilter,
                (filter) => setState(() => _selectedLinksFilter = filter),
              ),
              Expanded(
                child: _buildEmptyState(
                  icon: Icons.link_outlined,
                  message: filteredLinks.isEmpty && linkMessages.isNotEmpty
                      ? 'No links in $_selectedLinksFilter'
                      : 'No links shared yet',
                  colors: colors,
                  textTheme: textTheme,
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            // Filter button
            _buildFilterButton(
              context,
              colors,
              textTheme,
              _selectedLinksFilter,
              (filter) => setState(() => _selectedLinksFilter = filter),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredLinks.length,
                itemBuilder: (context, index) {
                  final msg = filteredLinks[index];
                  final urls = _extractUrls(msg.content);
                  final url = urls.first;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: colors.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.link, color: colors.onPrimaryContainer),
                      ),
                      title: Text(
                        url,
                        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (msg.content != url)
                            Text(msg.content, style: textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text(
                            '${msg.senderFullName ?? msg.senderUsername ?? 'Unknown'} • ${_getTimeAgo(msg.createdAt)}',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.open_in_new, color: colors.primary),
                        onPressed: () async {
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          }
                        },
                      ),
                      onTap: () async {
                        final uri = Uri.parse(url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colors.error),
            const SizedBox(height: 16),
            Text('Failed to load links', style: TextStyle(color: colors.error)),
          ],
        ),
      ),
    );
  }

  // Voice Tab Builder
  Widget _buildVoiceTab(ColorScheme colors, TextTheme textTheme) {
    final messagesAsync = ref.watch(messagesProvider(widget.conversationId));

    return messagesAsync.when(
      data: (messages) {
        // Extract voice/audio messages
        final voiceMessages = messages.where((msg) {
          return msg.type.toUpperCase() == 'AUDIO' || msg.type.toUpperCase() == 'VOICE';
        }).toList();

        // Apply date filter
        final filteredVoice = _applyDateFilter(voiceMessages, _selectedVoiceFilter);

        if (filteredVoice.isEmpty) {
          return Column(
            children: [
              // Filter button
              _buildFilterButton(
                context,
                colors,
                textTheme,
                _selectedVoiceFilter,
                (filter) => setState(() => _selectedVoiceFilter = filter),
              ),
              Expanded(
                child: _buildEmptyState(
                  icon: Icons.mic,
                  message: filteredVoice.isEmpty && voiceMessages.isNotEmpty
                      ? 'No voice messages in $_selectedVoiceFilter'
                      : 'No voice messages yet',
                  colors: colors,
                  textTheme: textTheme,
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            // Filter button
            _buildFilterButton(
              context,
              colors,
              textTheme,
              _selectedVoiceFilter,
              (filter) => setState(() => _selectedVoiceFilter = filter),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredVoice.length,
                itemBuilder: (context, index) {
                  final msg = filteredVoice[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: colors.primaryContainer,
                        child: Icon(Icons.mic, color: colors.onPrimaryContainer),
                      ),
                      title: Text(
                        msg.senderFullName ?? msg.senderUsername ?? 'Unknown',
                        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text('${_formatDuration(msg.duration)} • ${_getTimeAgo(msg.createdAt)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: () async {
                          if (msg.mediaUrl != null) {
                            final uri = Uri.parse(msg.mediaUrl!);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri, mode: LaunchMode.externalApplication);
                            }
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: colors.error),
            const SizedBox(height: 16),
            Text('Failed to load voice messages', style: TextStyle(color: colors.error)),
          ],
        ),
      ),
    );
  }

  // Helper: Apply date filter to messages
  List<dynamic> _applyDateFilter(List<dynamic> messages, String filter) {
    final now = DateTime.now();

    switch (filter) {
      case 'Today':
        return messages.where((msg) {
          final diff = now.difference(msg.createdAt);
          return diff.inDays == 0;
        }).toList();

      case 'This Week':
        return messages.where((msg) {
          final diff = now.difference(msg.createdAt);
          return diff.inDays <= 7;
        }).toList();

      case 'This Month':
        return messages.where((msg) {
          final diff = now.difference(msg.createdAt);
          return diff.inDays <= 30;
        }).toList();

      case 'All':
      default:
        return messages;
    }
  }

  // Helper: Build filter button
  Widget _buildFilterButton(
    BuildContext context,
    ColorScheme colors,
    TextTheme textTheme,
    String selectedFilter,
    Function(String) onFilterChanged,
  ) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: colors.shadow.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () async {
            final result = await showMediaDateFilterBottomSheet(context);
            if (result != null) {
              onFilterChanged(result['filter'] ?? 'All');
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.filter_list, size: 20, color: colors.primary),
                const SizedBox(width: 8),
                Text(
                  'Filter: $selectedFilter',
                  style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: colors.primary),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_drop_down, size: 20, color: colors.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String message,
    required ColorScheme colors,
    required TextTheme textTheme,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: colors.onSurface.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text(message, style: textTheme.bodyLarge?.copyWith(color: colors.onSurface.withValues(alpha: 0.6))),
        ],
      ),
    );
  }

  // Unused old method - kept for reference
  // ignore: unused_element
  void _showFileOptions(BuildContext context, Map<String, dynamic> file, ColorScheme colors, TextTheme textTheme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 20),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: Icon(Icons.download, color: colors.onSurface),
              title: Text('Download', style: textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement download
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: colors.onSurface),
              title: Text('Share', style: textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement share
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: colors.onSurface),
              title: Text('File Info', style: textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // TODO: Show file info
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showFileOptionsFromMessage(BuildContext context, dynamic message, ColorScheme colors, TextTheme textTheme) {
    final options = <BottomSheetOption>[
      BottomSheetOption(
        icon: Icons.open_in_new,
        label: 'Open File',
        onTap: () async {
          if (message.mediaUrl != null) {
            final uri = Uri.parse(message.mediaUrl!);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          }
        },
      ),
      BottomSheetOption(
        icon: Icons.download,
        label: 'Download',
        onTap: () {
          // TODO: Implement download
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  Text('Download coming soon', style: TextStyle(color: Colors.white)),
                ],
              ),
              backgroundColor: Colors.grey.shade900,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
        },
      ),
      BottomSheetOption(
        icon: Icons.share,
        label: 'Share',
        onTap: () {
          // TODO: Implement share
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  Text('Share coming soon', style: TextStyle(color: Colors.white)),
                ],
              ),
              backgroundColor: Colors.grey.shade900,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          );
        },
      ),
      BottomSheetOption(
        icon: Icons.info_outline,
        label: 'File Info',
        onTap: () => _showFileInfoDialog(context, message, colors, textTheme),
      ),
    ];

    showOptionsBottomSheet(context: context, title: 'File Options', options: options);
  }

  void _showFileInfoDialog(BuildContext context, dynamic message, ColorScheme colors, TextTheme textTheme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('File Info'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${message.fileName ?? 'Unknown'}'),
            const SizedBox(height: 8),
            Text('Size: ${_formatFileSize(message.fileSize)}'),
            const SizedBox(height: 8),
            Text('Sender: ${message.senderFullName ?? message.senderUsername ?? 'Unknown'}'),
            const SizedBox(height: 8),
            Text('Date: ${_getTimeAgo(message.createdAt)}'),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }

  // Unused old method - kept for reference
  // ignore: unused_element
  void _showLinkOptions(BuildContext context, Map<String, dynamic> link, ColorScheme colors, TextTheme textTheme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 20),
              decoration: BoxDecoration(
                color: colors.onSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: Icon(Icons.open_in_new, color: colors.onSurface),
              title: Text('Open Link', style: textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // TODO: Open link
              },
            ),
            ListTile(
              leading: Icon(Icons.copy, color: colors.onSurface),
              title: Text('Copy Link', style: textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // TODO: Copy to clipboard
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: colors.onSurface),
              title: Text('Share', style: textTheme.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement share
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
