import 'dart:io';

import 'package:chattrix_ui/core/errors/failures.dart';
import 'package:chattrix_ui/features/auth/presentation/providers/auth_providers.dart';
import 'package:chattrix_ui/features/chat/services/cloudinary_provider.dart';
import 'package:chattrix_ui/features/profile/data/datasources/profile_remote_datasource_impl.dart';
import 'package:chattrix_ui/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:chattrix_ui/features/profile/domain/datasources/profile_remote_datasource.dart';
import 'package:chattrix_ui/features/profile/domain/entities/profile.dart';
import 'package:chattrix_ui/features/profile/domain/entities/update_profile_params.dart';
import 'package:chattrix_ui/features/profile/domain/repositories/profile_repository.dart';
import 'package:chattrix_ui/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:chattrix_ui/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_providers.g.dart';

@riverpod
ProfileRemoteDataSource profileRemoteDataSource(Ref ref) {
  return ProfileRemoteDataSourceImpl(dio: ref.watch(dioProvider));
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepositoryImpl(remoteDataSource: ref.watch(profileRemoteDataSourceProvider));
}

@riverpod
GetProfileUseCase getProfileUseCase(Ref ref) {
  return GetProfileUseCase(ref.watch(profileRepositoryProvider));
}

@riverpod
UpdateProfileUseCase updateProfileUseCase(Ref ref) {
  return UpdateProfileUseCase(ref.watch(profileRepositoryProvider));
}

@riverpod
class ProfileController extends _$ProfileController {
  @override
  FutureOr<Profile> build() async {
    return _fetchProfile();
  }

  Future<Profile> _fetchProfile() async {
    final useCase = ref.read(getProfileUseCaseProvider);
    final result = await useCase();

    return result.fold(
      (failure) => throw Exception(failure.userMessage),
      (profile) => profile,
    );
  }

  Future<void> updateProfile({required UpdateProfileParams params, File? newAvatarFile}) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      String? avatarUrl = params.avatarUrl;

      if (newAvatarFile != null) {
        final cloudinaryService = ref.read(cloudinaryServiceProvider);
        final uploadResult = await cloudinaryService.uploadImage(newAvatarFile);
        avatarUrl = uploadResult.url;
      }

      final updatedParams = params.copyWith(avatarUrl: avatarUrl);
      final updateUseCase = ref.read(updateProfileUseCaseProvider);
      final result = await updateUseCase(updatedParams);

      return result.fold((failure) => throw Exception(failure.userMessage), (newProfile) => newProfile);
    });
  }
}
