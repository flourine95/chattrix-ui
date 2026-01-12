import 'package:chattrix_ui/features/auth/data/models/user_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_option_dto.freezed.dart';
part 'poll_option_dto.g.dart';

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
