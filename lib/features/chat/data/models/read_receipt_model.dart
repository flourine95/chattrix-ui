import 'package:chattrix_ui/features/chat/domain/entities/read_receipt.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'read_receipt_model.freezed.dart';
part 'read_receipt_model.g.dart';

@freezed
abstract class ReadReceiptModel with _$ReadReceiptModel {
  const ReadReceiptModel._();

  const factory ReadReceiptModel({
    required int userId,
    required String username,
    required String fullName,
    String? avatarUrl,
    required DateTime readAt,
  }) = _ReadReceiptModel;

  factory ReadReceiptModel.fromJson(Map<String, dynamic> json) => _$ReadReceiptModelFromJson(json);

  ReadReceipt toEntity() {
    return ReadReceipt(userId: userId, username: username, fullName: fullName, avatarUrl: avatarUrl, readAt: readAt);
  }
}
