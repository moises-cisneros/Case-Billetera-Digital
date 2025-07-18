import 'package:case_digital_wallet/features/crypto/domain/entities/crypto_entity.dart';
import 'package:case_digital_wallet/features/crypto/domain/repositories/crypto_repository.dart';

class GetCryptoTransactionsUseCase {
  final CryptoRepository repository;

  GetCryptoTransactionsUseCase(this.repository);

  Future<List<CryptoTransactionEntity>> call() async {
    return await repository.getCryptoTransactions();
  }
} 