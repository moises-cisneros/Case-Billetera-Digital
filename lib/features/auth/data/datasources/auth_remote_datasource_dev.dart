import 'package:case_digital_wallet/features/auth/data/models/auth_models.dart';
import 'auth_remote_datasource.dart';

class DevelopmentAuthRemoteDataSource implements AuthRemoteDataSource {
  // Credenciales de desarrollo
  static const _devPhoneNumber = '+59170986680';
  static const _devPassword = 'password123';

  // Static counter to alternate between new and existing user mocks for Google Sign-In
  static int _googleSignInCallCount = 0;

  @override
  Future<void> requestSms(String phoneNumber) async {
    // Simular delay de red
    await Future.delayed(const Duration(milliseconds: 500));

    // Solo permitir el número de desarrollo
    if (phoneNumber != _devPhoneNumber) {
      throw Exception('Número no válido. Use: $_devPhoneNumber');
    }
  }

  @override
  Future<void> verifySms(String phoneNumber, String otpCode) async {
    // Simular delay de red
    await Future.delayed(const Duration(milliseconds: 500));

    // Cualquier código OTP es válido para desarrollo
    if (phoneNumber != _devPhoneNumber) {
      throw Exception('Número no válido. Use: $_devPhoneNumber');
    }
  }

  @override
  Future<AuthResponse> completeRegistration(
      String phoneNumber, String password, String pin) async {
    // Simular delay de red
    await Future.delayed(const Duration(milliseconds: 500));

    if (phoneNumber != _devPhoneNumber) {
      throw Exception('Número no válido. Use: $_devPhoneNumber');
    }

    // Crear una respuesta de autenticación de prueba
    return AuthResponse(
      token: 'dev-token-${DateTime.now().millisecondsSinceEpoch}',
      user: User(
        id: 'dev-user-1',
        phoneNumber: phoneNumber,
        status: 'active',
        kycLevel: 'basic',
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<AuthResponse> login(String phoneNumber, String password) async {
    // Simular delay de red
    await Future.delayed(const Duration(seconds: 2));

    // Validar credenciales de desarrollo
    if (phoneNumber != _devPhoneNumber || password != _devPassword) {
      throw Exception(
          'Credenciales inválidas. Use:\nTeléfono: $_devPhoneNumber\nContraseña: $_devPassword');
    }

    // Devolver usuario de prueba
    return AuthResponse(
      token: 'dev-token-${DateTime.now().millisecondsSinceEpoch}',
      user: User(
        id: 'dev-user-1',
        phoneNumber: phoneNumber,
        status: 'active',
        kycLevel: 'basic',
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<AuthResponse> signInWithGoogle(String googleIdToken) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    _googleSignInCallCount++;

    // Alternate between a new user (pending_wallet) and an existing user (active)
    final isNewUser =
        _googleSignInCallCount % 2 != 0; // Odd calls simulate new user

    String userStatus = isNewUser ? 'pending_wallet' : 'active';

    // Mock response for Google OAuth
    return AuthResponse(
      token: 'google-dev-token-${DateTime.now().millisecondsSinceEpoch}',
      user: User(
        id: 'google-user-user-${DateTime.now().millisecondsSinceEpoch}',
        phoneNumber:
            '', // Phone number might not be available from Google OAuth directly
        status: userStatus,
        kycLevel: 'none',
        createdAt: DateTime.now(),
        email: 'mock.user.${_googleSignInCallCount}@example.com',
        displayName: 'Mock User ${_googleSignInCallCount}',
        photoUrl: '',
      ),
    );
  }

  @override
  Future<WalletGenerateResponse> generateWallet() async {
    // Simulate API call for mnemonic generation
    await Future.delayed(const Duration(seconds: 2));
    final mnemonic = List.generate(
        12, (index) => 'word${index + 1}'); // Generate 12 mock words
    final walletAddress =
        '0x${List.generate(40, (index) => (index % 10).toString()).join()}'; // Mock wallet address
    return WalletGenerateResponse(
        mnemonic: mnemonic, walletAddress: walletAddress);
  }

  @override
  Future<UserBlockchainRegisterResponse> registerBlockchain(
      String userId, String walletAddress) async {
    // Simulate API call for blockchain registration
    await Future.delayed(const Duration(seconds: 2));
    return UserBlockchainRegisterResponse(
        status: 'registered', walletAddress: walletAddress);
  }

  @override
  Future<void> logout() async {
    // Simulate API call for logout
    await Future.delayed(const Duration(seconds: 1));
    return; // Simulate success
  }
}
