import 'package:case_digital_wallet/features/crypto/domain/repositories/crypto_repository.dart';

class BuyCryptoUseCase {
  final CryptoRepository repository;

  BuyCryptoUseCase(this.repository);

  Future<bool> call(String cryptoId, double amount, double price) async {
    return await repository.buyCrypto(cryptoId, amount, price);
  }
} 