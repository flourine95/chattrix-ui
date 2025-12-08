import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_info.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject_reason.dart';
import 'package:chattrix_ui/features/call/domain/repositories/call_repository.dart';
import 'package:dartz/dartz.dart';

class RejectCallUseCase {
  final CallRepository repository;

  RejectCallUseCase(this.repository);

  Future<Either<Failure, CallInfo>> call({required String callId, required CallRejectReason reason}) {
    return repository.rejectCall(callId: callId, reason: reason);
  }
}
