import 'package:chattrix_ui/core/domain/enums/conversation_filter.dart';
import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider_new.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/user_notes_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/state/conversations_notifier.dart';
import 'package:chattrix_ui/features/chat/presentation/state/filter_notifier.dart';
import 'package:chattrix_ui/features/chat/presentation/state/online_users_notifier.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/conversation_list_item.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/filter_chip_widget.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/note_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatListPage extends HookConsumerWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(webSocketConnectionProvider);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: const CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [_HeaderSearch(), _FilterBar(), _OnlineStoryList(), _ConversationList()],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 60,
      title: Text(
        'Chats',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: isDark ? Colors.white : Colors.black),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            icon: SvgPicture.asset(
              'assets/icons/message-circle-plus.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
            ),
            onPressed: () => context.push('/new-chat'),
            tooltip: 'New chat',
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 0.5,
          color: isDark ? Colors.grey.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1),
        ),
      ),
    );
  }
}

// ============================================================================
// PARTIAL WIDGETS (SLIVERS)
// ============================================================================

class _HeaderSearch extends StatelessWidget {
  const _HeaderSearch();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF3F4F6);
    final iconColor = isDark ? Colors.grey[400] : Colors.grey[600];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: GestureDetector(
          onTap: () => context.push('/search-conversations'),
          child: Container(
            height: 40,
            decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 10),
                  child: Icon(Icons.search, color: iconColor, size: 20),
                ),
                Expanded(
                  child: Text('Search conversations', style: TextStyle(fontSize: 15, color: iconColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterBar extends ConsumerWidget {
  const _FilterBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(filterProvider);
    final notifier = ref.read(conversationsProvider.notifier);

    return SliverToBoxAdapter(
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          children: [
            FilterChipWidget(
              label: 'All',
              isSelected: currentFilter == ConversationFilter.all,
              onTap: () => notifier.applyFilter(ConversationFilter.all),
            ),
            const SizedBox(width: 8),
            FilterChipWidget(
              label: 'Unread',
              isSelected: currentFilter == ConversationFilter.unread,
              onTap: () => notifier.applyFilter(ConversationFilter.unread),
            ),
            const SizedBox(width: 8),
            FilterChipWidget(
              label: 'Groups',
              isSelected: currentFilter == ConversationFilter.groups,
              onTap: () => notifier.applyFilter(ConversationFilter.groups),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnlineStoryList extends ConsumerWidget {
  const _OnlineStoryList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(filterProvider);
    // Chỉ hiện khi filter là All
    if (currentFilter != ConversationFilter.all) return const SliverToBoxAdapter(child: SizedBox.shrink());

    final onlineUsersAsync = ref.watch(onlineUsersProvider);

    return SliverToBoxAdapter(
      child: onlineUsersAsync.when(
        data: (onlineUsers) {
          final me = ref.watch(currentUserProvider);
          final notes = ref.watch(userNotesProvider);
          final currentUserId = me?.id.toString() ?? '';
          final totalItems = onlineUsers.length + 1; // +1 for "My Story"

          return Container(
            height: 110,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: totalItems,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                // Item 0: My Story
                if (index == 0) {
                  final myNote = notes[currentUserId];
                  return _StoryItem(
                    name: 'My Story',
                    imageUrl: me?.avatarUrl,
                    note: myNote?.content,
                    isMe: true,
                    isOnline: true,
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => NoteDialog(currentUserId: currentUserId, existingNote: myNote),
                    ),
                  );
                }

                // Item 1+: Others
                final user = onlineUsers[index - 1];
                final userNote = notes[user.id.toString()];
                return _StoryItem(
                  name: user.username,
                  imageUrl: user.avatarUrl,
                  note: userNote?.content,
                  isMe: false,
                  isOnline: true,
                  onTap: () => context.push('/chat/${user.id}'),
                );
              },
            ),
          );
        },
        loading: () => const SizedBox(height: 110, child: Center(child: CircularProgressIndicator())),
        error: (_, _) => const SizedBox.shrink(),
      ),
    );
  }
}

class _ConversationList extends ConsumerWidget {
  const _ConversationList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationsAsync = ref.watch(conversationsProvider);
    final me = ref.watch(currentUserProvider);

    return conversationsAsync.when(
      data: (conversations) {
        if (conversations.isEmpty) {
          return const SliverFillRemaining(child: Center(child: Text('No conversations yet')));
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final conversation = conversations[index];
            return ConversationListItem(
              conversation: conversation,
              currentUser: me,
              onTap: () => context.push('/chat/${conversation.id}'),
            );
          }, childCount: conversations.length),
        );
      },
      loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
      error: (error, _) => SliverFillRemaining(child: _ErrorView(error: error)),
    );
  }
}

