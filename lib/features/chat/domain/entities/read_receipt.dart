import 'package:freezed_annotation/freezed_annotation.dart';

part 'read_receipt.freezed.dart';

@freezed
abstract class ReadReceipt with _$ReadReceipt {
  const factory ReadReceipt({
    required int userId,
    required String username,
    required String fullName,
    String? avatarUrl,
    required DateTime readAt,
  }) = _ReadReceipt;
}

