import 'package:case_digital_wallet/features/auth/data/models/auth_models.dart';
import 'auth_remote_datasource.dart';

class DevelopmentAuthRemoteDataSource implements AuthRemoteDataSource {
  // Credenciales de desarrollo
  static const _devPhoneNumber = '+59170986680';
  static const _devPassword = 'password123';

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
    await Future.delayed(const Duration(milliseconds: 500));

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
}
