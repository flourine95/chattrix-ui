import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.freezed.dart';

@freezed
abstract class Contact with _$Contact {
  const factory Contact({
    required int id,
    required int contactUserId, // Changed from userId to match API spec
    required String username,
    required String fullName,
    String? avatarUrl,
    String? nickname,
    @Default(false) bool favorite,
    required bool online, // Changed from isOnline to match API spec
    DateTime? lastSeen,
    required DateTime createdAt,
  }) = _Contact;
}
