import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum CallEndReason {
  @JsonValue('hangup')
  hangup,
  @JsonValue('network error')
  networkError,
  @JsonValue('device error')
  deviceError,
  @JsonValue('timeout')
  timeout,
}
