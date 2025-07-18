import '../entities/user_profile_entity.dart';

abstract class ProfileRepository {
  Future<UserProfileEntity> getUserProfile();
  Future<UserProfileEntity> updateUserProfile(UserProfileEntity profile);
  Future<String> uploadProfileImage(String imagePath);
  Future<void> deleteProfileImage();
} 