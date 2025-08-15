import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:case_digital_wallet/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:case_digital_wallet/features/auth/domain/entities/user_entity.dart';
import 'package:case_digital_wallet/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage secureStorage;

  AuthRepositoryImpl(this.remoteDataSource, this.secureStorage);

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
    );
  }

  @override
  Future<UserEntity> login(String phoneNumber, String password) async {
    final response = await remoteDataSource.login(phoneNumber, password);

    // Store token securely
    await secureStorage.write(key: 'auth_token', value: response.token);

    return UserEntity(
      id: response.user.id,
      phoneNumber: response.user.phoneNumber,
      status: response.user.status,
      kycLevel: response.user.kycLevel,
      createdAt: response.user.createdAt,
    );
  }

  @override
  Future<void> logout() async {
    await secureStorage.delete(key: 'auth_token');
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await secureStorage.read(key: 'auth_token');
    return token != null;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    // TODO: Implement get current user from token
    return null;
  }
}
