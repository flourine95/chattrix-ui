import 'package:flutter/material.dart';

/// Configuration object for InputBar
/// Reduces parameter explosion by grouping related parameters
class InputBarConfig {
  final TextEditingController controller;
  final FocusNode focusNode;
  final int chatId;
  final bool isDark;
  final Color primaryColor;
  final dynamic conversation;

  const InputBarConfig({
    required this.controller,
    required this.focusNode,
    required this.chatId,
    required this.isDark,
    required this.primaryColor,
    this.conversation,
  });
}

/// State object for InputBar
class InputBarState {
  final bool showGallery;
  final bool canSendMessage;
  final bool showAttachmentPicker;
  final bool isRecording;
  final Duration recordingDuration;

  const InputBarState({
    required this.showGallery,
    required this.canSendMessage,
    required this.showAttachmentPicker,
    required this.isRecording,
    required this.recordingDuration,
  });
}

/// Callbacks for InputBar actions
class InputBarCallbacks {
  final VoidCallback onSend;
  final VoidCallback onToggleGallery;
  final VoidCallback onToggleAttachmentPicker;
  final VoidCallback onVoiceRecord;
  final VoidCallback onCancelRecording;

  const InputBarCallbacks({
    required this.onSend,
    required this.onToggleGallery,
    required this.onToggleAttachmentPicker,
    required this.onVoiceRecord,
    required this.onCancelRecording,
  });
}
