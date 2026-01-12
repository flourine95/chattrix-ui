import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum CallParticipantStatus {
  @JsonValue('RINGING')
  ringing,
  @JsonValue('JOINED')
  joined,
  @JsonValue('LEFT')
  left,
}
