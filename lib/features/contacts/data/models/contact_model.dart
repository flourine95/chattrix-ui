import 'package:chattrix_ui/features/contacts/domain/entities/contact.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_model.freezed.dart';
part 'contact_model.g.dart';

@freezed
abstract class ContactModel with _$ContactModel {
  const ContactModel._();

  const factory ContactModel({
    required int id,
    required int contactUserId,
    required String username,
    required String fullName,
    String? avatarUrl,
    String? nickname,
    required bool isOnline,
    required DateTime lastSeen,
    required DateTime createdAt,
    @Default(false) bool isFavorite,
  }) = _ContactModel;

  factory ContactModel.fromJson(Map<String, dynamic> json) => _$ContactModelFromJson(json);

  Contact toEntity() {
    return Contact(
      id: id,
      userId: contactUserId,
      username: username,
      email: '', // Not provided by API
      fullName: fullName,
      avatarUrl: avatarUrl,
      nickname: nickname,
      isOnline: isOnline,
      lastSeen: lastSeen,
      createdAt: createdAt,
    );
  }
}
