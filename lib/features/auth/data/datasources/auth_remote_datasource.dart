import 'package:case_digital_wallet/core/network/api_client.dart';
import 'package:case_digital_wallet/features/auth/data/models/auth_models.dart';

abstract class AuthRemoteDataSource {
  Future<void> requestSms(String phoneNumber);
  Future<void> verifySms(String phoneNumber, String otpCode);
  Future<AuthResponse> completeRegistration(
      String phoneNumber, String password, String pin);
  Future<AuthResponse> login(String phoneNumber, String password);
  Future<AuthResponse> googleAuth(
      String email, String displayName, String? photoUrl);
  Future<WalletGenerateResponse> generateWallet();
  Future<UserBlockchainRegisterResponse> registerBlockchain(
      String userId, String walletAddress);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<void> requestSms(String phoneNumber) async {
    final response = await apiClient.requestSms(
      RequestSmsRequest(phoneNumber: phoneNumber),
    );

    if (!response.success) {
      throw Exception(response.error ?? 'Failed to request SMS');
    }
  }

  @override
  Future<void> verifySms(String phoneNumber, String otpCode) async {
    final response = await apiClient.verifySms(
      VerifySmsRequest(phoneNumber: phoneNumber, otpCode: otpCode),
    );

    if (!response.success) {
      throw Exception(response.error ?? 'Failed to verify SMS');
    }
  }

  @override
  Future<AuthResponse> completeRegistration(
      String phoneNumber, String password, String pin) async {
    final response = await apiClient.completeRegistration(
      CompleteRegistrationRequest(
        phoneNumber: phoneNumber,
        password: password,
        pin: pin,
      ),
    );

    if (!response.success || response.data == null) {
      throw Exception(response.error ?? 'Failed to complete registration');
    }

    return response.data!;
  }

  @override
  Future<AuthResponse> login(String phoneNumber, String password) async {
    final response = await apiClient.login(
      LoginRequest(phoneNumber: phoneNumber, password: password),
    );

    if (!response.success || response.data == null) {
      throw Exception(response.error ?? 'Failed to login');
    }

    return response.data!;
  }

  @override
  Future<AuthResponse> googleAuth(
      String email, String displayName, String? photoUrl) {
    // TODO: implement googleAuth
    throw UnimplementedError();
  }

  @override
  Future<WalletGenerateResponse> generateWallet() {
    // TODO: implement generateWallet
    throw UnimplementedError();
  }

  @override
  Future<UserBlockchainRegisterResponse> registerBlockchain(
      String userId, String walletAddress) {
    // TODO: implement registerBlockchain
    throw UnimplementedError();
  }
}
