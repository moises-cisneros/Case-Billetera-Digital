import 'package:case_digital_wallet/features/crypto/domain/repositories/crypto_repository.dart';

class ConvertFromCryptoUseCase {
  final CryptoRepository repository;

  ConvertFromCryptoUseCase(this.repository);

  Future<bool> call(double cryptoAmount, String cryptoId) async {
    return await repository.convertFromCrypto(cryptoAmount, cryptoId);
  }
} 