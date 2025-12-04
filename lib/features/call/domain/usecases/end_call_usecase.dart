import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_info.dart';
import 'package:chattrix_ui/features/call/domain/repositories/call_repository.dart';
import 'package:dartz/dartz.dart';

class EndCallUseCase {
  final CallRepository repository;

  EndCallUseCase(this.repository);

  Future<Either<Failure, CallInfo>> call({
    required String callId,
    required CallEndReason reason,
  }) {
    return repository.endCall(
      callId: callId,
      reason: reason,
    );
  }
}

