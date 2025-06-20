import 'package:case_digital_wallet/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<void> requestSms(String phoneNumber);
  Future<void> verifySms(String phoneNumber, String otpCode);
  Future<UserEntity> completeRegistration(
      String phoneNumber, String password, String pin);
  Future<UserEntity> login(String phoneNumber, String password);
  Future<UserEntity> googleRegister(
      String email, String displayName, String? photoUrl);
  Future<List<String>> generateWalletMnemonic();
  Future<UserEntity> registerBlockchain(String userId, String walletAddress);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<UserEntity?> getCurrentUser();
}
