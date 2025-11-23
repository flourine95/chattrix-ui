import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_accepted_data.freezed.dart';
part 'call_accepted_data.g.dart';

/// Data payload for call accepted notification
@freezed
abstract class CallAcceptedData with _$CallAcceptedData {
  const factory CallAcceptedData({required String callId, required String acceptedBy}) = _CallAcceptedData;

  factory CallAcceptedData.fromJson(Map<String, dynamic> json) => _$CallAcceptedDataFromJson(json);
}
