import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/user_profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<UserProfileEntity> getUserProfile() async {
    // Mock data - in real app this would come from API
    await Future.delayed(const Duration(milliseconds: 500));
    
    return UserProfileModel(
      id: 'user_123',
      name: 'Juan Pérez',
      email: 'juan.perez@email.com',
      phone: '+591 70012345',
      profileImage: null,
      documentNumber: '12345678',
      isVerified: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lastLogin: DateTime.now(),
    );
  }

  @override
  Future<UserProfileEntity> updateUserProfile(UserProfileEntity profile) async {
    // Mock update - in real app this would call API
    await Future.delayed(const Duration(milliseconds: 800));
    
    return profile;
  }

  @override
  Future<String> uploadProfileImage(String imagePath) async {
    // Mock upload - in real app this would upload to cloud storage
    await Future.delayed(const Duration(seconds: 2));
    
    return 'https://example.com/profile_images/user_123.jpg';
  }

  @override
  Future<void> deleteProfileImage() async {
    // Mock delete - in real app this would delete from cloud storage
    await Future.delayed(const Duration(milliseconds: 500));
  }
} 