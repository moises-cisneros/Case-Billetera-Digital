import 'package:case_digital_wallet/features/auth/domain/entities/user_entity.dart';
import 'package:case_digital_wallet/features/auth/domain/repositories/auth_repository.dart';

class GoogleSignInUseCase {
  final AuthRepository repository;

  GoogleSignInUseCase(this.repository);

  Future<UserEntity> call(String googleIdToken) async {
    return await repository.googleRegister(googleIdToken: googleIdToken);
  }
}
