import 'package:case_digital_wallet/features/crypto/domain/repositories/crypto_repository.dart';

class ConvertToCryptoUseCase {
  final CryptoRepository repository;

  ConvertToCryptoUseCase(this.repository);

  Future<bool> call(double bsAmount, String cryptoId) async {
    return await repository.convertToCrypto(bsAmount, cryptoId);
  }
} 