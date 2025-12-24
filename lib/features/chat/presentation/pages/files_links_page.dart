import 'package:chattrix_ui/features/chat/presentation/widgets/media_date_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FilesLinksPage extends StatefulWidget {
  const FilesLinksPage({super.key, required this.conversationId});

  final String conversationId;

  @override
  State<FilesLinksPage> createState() => _FilesLinksPageState();
}

class _FilesLinksPageState extends State<FilesLinksPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedMediaFilter = 'All'; // All, Today, This Week, This Month

  // Hardcoded files for demo
  final List<Map<String, dynamic>> _files = [
    {
      'name': 'Project_Proposal.pdf',
      'size': '2.4 MB',
      'date': '2 days ago',
      'sender': 'John Doe',
      'icon': Icons.picture_as_pdf,
      'color': Colors.red,
    },
    {
      'name': 'Budget_2024.xlsx',
      'size': '1.2 MB',
      'date': '5 days ago',
      'sender': 'Jane Smith',
      'icon': Icons.table_chart,
      'color': Colors.green,
    },
    {
      'name': 'Meeting_Notes.docx',
      'size': '856 KB',
      'date': '1 week ago',
      'sender': 'Bob Johnson',
      'icon': Icons.description,
      'color': Colors.blue,
    },
    {
      'name': 'Team_Photo.jpg',
      'size': '3.1 MB',
      'date': '2 weeks ago',
      'sender': 'Alice Brown',
      'icon': Icons.image,
      'color': Colors.orange,
    },
  ];

  // Hardcoded links for demo
  final List<Map<String, dynamic>> _links = [
    {
      'url': 'https://github.com/chattrix/project',
      'title': 'GitHub Repository',
      'sender': 'John Doe',
      'date': '1 day ago',
    },
    {
      'url': 'https://docs.google.com/document/d/abc123',
      'title': 'Shared Document',
      'sender': 'Jane Smith',
      'date': '3 days ago',
    },
    {
      'url': 'https://www.figma.com/file/design123',
      'title': 'Design Mockups',
      'sender': 'Bob Johnson',
      'date': '1 week ago',
    },
    {
      'url': 'https://youtube.com/watch?v=abc',
      'title': 'Tutorial Video',
      'sender': 'Alice Brown',
      'date': '2 weeks ago',
    },
  ];

  // Demo media items
  final List<Map<String, dynamic>> _mediaItems = List.generate(
    20,
    (index) => {
      'id': 'media_$index',
      'url': 'https://picsum.photos/200/200?random=$index',
      'type': index % 3 == 0 ? 'video' : 'image',
      'date': '${index + 1}d ago',
    },
  );

  // Demo voice messages
  final List<Map<String, dynamic>> _voiceMessages = [
    {
      'id': '1',
      'duration': '0:45',
      'sender': 'John Doe',
      'date': '1h ago',
    },
    {
      'id': '2',
      'duration': '1:23',
      'sender': 'Jane Smith',
      'date': '1d ago',
    },
    {
      'id': '3',
      'duration': '0:32',
      'sender': 'Bob Johnson',
      'date': '3d ago',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        title: Text(
          'Files & Links',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
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
          _files.isEmpty
              ? _buildEmptyState(
                  icon: Icons.folder_outlined,
                  message: 'No files shared yet',
                  colors: colors,
                  textTheme: textTheme,
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _files.length,
                  itemBuilder: (context, index) {
                    final file = _files[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: (file['color'] as Color).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            file['icon'] as IconData,
                            color: file['color'] as Color,
                          ),
                        ),
                        title: Text(
                          file['name'],
                          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${file['size']} • ${file['sender']} • ${file['date']}',
                          style: textTheme.bodySmall,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.more_vert, color: colors.onSurface),
                          onPressed: () => _showFileOptions(context, file, colors, textTheme),
                        ),
                        onTap: () {
                          // TODO: Open file
                        },
                      ),
                    );
                  },
                ),

          // Links Tab
          _links.isEmpty
              ? _buildEmptyState(
                  icon: Icons.link_outlined,
                  message: 'No links shared yet',
                  colors: colors,
                  textTheme: textTheme,
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _links.length,
                  itemBuilder: (context, index) {
                    final link = _links[index];
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
                          link['title'],
                          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              link['url'],
                              style: textTheme.bodySmall?.copyWith(color: colors.primary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${link['sender']} • ${link['date']}',
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.more_vert, color: colors.onSurface),
                          onPressed: () => _showLinkOptions(context, link, colors, textTheme),
                        ),
                        onTap: () {
                          // TODO: Open link
                        },
                      ),
                    );
                  },
                ),

          // Voice Tab
          _buildVoiceTab(colors, textTheme),
        ],
      ),
    );
  }

  // Media Tab Builder
  Widget _buildMediaTab(ColorScheme colors, TextTheme textTheme) {
    if (_mediaItems.isEmpty) {
      return _buildEmptyState(
        icon: Icons.photo,
        message: 'No media yet',
        colors: colors,
        textTheme: textTheme,
      );
    }

    // Filter media items based on selected filter
    final filteredItems = _getFilteredMediaItems();

    return Column(
      children: [
        // Filter button (Messenger style rounded)
        Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: colors.shadow.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () async {
                final result = await showMediaDateFilterBottomSheet(context);
                if (result != null) {
                  setState(() {
                    _selectedMediaFilter = result['filter'] ?? 'All';
                  });
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
                      'Filter: $_selectedMediaFilter',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.primary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, size: 20, color: colors.primary),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Media grid
        Expanded(
          child: filteredItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo, size: 64, color: colors.onSurface.withValues(alpha: 0.3)),
                      const SizedBox(height: 16),
                      Text(
                        'No media in $_selectedMediaFilter',
                        style: TextStyle(color: colors.onSurface.withValues(alpha: 0.5)),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(4),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return GestureDetector(
                      onTap: () {
                        // TODO: Open media viewer
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            item['url'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: colors.surfaceContainerHighest,
                                child: Icon(Icons.broken_image, color: colors.onSurface.withValues(alpha: 0.3)),
                              );
                            },
                          ),
                          if (item['type'] == 'video')
                            Container(
                              color: Colors.black26,
                              child: const Center(
                                child: Icon(Icons.play_circle_outline, color: Colors.white, size: 40),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, ColorScheme colors) {
    final isSelected = _selectedMediaFilter == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedMediaFilter = label;
        });
      },
      backgroundColor: colors.surfaceContainerHighest,
      selectedColor: colors.primaryContainer,
      checkmarkColor: colors.onPrimaryContainer,
      labelStyle: TextStyle(
        color: isSelected ? colors.onPrimaryContainer : colors.onSurface,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  List<Map<String, dynamic>> _getFilteredMediaItems() {
    final now = DateTime.now();

    switch (_selectedMediaFilter) {
      case 'Today':
        return _mediaItems.where((item) {
          final daysAgo = int.parse(item['date'].replaceAll('d ago', ''));
          return daysAgo == 0;
        }).toList();

      case 'This Week':
        return _mediaItems.where((item) {
          final daysAgo = int.parse(item['date'].replaceAll('d ago', ''));
          return daysAgo <= 7;
        }).toList();

      case 'This Month':
        return _mediaItems.where((item) {
          final daysAgo = int.parse(item['date'].replaceAll('d ago', ''));
          return daysAgo <= 30;
        }).toList();

      case 'All':
      default:
        return _mediaItems;
    }
  }

  // Voice Tab Builder
  Widget _buildVoiceTab(ColorScheme colors, TextTheme textTheme) {
    if (_voiceMessages.isEmpty) {
      return _buildEmptyState(
        icon: Icons.mic,
        message: 'No voice messages yet',
        colors: colors,
        textTheme: textTheme,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _voiceMessages.length,
      itemBuilder: (context, index) {
        final voice = _voiceMessages[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: colors.primaryContainer,
              child: Icon(Icons.mic, color: colors.onPrimaryContainer),
            ),
            title: Text(
              voice['sender'],
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('${voice['duration']} • ${voice['date']}'),
            trailing: IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {
                // TODO: Play voice message
              },
            ),
          ),
        );
      },
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
          Text(
            message,
            style: textTheme.bodyLarge?.copyWith(color: colors.onSurface.withValues(alpha: 0.6)),
          ),
        ],
      ),
    );
  }

  void _showFileOptions(
    BuildContext context,
    Map<String, dynamic> file,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
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

  void _showLinkOptions(
    BuildContext context,
    Map<String, dynamic> link,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
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

