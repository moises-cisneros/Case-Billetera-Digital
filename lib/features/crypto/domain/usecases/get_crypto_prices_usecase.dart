import 'package:case_digital_wallet/features/crypto/domain/entities/crypto_entity.dart';
import 'package:case_digital_wallet/features/crypto/domain/repositories/crypto_repository.dart';

class GetCryptoPricesUseCase {
  final CryptoRepository repository;

  GetCryptoPricesUseCase(this.repository);

  Future<List<CryptoEntity>> call() async {
    return await repository.getCryptoPrices();
  }
}

class GetCryptoPriceUseCase {
  final CryptoRepository repository;

  GetCryptoPriceUseCase(this.repository);

  Future<CryptoEntity> call(String cryptoId) async {
    return await repository.getCryptoPrice(cryptoId);
  }
} 