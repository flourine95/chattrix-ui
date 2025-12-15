import 'package:chattrix_ui/core/domain/enums/enums.dart';
import 'package:chattrix_ui/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required int id,
    required String username,
    required String email,
    required bool emailVerified,
    String? phone,
    required String fullName,
    String? avatarUrl,
    String? bio,
    @JsonKey(unknownEnumValue: Gender.other) Gender? gender,
    DateTime? dateOfBirth,
    String? location,
    @JsonKey(unknownEnumValue: ProfileVisibility.public) ProfileVisibility? profileVisibility,
    required bool online,
    String? lastSeen,
    required String createdAt,
    String? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
      emailVerified: emailVerified,
      phone: phone,
      fullName: fullName,
      avatarUrl: avatarUrl,
      bio: bio,
      gender: gender,
      dateOfBirth: dateOfBirth,
      location: location,
      profileVisibility: profileVisibility,
      online: online,
      lastSeen: lastSeen != null ? DateTime.parse(lastSeen!) : null,
      createdAt: DateTime.parse(createdAt),
      updatedAt: updatedAt != null ? DateTime.parse(updatedAt!) : null,
    );
  }
}
