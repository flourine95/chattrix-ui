import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/domain/entities/conversation.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/chat_repository_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/providers/conversation_settings_provider.dart';
import 'package:chattrix_ui/features/chat/presentation/widgets/conversation_list_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Provider to fetch hidden conversations
/// This is separate from conversationsProvider because that one filters out hidden conversations
final hiddenConversationsProvider = FutureProvider<List<Conversation>>((ref) async {
  final repository = ref.watch(chatRepositoryProvider);
  final result = await repository.getConversations();

  return result.fold((failure) => throw Exception(failure.message), (conversations) {
    // Filter to only show hidden conversations
    final hidden = conversations.where((c) => c.settings?.hidden == true).toList();
    debugPrint('🔍 [hiddenConversationsProvider] Found ${hidden.length} hidden conversations');
    return hidden;
  });
});

/// Page to display hidden conversations
///
/// Hidden conversations are fetched using the 'hidden' filter
/// Users can unhide conversations from this page
class HiddenConversationsPage extends ConsumerWidget {
  const HiddenConversationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Get current user
    final currentUser = ref.watch(currentUserProvider);

    // Watch hidden conversations (separate provider that doesn't filter)
    final conversationsAsync = ref.watch(hiddenConversationsProvider);

    return Scaffold(
      backgroundColor: colors.surfaceContainerLow,
      appBar: AppBar(
        title: Text('Hidden Conversations', style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        centerTitle: false,
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0.5,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        scrolledUnderElevation: 0.5,
      ),
      body: conversationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: colors.error),
              const SizedBox(height: 16),
              Text('Failed to load hidden conversations', style: textTheme.bodyLarge),
              const SizedBox(height: 8),
              Text(
                error.toString().replaceAll('Exception: ', ''),
                style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: () => ref.invalidate(hiddenConversationsProvider), child: const Text('Retry')),
            ],
          ),
        ),
        data: (conversations) {
          // All conversations here are already hidden (filtered by provider)
          if (conversations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.visibility_off_outlined, size: 64, color: colors.onSurfaceVariant.withValues(alpha: 0.5)),
                  const SizedBox(height: 16),
                  Text(
                    'No hidden conversations',
                    style: textTheme.titleMedium?.copyWith(color: colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Conversations you hide will appear here',
                    style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant.withValues(alpha: 0.7)),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(hiddenConversationsProvider);
            },
            child: ListView.separated(
              itemCount: conversations.length,
              separatorBuilder: (context, index) => const SizedBox(height: 0),
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ConversationListItem(
                  conversation: conversation,
                  currentUser: currentUser,
                  onTap: () {
                    // Use go instead of push to avoid duplicate keys
                    context.go('/chat/${conversation.id}');
                  },
                  onLongPress: () => _showUnhideDialog(context, ref, conversation.id),
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// Show bottom sheet to unhide conversation
  void _showUnhideDialog(BuildContext context, WidgetRef ref, int conversationId) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          bottom: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(color: colors.outlineVariant, borderRadius: BorderRadius.circular(2)),
                ),

                // Icon
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.primaryContainer.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.visibility, color: colors.primary, size: 32),
                  ),
                ),

                const SizedBox(height: 20),

                // Title
                Text('Unhide Conversation', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),

                const SizedBox(height: 12),

                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'This conversation will be visible in your main chat list again.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant, height: 1.4),
                  ),
                ),

                const SizedBox(height: 24),

                // Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            side: BorderSide(color: colors.outline, width: 1.5),
                          ),
                          child: const Text('Cancel', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () async {
                            debugPrint('🔍 [Unhide] Starting unhide for conversation $conversationId');
                            Navigator.pop(context); // Close bottom sheet

                            // Show loading
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const Center(child: CircularProgressIndicator()),
                            );

                            try {
                              debugPrint('🔍 [Unhide] Calling datasource directly...');
                              // Call datasource directly to avoid provider disposal issues
                              final dataSource = ref.read(conversationSettingsDataSourceProvider);
                              final response = await dataSource.unhideConversation(conversationId);

                              debugPrint('🔍 [Unhide] Unhide completed successfully: ${response.data}');

                              if (context.mounted) {
                                // Close loading dialog
                                Navigator.of(context, rootNavigator: true).pop();

                                // Show success message with dark theme
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        const Icon(Icons.check_circle, color: Colors.white, size: 20),
                                        const SizedBox(width: 12),
                                        const Text('Conversation unhidden', style: TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    backgroundColor: Colors.grey.shade900,
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            } catch (e) {
                              debugPrint('🔍 [Unhide] Error occurred: $e');
                              if (context.mounted) {
                                // Close loading dialog using rootNavigator
                                Navigator.of(context, rootNavigator: true).pop();

                                // Show error message with dark theme
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(Icons.error_outline, color: Colors.white, size: 20),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            'Failed to unhide conversation',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: Colors.grey.shade900,
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(16),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                );
                              }
                            }
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: colors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Unhide', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
