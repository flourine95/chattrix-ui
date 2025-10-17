import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/providers/chat_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatViewPage extends HookConsumerWidget {
  const ChatViewPage({super.key, required this.chatId, this.name});

  final String chatId;
  final String? name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final me = ref.watch(currentUserProvider);
    final messagesAsync = ref.watch(messagesProvider(chatId));

    Future<void> sendMessage() async {
      final text = controller.text.trim();
      if (text.isEmpty) return;
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
          await ref.refresh(messagesProvider(chatId).future);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: colors.primary,
              child: Text(
                (name ?? 'User $chatId').substring(0, 1),
                style: textTheme.titleMedium?.copyWith(color: colors.onPrimary),
              ),
            ),
            const SizedBox(width: 12),
            Text(name ?? 'User $chatId', style: textTheme.titleMedium),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              data: (messages) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final m = messages[index];
                    debugPrint("Message from ${m.sender.id}: ${m.content}");
                    debugPrint("Message from ${me?.id}: ${m.content}");
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
              loading: () => const Center(child: CircularProgressIndicator()),
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
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final bg = isMe ? colors.primary : colors.surface;
    final fg = isMe ? colors.onPrimary : colors.onSurface;

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
      ),
      child: Text(text, style: textTheme.bodyMedium?.copyWith(color: fg)),
    );
  }
}

class _Message {
  final String text;
  final bool isMe;

  _Message({required this.text, required this.isMe});
}
