import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_timeout_data.freezed.dart';
part 'call_timeout_data.g.dart';

/// Data payload for call timeout notification
@freezed
abstract class CallTimeoutData with _$CallTimeoutData {
  const factory CallTimeoutData({required String callId}) = _CallTimeoutData;

  factory CallTimeoutData.fromJson(Map<String, dynamic> json) => _$CallTimeoutDataFromJson(json);
}
