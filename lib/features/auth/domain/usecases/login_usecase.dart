import 'package:case_digital_wallet/features/auth/domain/entities/user_entity.dart';
import 'package:case_digital_wallet/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(String phoneNumber, String password) {
    return repository.login(phoneNumber, password);
  }
}