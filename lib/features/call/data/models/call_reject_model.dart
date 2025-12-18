import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_reject_reason.dart';

part 'call_reject_model.freezed.dart';
part 'call_reject_model.g.dart';

@freezed
abstract class CallRejectModel with _$CallRejectModel {
  const CallRejectModel._();

  const factory CallRejectModel({required String callId, required int rejectedBy, required CallRejectReason reason}) =
      _CallRejectModel;

  factory CallRejectModel.fromJson(Map<String, dynamic> json) => _$CallRejectModelFromJson(json);

  CallReject toEntity() {
    return CallReject(callId: callId, rejectedBy: rejectedBy, reason: reason);
  }
}
