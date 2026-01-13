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
    // ❌ REMOVED: online field (now tracked in OnlineStatusCache)
    DateTime? lastSeen,
    required DateTime createdAt,
  }) = _Contact;
}
