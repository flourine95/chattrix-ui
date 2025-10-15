import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatViewPage extends HookWidget {
  const ChatViewPage({super.key, required this.chatId, this.name});

  final String chatId;
  final String? name;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    final messages = [
      _Message(text: 'Hey there!', isMe: false),
      _Message(text: 'Hi! How are you?', isMe: true),
      _Message(
        text: "I'm good, thanks! Working on a Flutter app.",
        isMe: false,
      ),
      _Message(text: 'Nice! Using Riverpod and GoRouter.', isMe: true),
      _Message(text: 'Exactly. Looks neat!', isMe: false),
    ];

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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final m = messages[index];
                return Align(
                  alignment: m.isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: ChatBubble(text: m.text, isMe: m.isMe),
                );
              },
            ),
          ),
          _InputBar(controller: controller),
        ],
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final inputTheme = Theme.of(context).inputDecorationTheme;

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
              onPressed: () {},
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
