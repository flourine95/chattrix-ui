import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum CallRejectReason {
  @JsonValue('busy')
  busy,
  @JsonValue('declined')
  declined,
  @JsonValue('unavailable')
  unavailable,
}
