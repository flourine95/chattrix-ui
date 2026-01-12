import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement_model.freezed.dart';
part 'announcement_model.g.dart';

/// Model for announcement (which is a special type of message)
@freezed
abstract class AnnouncementModel with _$AnnouncementModel {
  const factory AnnouncementModel({
    required int id,
    required int conversationId,
    required int senderId,
    String? senderUsername,
    String? senderFullName,
    required String content,
    required String type,
    Map<String, List<int>>? reactions,
    required String sentAt,
    required String createdAt,
    String? updatedAt,
    @Default(false) bool edited,
    @Default(false) bool deleted,
    @Default(false) bool forwarded,
    @Default(0) int forwardCount,
    @Default(false) bool scheduled,
  }) = _AnnouncementModel;

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) => _$AnnouncementModelFromJson(json);
}
