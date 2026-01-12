import 'package:chattrix_ui/features/call/domain/entities/call_info.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'active_call_provider.g.dart';

/// Provider to check if there's an active call in a conversation
///
/// **Usage:**
/// ```dart
/// final activeCall = ref.watch(activeCallProvider(conversationId));
/// ```
@riverpod
Future<CallInfo?> activeCall(ActiveCallRef ref, int conversationId) async {
  final useCase = ref.watch(getActiveCallUseCaseProvider);
  final result = await useCase(conversationId: conversationId);

  return result.fold((failure) {
    // Log error but don't throw - return null if check fails
    return null;
  }, (callInfo) => callInfo);
}
