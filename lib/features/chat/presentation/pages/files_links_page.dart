import 'package:chattrix_ui/features/chat/presentation/providers/media_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/media_date_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class FilesLinksPage extends ConsumerStatefulWidget {
  const FilesLinksPage({super.key, required this.conversationId});

  final int conversationId;

  @override
  ConsumerState<FilesLinksPage> createState() => _FilesLinksPageState();
}

class _FilesLinksPageState extends ConsumerState<FilesLinksPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedMediaFilter = 'All'; // All, Today, This Week, This Month
  String _selectedFilesFilter = 'All';
  String _selectedLinksFilter = 'All';
  String _selectedAudioFilter = 'All';
  
  // Custom date ranges for each tab
  DateTime? _customMediaStartDate;
  DateTime? _customMediaEndDate;
  DateTime? _customFilesStartDate;
  DateTime? _customFilesEndDate;
  DateTime? _customLinksStartDate;
  DateTime? _customLinksEndDate;
  DateTime? _customAudioStartDate;
  DateTime? _customAudioEndDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

  // Helper: Format duration for audio
  String _formatDuration(int? seconds) {
    if (seconds == null) return '0:00';
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
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

  // Helper: Calculate date range based on filter
  Map<String, DateTime?> _getDateRange(String filter, {DateTime? customStart, DateTime? customEnd}) {
    DateTime? startDate;
    DateTime? endDate;
    final now = DateTime.now();

    switch (filter) {
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
      case 'This Year':
        startDate = DateTime(now.year, 1, 1);
        endDate = now;
        break;
      case 'Custom':
        startDate = customStart;
        endDate = customEnd;
        break;
      case 'All':
      default:
        startDate = null;
        endDate = null;
    }

    return {'startDate': startDate, 'endDate': endDate};
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.15),
        scrolledUnderElevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.onSurface),
          onPressed: () => context.pop(),
        ),
        title: Text('Files & Links', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(49),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                tabs: const [
                  Tab(icon: Icon(Icons.photo, size: 20), text: 'Media'),
                  Tab(icon: Icon(Icons.insert_drive_file, size: 20), text: 'Files'),
                  Tab(icon: Icon(Icons.link, size: 20), text: 'Links'),
                  Tab(icon: Icon(Icons.mic, size: 20), text: 'Audio'),
                ],
              ),
              Container(
                height: 0.5,
                color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Media Tab (Photos & Videos)
          _buildMediaTab(colors, textTheme, isDark),

          // Files Tab
          _buildFilesTab(colors, textTheme, isDark),

          // Links Tab
          _buildLinksTab(colors, textTheme, isDark),

          // Audio Tab
          _buildAudioTab(colors, textTheme, isDark),
        ],
      ),
    );
  }

  // Media Tab Builder
  Widget _buildMediaTab(ColorScheme colors, TextTheme textTheme, bool isDark) {
    const types = ['IMAGE', 'VIDEO'];
    final dateRange = _getDateRange(
      _selectedMediaFilter,
      customStart: _customMediaStartDate,
      customEnd: _customMediaEndDate,
    );

    debugPrint('🔍 Media Tab - Filter: $_selectedMediaFilter');
    debugPrint('🔍 Media Tab - Custom Start: $_customMediaStartDate');
    debugPrint('🔍 Media Tab - Custom End: $_customMediaEndDate');
    debugPrint('🔍 Media Tab - Date Range Start: ${dateRange['startDate']}');
    debugPrint('🔍 Media Tab - Date Range End: ${dateRange['endDate']}');

    final mediaAsync = ref.watch(
      conversationMediaProvider(
        widget.conversationId,
        limit: 100,
        types: types,
        startDate: dateRange['startDate'],
        endDate: dateRange['endDate'],
      ),
    );

    return mediaAsync.when(
      data: (result) {
        final mediaItems = result.messages;

        if (mediaItems.isEmpty) {
          return Column(
            children: [
              _buildFilterButton(
                context,
                colors,
                textTheme,
                _selectedMediaFilter,
                (filter) => setState(() => _selectedMediaFilter = filter),
                onCustomDateSelected: (startDate, endDate) {
                  setState(() {
                    _customMediaStartDate = startDate;
                    _customMediaEndDate = endDate;
                  });
                },
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
            _buildFilterButton(
              context,
              colors,
              textTheme,
              _selectedMediaFilter,
              (filter) => setState(() => _selectedMediaFilter = filter),
              onCustomDateSelected: (startDate, endDate) {
                setState(() {
                  _customMediaStartDate = startDate;
                  _customMediaEndDate = endDate;
                });
              },
            ),
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
                  final imageUrl = item.metadata?.thumbnailUrl ?? item.metadata?.mediaUrl;

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
  Widget _buildFilesTab(ColorScheme colors, TextTheme textTheme, bool isDark) {
    const types = ['FILE'];
    final dateRange = _getDateRange(
      _selectedFilesFilter,
      customStart: _customFilesStartDate,
      customEnd: _customFilesEndDate,
    );

    final filesAsync = ref.watch(
      conversationMediaProvider(
        widget.conversationId,
        limit: 100,
        types: types,
        startDate: dateRange['startDate'],
        endDate: dateRange['endDate'],
      ),
    );

    return filesAsync.when(
      data: (result) {
        final fileItems = result.messages;

        if (fileItems.isEmpty) {
          return Column(
            children: [
              _buildFilterButton(
                context,
                colors,
                textTheme,
                _selectedFilesFilter,
                (filter) => setState(() => _selectedFilesFilter = filter),
                onCustomDateSelected: (startDate, endDate) {
                  setState(() {
                    _customFilesStartDate = startDate;
                    _customFilesEndDate = endDate;
                  });
                },
              ),
              Expanded(
                child: _buildEmptyState(
                  icon: Icons.folder_outlined,
                  message: _selectedFilesFilter == 'All' ? 'No files shared yet' : 'No files in $_selectedFilesFilter',
                  colors: colors,
                  textTheme: textTheme,
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            _buildFilterButton(
              context,
              colors,
              textTheme,
              _selectedFilesFilter,
              (filter) => setState(() => _selectedFilesFilter = filter),
              onCustomDateSelected: (startDate, endDate) {
                setState(() {
                  _customFilesStartDate = startDate;
                  _customFilesEndDate = endDate;
                });
              },
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: fileItems.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  thickness: 0.5,
                  color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
                ),
                itemBuilder: (context, index) {
                  final item = fileItems[index];
                  final iconData = _getFileIconAndColor(item.metadata?.fileName);

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
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
                      item.metadata?.fileName ?? 'Unknown file',
                      style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '${_formatFileSize(item.metadata?.fileSize)} • ${item.senderFullName ?? item.senderUsername ?? 'Unknown'} • ${_getTimeAgo(item.createdAt)}',
                      style: textTheme.bodySmall,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.open_in_new, color: colors.primary),
                      onPressed: () async {
                        final url = item.metadata?.mediaUrl;
                        if (url != null) {
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri, mode: LaunchMode.externalApplication);
                          }
                        }
                      },
                    ),
                    onTap: () async {
                      final url = item.metadata?.mediaUrl;
                      if (url != null) {
                        final uri = Uri.parse(url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      }
                    },
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
  Widget _buildLinksTab(ColorScheme colors, TextTheme textTheme, bool isDark) {
    const types = ['LINK'];
    final dateRange = _getDateRange(
      _selectedLinksFilter,
      customStart: _customLinksStartDate,
      customEnd: _customLinksEndDate,
    );

    final linksAsync = ref.watch(
      conversationMediaProvider(
        widget.conversationId,
        limit: 100,
        types: types,
        startDate: dateRange['startDate'],
        endDate: dateRange['endDate'],
      ),
    );

    return linksAsync.when(
      data: (result) {
        final linkItems = result.messages;

        if (linkItems.isEmpty) {
          return Column(
            children: [
              _buildFilterButton(
                context,
                colors,
                textTheme,
                _selectedLinksFilter,
                (filter) => setState(() => _selectedLinksFilter = filter),
                onCustomDateSelected: (startDate, endDate) {
                  setState(() {
                    _customLinksStartDate = startDate;
                    _customLinksEndDate = endDate;
                  });
                },
              ),
              Expanded(
                child: _buildEmptyState(
                  icon: Icons.link_outlined,
                  message: _selectedLinksFilter == 'All' ? 'No links shared yet' : 'No links in $_selectedLinksFilter',
                  colors: colors,
                  textTheme: textTheme,
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            _buildFilterButton(
              context,
              colors,
              textTheme,
              _selectedLinksFilter,
              (filter) => setState(() => _selectedLinksFilter = filter),
              onCustomDateSelected: (startDate, endDate) {
                setState(() {
                  _customLinksStartDate = startDate;
                  _customLinksEndDate = endDate;
                });
              },
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: linkItems.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  thickness: 0.5,
                  color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
                ),
                itemBuilder: (context, index) {
                  final item = linkItems[index];
                  final url = item.metadata?.url ?? item.content;
                  final title = item.metadata?.title;
                  final description = item.metadata?.description;

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
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
                      title ?? url,
                      style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (description != null)
                          Text(description, style: textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                        Text(
                          '${item.senderFullName ?? item.senderUsername ?? 'Unknown'} • ${_getTimeAgo(item.createdAt)}',
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

  // Audio Tab Builder
  Widget _buildAudioTab(ColorScheme colors, TextTheme textTheme, bool isDark) {
    const types = ['AUDIO'];
    final dateRange = _getDateRange(
      _selectedAudioFilter,
      customStart: _customAudioStartDate,
      customEnd: _customAudioEndDate,
    );

    final audioAsync = ref.watch(
      conversationMediaProvider(
        widget.conversationId,
        limit: 100,
        types: types,
        startDate: dateRange['startDate'],
        endDate: dateRange['endDate'],
      ),
    );

    return audioAsync.when(
      data: (result) {
        final audioItems = result.messages;

        if (audioItems.isEmpty) {
          return Column(
            children: [
              _buildFilterButton(
                context,
                colors,
                textTheme,
                _selectedAudioFilter,
                (filter) => setState(() => _selectedAudioFilter = filter),
                onCustomDateSelected: (startDate, endDate) {
                  setState(() {
                    _customAudioStartDate = startDate;
                    _customAudioEndDate = endDate;
                  });
                },
              ),
              Expanded(
                child: _buildEmptyState(
                  icon: Icons.mic,
                  message: _selectedAudioFilter == 'All' ? 'No audio messages yet' : 'No audio in $_selectedAudioFilter',
                  colors: colors,
                  textTheme: textTheme,
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            _buildFilterButton(
              context,
              colors,
              textTheme,
              _selectedAudioFilter,
              (filter) => setState(() => _selectedAudioFilter = filter),
              onCustomDateSelected: (startDate, endDate) {
                setState(() {
                  _customAudioStartDate = startDate;
                  _customAudioEndDate = endDate;
                });
              },
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: audioItems.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  thickness: 0.5,
                  color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
                ),
                itemBuilder: (context, index) {
                  final item = audioItems[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: colors.primaryContainer,
                      child: Icon(Icons.mic, color: colors.onPrimaryContainer),
                    ),
                    title: Text(
                      item.senderFullName ?? item.senderUsername ?? 'Unknown',
                      style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text('${_formatDuration(item.metadata?.duration)} • ${_getTimeAgo(item.createdAt)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () async {
                        final url = item.metadata?.mediaUrl;
                        if (url != null) {
                          final uri = Uri.parse(url);
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
            Text('Failed to load audio', style: TextStyle(color: colors.error)),
          ],
        ),
      ),
    );
  }

  // Helper: Build filter button
  Widget _buildFilterButton(
    BuildContext context,
    ColorScheme colors,
    TextTheme textTheme,
    String selectedFilter,
    Function(String) onFilterChanged, {
    Function(DateTime?, DateTime?)? onCustomDateSelected,
  }) {
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
            debugPrint('🎯 Filter button tapped');
            final result = await showMediaDateFilterBottomSheet(context);
            debugPrint('🎯 Filter result: $result');
            
            if (result != null) {
              final selectedFilter = result['filter'] ?? 'All';
              debugPrint('🎯 Selected filter: $selectedFilter');
              
              onFilterChanged(selectedFilter);
              
              // If custom date range selected, notify parent
              if (selectedFilter == 'Custom' && onCustomDateSelected != null) {
                debugPrint('🎯 Setting custom dates: ${result['startDate']} - ${result['endDate']}');
                onCustomDateSelected(result['startDate'], result['endDate']);
              } else if (onCustomDateSelected != null) {
                // Clear custom dates when selecting non-custom filter
                debugPrint('🎯 Clearing custom dates');
                onCustomDateSelected(null, null);
              }
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
}
