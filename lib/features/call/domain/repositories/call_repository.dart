import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_connection.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_info.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';
import 'package:fpdart/fpdart.dart';

abstract class CallRepository {
  Future<Either<Failure, CallConnection>> initiateCall({required int calleeId, required CallType callType});

  Future<Either<Failure, CallConnection>> acceptCall({required String callId});

  Future<Either<Failure, CallInfo>> rejectCall({required String callId, required CallRejectReason reason});

  Future<Either<Failure, CallInfo>> endCall({required String callId, required CallEndReason reason});
}
