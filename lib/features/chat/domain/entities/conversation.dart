import 'package:chattrix_ui/features/chat/domain/entities/message.dart';
import 'package:chattrix_ui/features/chat/domain/entities/participant.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';

@freezed
abstract class Conversation with _$Conversation {
  const factory Conversation({
    required int id,
    String? name,
    required String type, // 'DIRECT' or 'GROUP'
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<Participant> participants,
    Message? lastMessage,
  }) = _Conversation;
}
