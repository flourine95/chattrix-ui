import 'package:chattrix_ui/features/call/data/models/call_connection_model.dart';
import 'package:chattrix_ui/features/call/data/models/call_info_model.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject_reason.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_type.dart';

abstract class CallRemoteDataSource {
  Future<CallConnectionModel> initiateCall({
    required int calleeId,
    required CallType callType,
  });

  Future<CallConnectionModel> acceptCall({
    required String callId,
  });

  Future<CallInfoModel> rejectCall({
    required String callId,
    required CallRejectReason reason,
  });

  Future<CallInfoModel> endCall({
    required String callId,
    required CallEndReason reason,
  });
}

