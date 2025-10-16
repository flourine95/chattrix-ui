import 'package:freezed_annotation/freezed_annotation.dart';

import 'participant.dart';

part 'conversation.freezed.dart';

@freezed
abstract class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    String? name,
    required String type, // 'DIRECT' or 'GROUP'
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<Participant> participants,
  }) = _Conversation;
}
