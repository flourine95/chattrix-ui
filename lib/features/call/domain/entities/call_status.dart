import 'package:json_annotation/json_annotation.dart';
@JsonEnum()
enum CallStatus {
  @JsonValue('RINGING')
  ringing,
  @JsonValue('CONNECTING')
  connecting,
  @JsonValue('CONNECTED')
  connected,
  @JsonValue('REJECTED')
  rejected,
  @JsonValue('ENDED')
  ended,
  @JsonValue('INITIATING')
  initiating,
}
