import 'package:case_digital_wallet/features/auth/domain/entities/user_entity.dart';
import 'package:case_digital_wallet/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<void> requestSms(String phoneNumber) {
    return repository.requestSms(phoneNumber);
  }

  Future<void> verifySms(String phoneNumber, String otpCode) {
    return repository.verifySms(phoneNumber, otpCode);
  }

  Future<UserEntity> completeRegistration(String phoneNumber, String password, String pin) {
    return repository.completeRegistration(phoneNumber, password, pin);
  }
}