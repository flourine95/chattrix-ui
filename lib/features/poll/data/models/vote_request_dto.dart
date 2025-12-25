import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote_request_dto.freezed.dart';
part 'vote_request_dto.g.dart';

@freezed
abstract class VoteRequestDto with _$VoteRequestDto {
  const factory VoteRequestDto({required List<int> optionIds}) = _VoteRequestDto;

  factory VoteRequestDto.fromJson(Map<String, dynamic> json) => _$VoteRequestDtoFromJson(json);
}
