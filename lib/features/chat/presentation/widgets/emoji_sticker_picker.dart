import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../services/giphy_provider.dart';

/// Emoji and Sticker Picker Widget
///
/// Features:
/// - Tab view: Emoji | Stickers
/// - Emoji categories: Smileys, Animals, Food, Activities, Travel, Objects, Symbols
/// - Sticker packs from Giphy API
/// - Search functionality
/// - Recent emojis/stickers
class EmojiStickerPicker extends HookConsumerWidget {
  final Function(String emoji) onEmojiSelected;
  final Function(String stickerUrl) onStickerSelected;
  final Color? backgroundColor;
  final Color? iconColor;

  const EmojiStickerPicker({
    super.key,
    required this.onEmojiSelected,
    required this.onStickerSelected,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);
    final selectedEmojiCategory = useState(0);
    final selectedStickerCategory = useState('trending');
    final searchController = useTextEditingController();
    final searchQuery = useState('');

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = backgroundColor ?? (isDark ? const Color(0xFF1C1C1E) : Colors.white);
    final iconColor = this.iconColor ?? theme.colorScheme.primary;

    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tab bar
          TabBar(
            controller: tabController,
            indicatorColor: iconColor,
            labelColor: iconColor,
            unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
            tabs: const [
              Tab(text: 'Emoji', icon: Icon(Icons.emoji_emotions_outlined, size: 20)),
              Tab(text: 'Stickers', icon: Icon(Icons.sticky_note_2_outlined, size: 20)),
            ],
          ),

          // Tab view
          SizedBox(
            height: 280,
            child: TabBarView(
              controller: tabController,
              children: [
                _EmojiTab(
                  selectedCategory: selectedEmojiCategory,
                  onEmojiSelected: onEmojiSelected,
                  isDark: isDark,
                  iconColor: iconColor,
                ),
                _StickerTab(
                  selectedCategory: selectedStickerCategory,
                  searchController: searchController,
                  searchQuery: searchQuery,
                  onStickerSelected: onStickerSelected,
                  isDark: isDark,
                  iconColor: iconColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Emoji Only Picker Widget (No tabs)
class EmojiOnlyPicker extends HookConsumerWidget {
  final Function(String emoji) onEmojiSelected;
  final Color? backgroundColor;
  final Color? iconColor;

  const EmojiOnlyPicker({super.key, required this.onEmojiSelected, this.backgroundColor, this.iconColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEmojiCategory = useState(0);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = backgroundColor ?? (isDark ? const Color(0xFF1C1C1E) : Colors.white);
    final iconColor = this.iconColor ?? theme.colorScheme.primary;

    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: _EmojiTab(
        selectedCategory: selectedEmojiCategory,
        onEmojiSelected: onEmojiSelected,
        isDark: isDark,
        iconColor: iconColor,
      ),
    );
  }
}

/// Sticker Only Picker Widget (No tabs)
class StickerOnlyPicker extends HookConsumerWidget {
  final Function(String stickerUrl) onStickerSelected;
  final Color? backgroundColor;
  final Color? iconColor;

  const StickerOnlyPicker({super.key, required this.onStickerSelected, this.backgroundColor, this.iconColor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedStickerCategory = useState('trending');
    final searchController = useTextEditingController();
    final searchQuery = useState('');

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = backgroundColor ?? (isDark ? const Color(0xFF1C1C1E) : Colors.white);
    final iconColor = this.iconColor ?? theme.colorScheme.primary;

    return Container(
      decoration: BoxDecoration(color: bgColor),
      child: _StickerTab(
        selectedCategory: selectedStickerCategory,
        searchController: searchController,
        searchQuery: searchQuery,
        onStickerSelected: onStickerSelected,
        isDark: isDark,
        iconColor: iconColor,
      ),
    );
  }
}

// ============================================================================
// EMOJI TAB
// ============================================================================
class _EmojiTab extends StatelessWidget {
  final ValueNotifier<int> selectedCategory;
  final Function(String) onEmojiSelected;
  final bool isDark;
  final Color iconColor;

  const _EmojiTab({
    required this.selectedCategory,
    required this.onEmojiSelected,
    required this.isDark,
    required this.iconColor,
  });

  static const List<String> _emojiCategories = [
    'Smileys',
    'Animals',
    'Food',
    'Activities',
    'Travel',
    'Objects',
    'Symbols',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Category selector
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _emojiCategories.length,
            itemBuilder: (context, index) {
              return ValueListenableBuilder<int>(
                valueListenable: selectedCategory,
                builder: (context, selected, _) {
                  final isSelected = selected == index;
                  return GestureDetector(
                    onTap: () => selectedCategory.value = index,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? iconColor.withValues(alpha: 0.1)
                            : (isDark ? Colors.grey[800] : Colors.grey[200]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _emojiCategories[index],
                        style: TextStyle(
                          color: isSelected ? iconColor : (isDark ? Colors.grey[400] : Colors.grey[700]),
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        // Emoji grid
        Expanded(
          child: ValueListenableBuilder<int>(
            valueListenable: selectedCategory,
            builder: (context, category, _) {
              final emojis = _getEmojisForCategory(category);
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: emojis.length,
                itemBuilder: (context, index) {
                  final emoji = emojis[index];
                  return GestureDetector(
                    onTap: () => onEmojiSelected(emoji),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(emoji, style: const TextStyle(fontSize: 28)),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  static List<String> _getEmojisForCategory(int categoryIndex) {
    // Comprehensive emoji lists by category
    switch (categoryIndex) {
      case 0: // Smileys
        return [
          '😀',
          '😃',
          '😄',
          '😁',
          '😆',
          '😅',
          '🤣',
          '😂',
          '🙂',
          '🙃',
          '😉',
          '😊',
          '😇',
          '🥰',
          '😍',
          '🤩',
          '😘',
          '😗',
          '😚',
          '😙',
          '😋',
          '😛',
          '😜',
          '🤪',
          '😝',
          '🤑',
          '🤗',
          '🤭',
          '🤫',
          '🤔',
          '🤐',
          '🤨',
          '😐',
          '😑',
          '😶',
          '😏',
          '😒',
          '🙄',
          '😬',
          '🤥',
          '😌',
          '😔',
          '😪',
          '🤤',
          '😴',
          '😷',
          '🤒',
          '🤕',
          '🤢',
          '🤮',
          '🤧',
          '🥵',
          '🥶',
          '🥴',
          '😵',
          '🤯',
          '🤠',
          '🥳',
          '😎',
          '🤓',
          '🧐',
          '😕',
          '😟',
          '🙁',
          '☹️',
          '😮',
          '😯',
          '😲',
          '😳',
          '🥺',
          '😦',
          '😧',
          '😨',
          '😰',
          '😥',
          '😢',
          '😭',
          '😱',
          '😖',
          '😣',
          '😞',
          '😓',
          '😩',
          '😫',
          '🥱',
          '😤',
          '😡',
          '😠',
          '🤬',
          '😈',
          '👿',
          '💀',
          '☠️',
          '💩',
          '🤡',
          '👹',
        ];
      case 1: // Animals
        return [
          '🐶',
          '🐱',
          '🐭',
          '🐹',
          '🐰',
          '🦊',
          '🐻',
          '🐼',
          '🐨',
          '🐯',
          '🦁',
          '🐮',
          '🐷',
          '🐽',
          '🐸',
          '🐵',
          '🙈',
          '🙉',
          '🙊',
          '🐒',
          '🐔',
          '🐧',
          '🐦',
          '🐤',
          '🐣',
          '🐥',
          '🦆',
          '🦅',
          '🦉',
          '🦇',
          '🐺',
          '🐗',
          '🐴',
          '🦄',
          '🐝',
          '🐛',
          '🦋',
          '🐌',
          '🐞',
          '🐜',
          '🦟',
          '🦗',
          '🕷️',
          '🕸️',
          '🦂',
          '🐢',
          '🐍',
          '🦎',
          '🦖',
          '🦕',
          '🐙',
          '🦑',
          '🦐',
          '🦞',
          '🦀',
          '🐡',
          '🐠',
          '🐟',
          '🐬',
          '🐳',
          '🐋',
          '🦈',
          '🐊',
          '🐅',
        ];
      case 2: // Food
        return [
          '🍏',
          '🍎',
          '🍐',
          '🍊',
          '🍋',
          '🍌',
          '🍉',
          '🍇',
          '🍓',
          '🍈',
          '🍒',
          '🍑',
          '🥭',
          '🍍',
          '🥥',
          '🥝',
          '🍅',
          '🍆',
          '🥑',
          '🥦',
          '🥬',
          '🥒',
          '🌶️',
          '🌽',
          '🥕',
          '🥔',
          '🍠',
          '🥐',
          '🥯',
          '🍞',
          '🥖',
          '🥨',
          '🧀',
          '🥚',
          '🍳',
          '🧈',
          '🥞',
          '🧇',
          '🥓',
          '🥩',
          '🍗',
          '🍖',
          '🦴',
          '🌭',
          '🍔',
          '🍟',
          '🍕',
          '🥪',
          '🥙',
          '🧆',
          '🌮',
          '🌯',
          '🥗',
          '🥘',
          '🥫',
          '🍝',
          '🍜',
          '🍲',
          '🍛',
          '🍣',
          '🍱',
          '🥟',
          '🦪',
          '🍤',
        ];
      case 3: // Activities
        return [
          '⚽',
          '🏀',
          '🏈',
          '⚾',
          '🥎',
          '🎾',
          '🏐',
          '🏉',
          '🥏',
          '🎱',
          '🪀',
          '🏓',
          '🏸',
          '🏒',
          '🏑',
          '🥍',
          '🏏',
          '🥅',
          '⛳',
          '🪁',
          '🏹',
          '🎣',
          '🤿',
          '🥊',
          '🥋',
          '🎽',
          '🛹',
          '🛼',
          '🛷',
          '⛸️',
          '🥌',
          '🎿',
          '⛷️',
          '🏂',
          '🪂',
          '🏋️',
          '🤼',
          '🤸',
          '🤺',
          '⛹️',
          '🤾',
          '🏌️',
          '🏇',
          '🧘',
          '🏊',
          '🤽',
          '🚣',
          '🧗',
          '🚴',
          '🚵',
          '🎪',
          '🎭',
          '🎨',
          '🎬',
          '🎤',
          '🎧',
          '🎼',
          '🎹',
          '🥁',
          '🎷',
          '🎺',
          '🎸',
          '🪕',
          '🎻',
        ];
      case 4: // Travel
        return [
          '🚗',
          '🚕',
          '🚙',
          '🚌',
          '🚎',
          '🏎️',
          '🚓',
          '🚑',
          '🚒',
          '🚐',
          '🚚',
          '🚛',
          '🚜',
          '🦯',
          '🦽',
          '🦼',
          '🛴',
          '🚲',
          '🛵',
          '🏍️',
          '🛺',
          '🚨',
          '🚔',
          '🚍',
          '🚘',
          '🚖',
          '🚡',
          '🚠',
          '🚟',
          '🚃',
          '🚋',
          '🚞',
          '🚝',
          '🚄',
          '🚅',
          '🚈',
          '🚂',
          '🚆',
          '🚇',
          '🚊',
          '🚉',
          '✈️',
          '🛫',
          '🛬',
          '🛩️',
          '💺',
          '🛰️',
          '🚀',
          '🛸',
          '🚁',
          '🛶',
          '⛵',
          '🚤',
          '🛥️',
          '🛳️',
          '⛴️',
          '🚢',
          '⚓',
          '⛽',
          '🚧',
          '🚦',
          '🚥',
          '🗺️',
          '🗿',
        ];
      case 5: // Objects
        return [
          '⌚',
          '📱',
          '📲',
          '💻',
          '⌨️',
          '🖥️',
          '🖨️',
          '🖱️',
          '🖲️',
          '🕹️',
          '🗜️',
          '💽',
          '💾',
          '💿',
          '📀',
          '📼',
          '📷',
          '📸',
          '📹',
          '🎥',
          '📽️',
          '🎞️',
          '📞',
          '☎️',
          '📟',
          '📠',
          '📺',
          '📻',
          '🎙️',
          '🎚️',
          '🎛️',
          '🧭',
          '⏱️',
          '⏲️',
          '⏰',
          '🕰️',
          '⌛',
          '⏳',
          '📡',
          '🔋',
          '🔌',
          '💡',
          '🔦',
          '🕯️',
          '🪔',
          '🧯',
          '🛢️',
          '💸',
          '💵',
          '💴',
          '💶',
          '💷',
          '💰',
          '💳',
          '💎',
          '⚖️',
        ];
      case 6: // Symbols
        return [
          '❤️',
          '🧡',
          '💛',
          '💚',
          '💙',
          '💜',
          '🖤',
          '🤍',
          '🤎',
          '💔',
          '❣️',
          '💕',
          '💞',
          '💓',
          '💗',
          '💖',
          '💘',
          '💝',
          '💟',
          '☮️',
          '✝️',
          '☪️',
          '🕉️',
          '☸️',
          '✡️',
          '🔯',
          '🕎',
          '☯️',
          '☦️',
          '🛐',
          '⛎',
          '♈',
          '♉',
          '♊',
          '♋',
          '♌',
          '♍',
          '♎',
          '♏',
          '♐',
          '♑',
          '♒',
          '♓',
          '🆔',
          '⚛️',
          '🉑',
          '☢️',
          '☣️',
          '📴',
          '📳',
          '🈶',
          '🈚',
          '🈸',
          '🈺',
          '🈷️',
          '✴️',
          '🆚',
          '💮',
          '🉐',
          '㊙️',
          '㊗️',
          '🈴',
          '🈵',
          '🈹',
        ];
      default:
        return [];
    }
  }
}

// ============================================================================
// STICKER TAB (GIPHY)
// ============================================================================
class _StickerTab extends HookConsumerWidget {
  final ValueNotifier<String> selectedCategory;
  final TextEditingController searchController;
  final ValueNotifier<String> searchQuery;
  final Function(String) onStickerSelected;
  final bool isDark;
  final Color iconColor;

  const _StickerTab({
    required this.selectedCategory,
    required this.searchController,
    required this.searchQuery,
    required this.onStickerSelected,
    required this.isDark,
    required this.iconColor,
  });

  static const List<Map<String, String>> _stickerCategories = [
    {'id': 'trending', 'label': 'Trending'},
    {'id': 'happy', 'label': 'Happy'},
    {'id': 'love', 'label': 'Love'},
    {'id': 'sad', 'label': 'Sad'},
    {'id': 'funny', 'label': 'Funny'},
    {'id': 'excited', 'label': 'Excited'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Debounce search
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        searchQuery.value = searchController.text;
      });
      return () {};
    }, [searchController.text]);

    // Watch stickers based on search or category
    final stickersAsync = searchQuery.value.isNotEmpty
        ? ref.watch(searchStickersProvider(searchQuery.value))
        : selectedCategory.value == 'trending'
        ? ref.watch(trendingStickersProvider)
        : ref.watch(categoryStickersProvider(selectedCategory.value));

    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search stickers...',
              prefixIcon: Icon(Icons.search, color: iconColor),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        searchQuery.value = '';
                      },
                    )
                  : null,
              filled: true,
              fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),

        // Category selector (only show when not searching)
        if (searchQuery.value.isEmpty)
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _stickerCategories.length,
              itemBuilder: (context, index) {
                final category = _stickerCategories[index];
                return ValueListenableBuilder<String>(
                  valueListenable: selectedCategory,
                  builder: (context, selected, _) {
                    final isSelected = selected == category['id'];
                    return GestureDetector(
                      onTap: () => selectedCategory.value = category['id']!,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? iconColor.withValues(alpha: 0.1)
                              : (isDark ? Colors.grey[800] : Colors.grey[200]),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          category['label']!,
                          style: TextStyle(
                            color: isSelected ? iconColor : (isDark ? Colors.grey[400] : Colors.grey[700]),
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

        // Sticker grid
        Expanded(
          child: stickersAsync.when(
            data: (stickers) {
              if (stickers.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text('No stickers found', style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600])),
                    ],
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: stickers.length,
                itemBuilder: (context, index) {
                  final sticker = stickers[index];
                  return GestureDetector(
                    onTap: () => onStickerSelected(sticker.url),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: sticker.previewUrl,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Container(
                          color: Colors.transparent,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: isDark ? Colors.grey[600] : Colors.grey[400],
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.transparent,
                          child: Icon(Icons.error_outline, color: isDark ? Colors.grey[600] : Colors.grey[400]),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load stickers',
                    style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Check your API key',
                    style: TextStyle(color: isDark ? Colors.grey[500] : Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Powered by Giphy
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Powered by GIPHY',
            style: TextStyle(
              color: isDark ? Colors.grey[500] : Colors.grey[500],
              fontSize: 10,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
