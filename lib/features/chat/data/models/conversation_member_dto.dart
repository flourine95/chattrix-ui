import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_member_dto.freezed.dart';
part 'conversation_member_dto.g.dart';

@freezed
abstract class ConversationMemberDto with _$ConversationMemberDto {
  const factory ConversationMemberDto({
    required int id,
    required String fullName,
    required String username,
    required String email,
    String? avatarUrl,
    required bool online,
  }) = _ConversationMemberDto;

  factory ConversationMemberDto.fromJson(Map<String, dynamic> json) => _$ConversationMemberDtoFromJson(json);
}

