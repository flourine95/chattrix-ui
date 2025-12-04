import 'package:chattrix_ui/features/call/domain/usecases/accept_call_usecase.dart';
import 'package:chattrix_ui/features/call/domain/usecases/end_call_usecase.dart';
import 'package:chattrix_ui/features/call/domain/usecases/initiate_call_usecase.dart';
import 'package:chattrix_ui/features/call/domain/usecases/reject_call_usecase.dart';
import 'package:chattrix_ui/features/call/presentation/providers/call_repository_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final initiateCallUseCaseProvider = Provider<InitiateCallUseCase>((ref) {
  final repository = ref.watch(callRepositoryProvider);
  return InitiateCallUseCase(repository);
});

final acceptCallUseCaseProvider = Provider<AcceptCallUseCase>((ref) {
  final repository = ref.watch(callRepositoryProvider);
  return AcceptCallUseCase(repository);
});

final rejectCallUseCaseProvider = Provider<RejectCallUseCase>((ref) {
  final repository = ref.watch(callRepositoryProvider);
  return RejectCallUseCase(repository);
});

final endCallUseCaseProvider = Provider<EndCallUseCase>((ref) {
  final repository = ref.watch(callRepositoryProvider);
  return EndCallUseCase(repository);
});

