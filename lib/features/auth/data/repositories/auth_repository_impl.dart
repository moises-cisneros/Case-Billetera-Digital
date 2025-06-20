import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:case_digital_wallet/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:case_digital_wallet/features/auth/domain/entities/user_entity.dart';
import 'package:case_digital_wallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:case_digital_wallet/features/auth/data/services/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;
  final AuthService authService;

  AuthRepositoryImpl(
      this.remoteDataSource, this.secureStorage, this.authService);

  @override
  Future<void> requestSms(String phoneNumber) {
    return remoteDataSource.requestSms(phoneNumber);
  }

  @override
  Future<void> verifySms(String phoneNumber, String otpCode) {
    return remoteDataSource.verifySms(phoneNumber, otpCode);
  }

  @override
  Future<UserEntity> completeRegistration(
      String phoneNumber, String password, String pin) async {
    final response =
        await remoteDataSource.completeRegistration(phoneNumber, password, pin);

    // Store token securely
    await secureStorage.write(key: 'auth_token', value: response.token);

    return UserEntity(
      id: response.user.id,
      phoneNumber: response.user.phoneNumber,
      status: response.user.status,
      kycLevel: response.user.kycLevel,
      createdAt: response.user.createdAt,
      email: response.user.email,
      displayName: response.user.displayName,
      photoUrl: response.user.photoUrl,
    );
  }

  @override
  Future<UserEntity> login(String phoneNumber, String password) async {
    final response = await remoteDataSource.login(phoneNumber, password);

    // Store token securely
    await secureStorage.write(key: 'auth_token', value: response.token);

    final user = UserEntity(
      id: response.user.id,
      phoneNumber: response.user.phoneNumber,
      status: response.user.status,
      kycLevel: response.user.kycLevel,
      createdAt: response.user.createdAt,
      email: response.user.email,
      displayName: response.user.displayName,
      photoUrl: response.user.photoUrl,
    );

    // Almacenar usuario en SharedPreferences
    await authService.saveAuthState(true);
    await authService.saveUser(user);

    return user;
  }

  @override
  Future<UserEntity> googleRegister({required String googleIdToken}) async {
    final response = await remoteDataSource.signInWithGoogle(googleIdToken);

    // Store token securely
    await secureStorage.write(key: 'auth_token', value: response.token);

    final user = UserEntity(
      id: response.user.id,
      phoneNumber: response
          .user.phoneNumber, // This might be null for Google users initially
      status: response.user.status,
      kycLevel: response.user.kycLevel,
      createdAt: response.user.createdAt,
      email: response.user.email,
      displayName: response.user.displayName,
      photoUrl: response.user.photoUrl,
    );

    await authService.saveAuthState(true);
    await authService.saveUser(user);

    return user;
  }

  @override
  Future<List<String>> generateWalletMnemonic() async {
    final response = await remoteDataSource.generateWallet();
    return response.mnemonic;
  }

  @override
  Future<UserEntity> registerBlockchain(
      String userId, String walletAddress) async {
    final response =
        await remoteDataSource.registerBlockchain(userId, walletAddress);
    // Assuming a successful blockchain registration updates user status
    // For mock purposes, let's update the current user's status
    UserEntity? currentUser = await authService.getUser();
    if (currentUser != null) {
      currentUser = UserEntity(
        id: currentUser.id,
        phoneNumber: currentUser.phoneNumber,
        status: response.status, // Update status to 'registered'
        kycLevel: currentUser.kycLevel, // Keep existing KYC level
        createdAt: currentUser.createdAt,
        email: currentUser.email,
        displayName: currentUser.displayName,
        photoUrl: currentUser.photoUrl,
      );
      await authService.saveUser(currentUser);
      return currentUser;
    } else {
      throw Exception('User not found for blockchain registration update');
    }
  }

  @override
  Future<void> logout() async {
    await secureStorage.delete(key: 'auth_token');
    await authService.clearSession();
  }

  @override
  Future<bool> isLoggedIn() async {
    return authService.isAuthenticated();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    if (!await isLoggedIn()) {
      return null;
    }
    return authService.getUser();
  }
}
