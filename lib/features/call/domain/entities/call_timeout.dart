import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_timeout.freezed.dart';

@freezed
abstract class CallTimeout with _$CallTimeout {
  const factory CallTimeout({required String callId, required String reason}) = _CallTimeout;
}
