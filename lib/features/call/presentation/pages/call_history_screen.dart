import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_history_provider.dart';
import 'package:chattrix_ui/features/call/presentation/widgets/call_history_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Call History Screen - displays list of past calls
/// Shows call type, status, timestamp, and duration
/// Sorted in reverse chronological order (newest first)
class CallHistoryScreen extends HookConsumerWidget {
  const CallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final historyState = ref.watch(callHistoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Call History', style: textTheme.titleLarge)),
      body: historyState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          // Use userMessage extension for Failure types, otherwise use toString()
          final errorMessage = error is Failure ? error.userMessage : error.toString();

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: colorScheme.error),
                const SizedBox(height: 16),
                Text('Failed to load call history', style: textTheme.titleMedium?.copyWith(color: colorScheme.error)),
                const SizedBox(height: 8),
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(color: colorScheme.outline),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => ref.read(callHistoryProvider.notifier).refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
        data: (history) {
          if (history.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone_disabled, size: 64, color: colorScheme.outline),
                  const SizedBox(height: 16),
                  Text('No call history', style: textTheme.titleMedium?.copyWith(color: colorScheme.outline)),
                  const SizedBox(height: 8),
                  Text(
                    'Your call history will appear here',
                    style: textTheme.bodySmall?.copyWith(color: colorScheme.outline),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(callHistoryProvider.notifier).refresh(),
            child: ListView.separated(
              itemCount: history.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final callHistory = history[index];
                return CallHistoryItem(callHistory: callHistory);
              },
            ),
          );
        },
      ),
    );
  }
}
