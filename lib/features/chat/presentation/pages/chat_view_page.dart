import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_providers.dart';
import 'package:chattrix_ui/features/chat/presentation/utils/conversation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatViewPage extends HookConsumerWidget {
  const ChatViewPage({super.key, required this.chatId, this.name, this.color});

  final String chatId;
  final String? name;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final scrollController = useScrollController();
    final showScrollButton = useState(false);
    final previousMessageCount = useRef(0);

    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final avatarColor = color ?? colors.primary;

    final r = (avatarColor.r * 255).round();
    final g = (avatarColor.g * 255).round();
    final b = (avatarColor.b * 255).round();

    final brightness = (r * 0.299 + g * 0.587 + b * 0.114) / 255;

    final onAvatarColor = brightness < 0.5 ? Colors.white : Colors.black;

    final me = ref.watch(currentUserProvider);
    final messagesAsync = ref.watch(messagesProvider(chatId));
    final wsConnection = ref.watch(webSocketConnectionProvider);
    final wsService = ref.watch(chatWebSocketServiceProvider);

    // Get conversation to show user status
    final conversationsAsync = ref.watch(conversationsProvider);
    final conversation = conversationsAsync.value?.firstWhere(
      (c) => c.id.toString() == chatId,
      orElse: () => conversationsAsync.value!.first,
    );

    // Initialize WebSocket connection on first build
    useEffect(() {
      ref.read(webSocketConnectionProvider.notifier);
      return null;
    }, []);

    // Listen to scroll position to show/hide scroll button
    // Show button when scrolled away from bottom (newest messages)
    useEffect(() {
      void onScroll() {
        if (scrollController.hasClients) {
          final isAtBottom = scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 100;
          showScrollButton.value = !isAtBottom;
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    // Auto-scroll to bottom when messages first load
    // Messages are in DESC order (newest first) from API, but we reverse them for display
    useEffect(() {
      messagesAsync.whenData((messages) {
        if (messages.isNotEmpty && previousMessageCount.value == 0) {
          // First time loading messages - scroll to bottom to see newest message
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (scrollController.hasClients) {
              scrollController.jumpTo(scrollController.position.maxScrollExtent);
            }
          });
        }
      });
      return null;
    }, [messagesAsync]);

    // Scroll to bottom when new message arrives
    useEffect(() {
      messagesAsync.whenData((messages) {
        if (messages.length > previousMessageCount.value &&
            previousMessageCount.value > 0 &&
            scrollController.hasClients) {
          // Only scroll if we're already near the bottom
          final isNearBottom = scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200;

          if (isNearBottom) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (scrollController.hasClients) {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });
          }
        }
        previousMessageCount.value = messages.length;
      });
      return null;
    }, [messagesAsync]);

    Future<void> sendMessage() async {
      final text = controller.text.trim();
      if (text.isEmpty) return;

      // Send via WebSocket if connected, otherwise use HTTP
      if (wsConnection.isConnected) {
        wsService.sendMessage(chatId, text);
        controller.clear();

        // Scroll to bottom after sending (newest message will be at bottom)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      } else {
        final usecase = ref.read(sendMessageUsecaseProvider);
        final result = await usecase(conversationId: chatId, content: text);
        result.fold(
          (failure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(failure.message)));
          },
          (_) async {
            controller.clear();
            // Refresh messages after sending
            ref.invalidate(messagesProvider(chatId));
          },
        );
      }
    }

    void scrollToBottom() {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: avatarColor,
              child: Text(
                (name ?? 'User $chatId').substring(0, 1).toUpperCase(),
                style: textTheme.titleMedium?.copyWith(color: onAvatarColor),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name ?? 'User $chatId', style: textTheme.titleMedium),
                  // Show user status for DIRECT conversations
                  if (conversation != null &&
                      conversation.type.toUpperCase() == 'DIRECT')
                    Builder(
                      builder: (context) {
                        final isOnline = ConversationUtils.isUserOnline(
                          conversation,
                          me,
                        );
                        final lastSeen = ConversationUtils.getLastSeen(
                          conversation,
                          me,
                        );
                        final statusText = ConversationUtils.formatLastSeen(
                          isOnline,
                          lastSeen,
                        );

                        return Text(
                          statusText,
                          style: textTheme.bodySmall?.copyWith(
                            color: isOnline ? Colors.green : Colors.grey,
                          ),
                        );
                      },
                    )
                  else
                    // Fallback to WebSocket connection status for GROUP or when conversation not loaded
                    Text(
                      wsConnection.isConnected ? 'Connected' : 'Connecting...',
                      style: textTheme.bodySmall?.copyWith(
                        color: wsConnection.isConnected
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: messagesAsync.when(
                  data: (messages) {
                    // Reverse messages to show oldest first (top) and newest last (bottom)
                    // API returns DESC order (newest first), we need ASC for chat display
                    final reversedMessages = messages.reversed.toList();

                    return ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      itemCount: reversedMessages.length,
                      itemBuilder: (context, index) {
                        final m = reversedMessages[index];
                        final isMe = m.sender.id == me?.id;
                        return Align(
                          alignment: isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: ChatBubble(text: m.content, isMe: isMe),
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(
                    child: Text(
                      'Failed to load messages',
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
              _InputBar(controller: controller, onSend: sendMessage),
            ],
          ),
          // Floating scroll to bottom button (to see newest messages)
          if (showScrollButton.value)
            Positioned(
              right: 16,
              bottom: 80,
              child: FloatingActionButton.small(
                onPressed: scrollToBottom,
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                child: const Icon(Icons.keyboard_arrow_down),
              ),
            ),
        ],
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(color: colors.onSurface.withValues(alpha: 0.08)),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.paperclip),
              color: colors.onSurface,
            ),
            Expanded(
              child: TextField(
                controller: controller,
                onSubmitted: (_) => onSend(),
                textInputAction: TextInputAction.send,
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  filled: true,
                  fillColor: colors.surface.withValues(alpha: 0.6),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onSend,
              icon: const FaIcon(FontAwesomeIcons.paperPlane),
              color: colors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.text, required this.isMe});

  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    final bg = isMe
        ? (isDark
              ? colors.primary
              : Colors.grey.shade200) // mình: xám nhạt ở light mode
        : (isDark
              ? colors.surface
              : Colors.black); // người khác: đen ở light mode
    final fg = isMe
        ? (isDark
              ? colors.onPrimary
              : Colors.black) // mình: chữ đen ở light mode
        : (isDark
              ? colors.onSurface
              : Colors.white); // người khác: chữ trắng ở light mode

    return Container(
      margin: EdgeInsets.only(
        left: isMe ? 48 : 8,
        right: isMe ? 8 : 48,
        top: 6,
        bottom: 6,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(isMe ? 16 : 4),
          bottomRight: Radius.circular(isMe ? 4 : 16),
        ),
        border: isMe
            ? Border.all(
                color: Colors.grey.shade300,
              ) // giúp bubble sáng vẫn tách nền
            : null,
      ),
      child: Text(text, style: textTheme.bodyMedium?.copyWith(color: fg)),
    );
  }
}
