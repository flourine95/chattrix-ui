import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum CallType {
  @JsonValue('AUDIO')
  audio,
  @JsonValue('VIDEO')
  video,
}
