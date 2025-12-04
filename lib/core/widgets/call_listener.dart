import 'package:chattrix_ui/features/call/presentation/state/call_notifier.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_websocket_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Wrapper widget that initializes call-related services
/// Navigation is handled by router redirect based on call state
class CallListener extends ConsumerWidget {
  final Widget child;

  const CallListener({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize WebSocket connection (required for receiving calls)
    ref.watch(webSocketConnectionProvider);

    // Watch to ensure CallNotifier is initialized and WebSocket is listening
    ref.watch(callProvider);

    // No navigation logic here - handled by router redirect
    return child;
  }
}

