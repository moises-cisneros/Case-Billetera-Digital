import 'package:case_digital_wallet/features/crypto/domain/entities/crypto_entity.dart';
import 'package:case_digital_wallet/features/crypto/domain/repositories/crypto_repository.dart';

class GetUserCryptoBalancesUseCase {
  final CryptoRepository repository;

  GetUserCryptoBalancesUseCase(this.repository);

  Future<List<CryptoBalanceEntity>> call() async {
    return await repository.getUserCryptoBalances();
  }
} 