import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/domain/entities/call_end.dart';

part 'call_end_model.freezed.dart';
part 'call_end_model.g.dart';

@freezed
abstract class CallEndModel with _$CallEndModel {
  const CallEndModel._();

  const factory CallEndModel({required String callId, required int endedBy, int? durationSeconds}) = _CallEndModel;

  factory CallEndModel.fromJson(Map<String, dynamic> json) => _$CallEndModelFromJson(json);

  CallEnd toEntity() {
    return CallEnd(callId: callId, endedBy: endedBy, durationSeconds: durationSeconds);
  }
}
