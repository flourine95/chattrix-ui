import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart' as semantics;

/// Service for making screen reader announcements
///
/// Provides methods to announce important events to screen readers
/// for accessibility support.
class ScreenReaderService {
  /// Announce a message to screen readers
  ///
  /// **Parameters:**
  /// - [message]: The message to announce
  /// - [assertiveness]: The assertiveness level (polite or assertive)
  static void announce(BuildContext context, String message, {Assertiveness assertiveness = Assertiveness.polite}) {
    if (!context.mounted) return;

    final view = View.of(context);
    semantics.SemanticsService.sendAnnouncement(view, message, TextDirection.ltr);
  }

  /// Announce a new message
  static void announceNewMessage(
    BuildContext context, {
    required String senderName,
    required String conversationName,
    bool isGroup = false,
  }) {
    final message = isGroup ? 'New message from $senderName in $conversationName' : 'New message from $senderName';

    announce(context, message, assertiveness: Assertiveness.polite);
  }

  /// Announce a conversation update
  static void announceConversationUpdate(BuildContext context, {required String conversationName}) {
    announce(context, 'Conversation $conversationName updated', assertiveness: Assertiveness.polite);
  }

  /// Announce a filter change
  static void announceFilterChange(BuildContext context, {required String filterName, required int conversationCount}) {
    final message =
        '$filterName filter selected. '
        'Showing $conversationCount ${conversationCount == 1 ? 'conversation' : 'conversations'}.';

    announce(context, message, assertiveness: Assertiveness.polite);
  }

  /// Announce user online status change
  static void announceUserStatusChange(BuildContext context, {required String userName, required bool isOnline}) {
    final message = isOnline ? '$userName is now online' : '$userName is now offline';

    announce(context, message, assertiveness: Assertiveness.polite);
  }

  /// Announce typing indicator
  static void announceTyping(BuildContext context, {required String userName, required String conversationName}) {
    announce(context, '$userName is typing in $conversationName', assertiveness: Assertiveness.polite);
  }
}

/// Assertiveness level for screen reader announcements
enum Assertiveness {
  /// Polite announcements that don't interrupt current speech
  polite,

  /// Assertive announcements that interrupt current speech
  assertive,
}
