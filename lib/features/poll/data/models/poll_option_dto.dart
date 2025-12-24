import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../auth/data/models/user_dto.dart';

part 'poll_option_dto.freezed.dart';
part 'poll_option_dto.g.dart';

/// DTO for Poll Option API response
@freezed
abstract class PollOptionDto with _$PollOptionDto {
  const factory PollOptionDto({
    required int id,
    required String optionText,
    required int optionOrder,
    required int voteCount,
    required double percentage,
    required List<UserDto> voters,
  }) = _PollOptionDto;

  factory PollOptionDto.fromJson(Map<String, dynamic> json) => _$PollOptionDtoFromJson(json);
}
