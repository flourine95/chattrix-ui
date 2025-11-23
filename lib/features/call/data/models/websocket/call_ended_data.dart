import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_ended_data.freezed.dart';
part 'call_ended_data.g.dart';

/// Data payload for call ended notification
@freezed
abstract class CallEndedData with _$CallEndedData {
  const factory CallEndedData({required String callId, required String endedBy, int? durationSeconds}) = _CallEndedData;

  factory CallEndedData.fromJson(Map<String, dynamic> json) => _$CallEndedDataFromJson(json);
}
