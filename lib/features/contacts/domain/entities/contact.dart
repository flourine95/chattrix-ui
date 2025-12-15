import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact.freezed.dart';

@freezed
abstract class Contact with _$Contact {
  const factory Contact({
    required int id,
    required int userId,
    required String username,
    required String fullName,
    String? avatarUrl,
    String? nickname,
    @Default(false) bool favorite,
    required bool isOnline,
    DateTime? lastSeen,
    required DateTime createdAt,
  }) = _Contact;
}
