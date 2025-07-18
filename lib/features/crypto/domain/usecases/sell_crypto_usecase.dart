import 'package:case_digital_wallet/features/crypto/domain/repositories/crypto_repository.dart';

class SellCryptoUseCase {
  final CryptoRepository repository;

  SellCryptoUseCase(this.repository);

  Future<bool> call(String cryptoId, double amount, double price) async {
    return await repository.sellCrypto(cryptoId, amount, price);
  }
} 