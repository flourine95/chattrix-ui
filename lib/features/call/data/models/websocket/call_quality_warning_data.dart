import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_quality_warning_data.freezed.dart';
part 'call_quality_warning_data.g.dart';

/// Data payload for call quality warning
@freezed
abstract class CallQualityWarningData with _$CallQualityWarningData {
  const factory CallQualityWarningData({
    required String callId,
    required String quality, // 'POOR', 'BAD', 'VERY_BAD'
  }) = _CallQualityWarningData;

  factory CallQualityWarningData.fromJson(Map<String, dynamic> json) => _$CallQualityWarningDataFromJson(json);
}
