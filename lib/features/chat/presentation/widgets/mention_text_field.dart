import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

/// Model for a mentionable user
class MentionableUser {
  final int id;
  final String name;
  final String? avatarUrl;

  const MentionableUser({
    required this.id,
    required this.name,
    this.avatarUrl,
  });
}

/// Text field with mention autocomplete support
class MentionTextField extends StatefulWidget {
  const MentionTextField({
    super.key,
    required this.controller,
    required this.users,
    this.onMentionAdded,
    this.focusNode,
    this.decoration,
    this.maxLines,
    this.minLines,
    this.textInputAction,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final List<MentionableUser> users;
  final Function(MentionableUser user)? onMentionAdded;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;

  @override
  State<MentionTextField> createState() => _MentionTextFieldState();
}

class _MentionTextFieldState extends State<MentionTextField> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<MentionableUser> _filteredUsers = [];
  int _mentionStartPosition = -1;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _removeOverlay();
    super.dispose();
  }

  void _onTextChanged() {
    final text = widget.controller.text;
    final cursorPosition = widget.controller.selection.baseOffset;

    // Find if we're typing a mention
    if (cursorPosition > 0) {
      // Look backwards from cursor to find '@'
      int atPosition = -1;
      for (int i = cursorPosition - 1; i >= 0; i--) {
        if (text[i] == '@') {
          atPosition = i;
          break;
        }
        if (text[i] == ' ' || text[i] == '\n') {
          break;
        }
      }

      if (atPosition != -1) {
        // We found an '@', extract the query
        final query = text.substring(atPosition + 1, cursorPosition);
        _mentionStartPosition = atPosition;
        _filterUsers(query);
        return;
      }
    }

    // No mention found, hide overlay
    _removeOverlay();
  }

  void _filterUsers(String query) {
    final filtered = widget.users.where((user) {
      return user.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (filtered.isEmpty) {
      _removeOverlay();
      return;
    }

    setState(() {
      _filteredUsers = filtered;
    });

    if (_overlayEntry == null) {
      _showOverlay();
    } else {
      _overlayEntry!.markNeedsBuild();
    }
  }

  void _showOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 32,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, -200), // Show above the text field
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = _filteredUsers[index];
                  return ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      radius: 16,
                      backgroundImage: user.avatarUrl != null
                          ? NetworkImage(user.avatarUrl!)
                          : null,
                      child: user.avatarUrl == null
                          ? Text(
                              user.name[0].toUpperCase(),
                              style: const TextStyle(fontSize: 14),
                            )
                          : null,
                    ),
                    title: Text(
                      user.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    onTap: () => _insertMention(user),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _filteredUsers = [];
    _mentionStartPosition = -1;
  }

  void _insertMention(MentionableUser user) {
    final text = widget.controller.text;
    final cursorPosition = widget.controller.selection.baseOffset;

    // Replace from @ to cursor with the mention
    final newText = text.substring(0, _mentionStartPosition) +
        '@${user.name} ' +
        text.substring(cursorPosition);

    widget.controller.text = newText;
    widget.controller.selection = TextSelection.collapsed(
      offset: _mentionStartPosition + user.name.length + 2,
    );

    widget.onMentionAdded?.call(user);
    _removeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        decoration: widget.decoration,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        textInputAction: widget.textInputAction,
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}

/// Widget to highlight mentions in text
class MentionText extends StatelessWidget {
  const MentionText({
    super.key,
    required this.text,
    this.style,
    this.mentionStyle,
    this.onMentionTap,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final TextStyle? style;
  final TextStyle? mentionStyle;
  final Function(String username)? onMentionTap;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final defaultMentionStyle = TextStyle(
      color: colors.primary,
      fontWeight: FontWeight.w600,
    );

    final spans = <InlineSpan>[];
    final regex = RegExp(r'@(\w+)');
    int lastMatchEnd = 0;

    for (final match in regex.allMatches(text)) {
      // Add text before mention
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: style,
        ));
      }

      // Add mention
      final username = match.group(1)!;
      spans.add(TextSpan(
        text: '@$username',
        style: mentionStyle ?? defaultMentionStyle,
        recognizer: onMentionTap != null
            ? (TapGestureRecognizer()..onTap = () => onMentionTap!(username))
            : null,
      ));

      lastMatchEnd = match.end;
    }

    // Add remaining text
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd),
        style: style,
      ));
    }

    return Text.rich(
      TextSpan(children: spans),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