class _ErrorView extends ConsumerWidget {
  final Object error;

  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (error is! Failure) return Center(child: Text("Error: $error"));

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text('Failed to load conversations'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => ref.read(conversationsProvider.notifier).refresh(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// STORY & AVATAR COMPONENTS
// ============================================================================

class _StoryItem extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final String? note;
  final bool isOnline;
  final String? lastSeenBadge;
  final bool isMe;
  final VoidCallback? onTap;

  const _StoryItem({
    required this.name,
    this.imageUrl,
    this.note,
    this.isOnline = false,
    this.lastSeenBadge,
    this.isMe = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 60.0;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.grey[300] : Colors.black87;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 76,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: avatarSize,
                  width: avatarSize,
                  child: _AvatarWithBadge(
                    imageUrl: imageUrl,
                    name: name,
                    isOnline: isOnline,
                    lastSeenBadge: lastSeenBadge,
                    isMe: isMe,
                    radius: avatarSize / 2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isMe ? 'My Story' : name,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            if (note != null && note!.isNotEmpty)
              Positioned(
                bottom: 65,
                left: -10,
                right: -10,
                child: Center(child: _MessengerBubble(text: note!)),
              ),
          ],
        ),
      ),
    );
  }
}

class _AvatarWithBadge extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final bool isOnline;
  final String? lastSeenBadge;
  final bool isMe;
  final double radius;

  const _AvatarWithBadge({
    this.imageUrl,
    required this.name,
    required this.isOnline,
    this.lastSeenBadge,
    required this.isMe,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const fbGreen = Color(0xFF31A24C);
    final bgColor = theme.scaffoldBackgroundColor;

    // Fallback avatar style
    final fallbackBg = isMe ? (isDark ? Colors.grey[700] : Colors.grey[200]) : theme.colorScheme.primary;
    final fallbackText = isMe ? (isDark ? Colors.white : Colors.black) : Colors.white;

    Widget avatarContent;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      avatarContent = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: radius * 2,
        height: radius * 2,
        errorBuilder: (_, _, _) => Icon(Icons.person, color: Colors.grey[400]),
      );
    } else {
      avatarContent = Container(
        color: fallbackBg,
        alignment: Alignment.center,
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : 'U',
          style: TextStyle(color: fallbackText, fontSize: radius, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipOval(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SizedBox(width: radius * 2, height: radius * 2, child: avatarContent),
        ),
        if (isMe)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              padding: const EdgeInsets.all(2),
              child: const Icon(Icons.add_circle, color: Colors.black, size: 20),
            ),
          )
        else if (isOnline)
          Positioned(
            bottom: 2,
            right: 2,
            child: _StatusBadge(color: fbGreen, borderColor: bgColor, isCircle: true),
          )
        else if (lastSeenBadge != null)
          Positioned(
            bottom: -2,
            right: -4,
            child: _StatusBadge(
              color: Colors.green.shade50,
              borderColor: bgColor,
              isCircle: false,
              child: Text(
                lastSeenBadge!,
                style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: fbGreen, height: 1.0),
              ),
            ),
          ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final bool isCircle;
  final Widget? child;

  const _StatusBadge({required this.color, required this.borderColor, required this.isCircle, this.child});

  @override
  Widget build(BuildContext context) {
    final container = Container(
      width: isCircle ? 15 : null,
      height: isCircle ? 15 : null,
      padding: isCircle ? null : const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 2),
      ),
      alignment: Alignment.center,
      child: child,
    );

    return isCircle ? ClipOval(child: container) : ClipRRect(borderRadius: BorderRadius.circular(10), child: container);
  }
}

class _MessengerBubble extends StatelessWidget {
  final String text;

  const _MessengerBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BubblePainter(),
      child: Container(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          constraints: const BoxConstraints(minWidth: 40, maxWidth: 85),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            text,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.black87, height: 1.2),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    final double bodyBottom = size.height - 12;
    final bodyPath = Path()
      ..addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          size.width,
          bodyBottom,
          topLeft: const Radius.circular(18),
          topRight: const Radius.circular(18),
          bottomLeft: const Radius.circular(18),
          bottomRight: const Radius.circular(18),
        ),
      );

    final tailPath = Path()
      ..addOval(Rect.fromCircle(center: Offset(size.width * 0.22, bodyBottom), radius: 5))
      ..addOval(Rect.fromCircle(center: Offset(size.width * 0.30, bodyBottom + 8), radius: 2.5));

    final finalPath = Path.combine(PathOperation.union, bodyPath, tailPath);

    canvas.drawShadow(finalPath, Colors.black.withValues(alpha: 0.1), 4.0, true);
    canvas.drawPath(finalPath, fillPaint);
    canvas.drawPath(finalPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
