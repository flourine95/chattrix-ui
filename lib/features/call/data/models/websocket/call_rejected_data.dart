import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_rejected_data.freezed.dart';
part 'call_rejected_data.g.dart';

/// Data payload for call rejected notification
@freezed
abstract class CallRejectedData with _$CallRejectedData {
  const factory CallRejectedData({
    required String callId,
    required String rejectedBy,
    String? reason, // 'busy', 'declined', 'unavailable'
  }) = _CallRejectedData;

  factory CallRejectedData.fromJson(Map<String, dynamic> json) => _$CallRejectedDataFromJson(json);
}
