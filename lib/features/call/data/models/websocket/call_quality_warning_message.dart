import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chattrix_ui/features/call/data/models/websocket/call_quality_warning_data.dart';

part 'call_quality_warning_message.freezed.dart';
part 'call_quality_warning_message.g.dart';

/// WebSocket message for call quality warning (Server → Client)
/// Sent when network quality degrades during call
@freezed
abstract class CallQualityWarningMessage with _$CallQualityWarningMessage {
  const factory CallQualityWarningMessage({
    required String type,
    required CallQualityWarningData data,
    required DateTime timestamp,
  }) = _CallQualityWarningMessage;

  factory CallQualityWarningMessage.fromJson(Map<String, dynamic> json) => _$CallQualityWarningMessageFromJson(json);
}
