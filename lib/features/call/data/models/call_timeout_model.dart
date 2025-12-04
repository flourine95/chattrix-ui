import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_timeout.dart';

part 'call_timeout_model.freezed.dart';
part 'call_timeout_model.g.dart';

@freezed
abstract class CallTimeoutModel with _$CallTimeoutModel {
  const CallTimeoutModel._();

  const factory CallTimeoutModel({
    required String callId,
    required String reason,
  }) = _CallTimeoutModel;

  factory CallTimeoutModel.fromJson(Map<String, dynamic> json) =>
      _$CallTimeoutModelFromJson(json);

  CallTimeout toEntity() {
    return CallTimeout(
      callId: callId,
      reason: reason,
    );
  }
}
