import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_accept.dart';

part 'call_accept_model.freezed.dart';
part 'call_accept_model.g.dart';

@freezed
abstract class CallAcceptModel with _$CallAcceptModel {
  const CallAcceptModel._();

  const factory CallAcceptModel({
    required String callId,
    required int acceptedBy,
  }) = _CallAcceptModel;

  factory CallAcceptModel.fromJson(Map<String, dynamic> json) =>
      _$CallAcceptModelFromJson(json);

  CallAccept toEntity() {
    return CallAccept(
      callId: callId,
      acceptedBy: acceptedBy,
    );
  }
}
