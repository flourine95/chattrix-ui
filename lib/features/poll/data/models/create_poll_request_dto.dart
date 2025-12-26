import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_poll_request_dto.freezed.dart';
part 'create_poll_request_dto.g.dart';

@freezed
abstract class CreatePollRequestDto with _$CreatePollRequestDto {
  const factory CreatePollRequestDto({
    required String question,
    required List<String> options,
    required bool allowMultipleVotes,
    @JsonKey(name: 'expiresAt', toJson: _dateTimeToMilliseconds, fromJson: _millisecondsToDateTime) DateTime? expiresAt,
  }) = _CreatePollRequestDto;

  factory CreatePollRequestDto.fromJson(Map<String, dynamic> json) => _$CreatePollRequestDtoFromJson(json);
}

/// Convert DateTime to milliseconds timestamp for Java Instant
int? _dateTimeToMilliseconds(DateTime? dateTime) {
  return dateTime?.millisecondsSinceEpoch;
}

/// Convert milliseconds timestamp to DateTime
DateTime? _millisecondsToDateTime(dynamic value) {
  if (value == null) return null;
  if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
  if (value is String) return DateTime.parse(value);
  return null;
}
