import 'package:case_digital_wallet/features/crypto/domain/repositories/crypto_repository.dart';

class SendCryptoUseCase {
  final CryptoRepository repository;

  SendCryptoUseCase(this.repository);

  Future<String?> call(String cryptoId, double amount, String toAddress) async {
    return await repository.sendCrypto(cryptoId, amount, toAddress);
  }
} 