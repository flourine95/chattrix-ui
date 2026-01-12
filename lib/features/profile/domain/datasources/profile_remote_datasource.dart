import 'package:chattrix_ui/features/profile/data/models/profile_model.dart';
import 'package:chattrix_ui/features/profile/data/models/update_profile_request.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();

  Future<ProfileModel> updateProfile(UpdateProfileRequest request);
}
