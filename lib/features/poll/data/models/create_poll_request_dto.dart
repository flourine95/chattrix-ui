import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_poll_request_dto.freezed.dart';
part 'create_poll_request_dto.g.dart';

/// DTO for Create Poll API request
@freezed
abstract class CreatePollRequestDto with _$CreatePollRequestDto {
  const factory CreatePollRequestDto({
    required String question,
    required List<String> options,
    required bool allowMultipleVotes,
    DateTime? expiresAt,
  }) = _CreatePollRequestDto;

  factory CreatePollRequestDto.fromJson(Map<String, dynamic> json) => _$CreatePollRequestDtoFromJson(json);
}
