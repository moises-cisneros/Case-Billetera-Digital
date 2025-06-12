import 'package:case_digital_wallet/features/wallet/data/models/wallet_models.dart';
import 'package:case_digital_wallet/features/wallet/domain/repositories/wallet_repository.dart';

class GetBalanceUseCase {
  final WalletRepository repository;

  GetBalanceUseCase(this.repository);

  Future<WalletBalance> call() {
    return repository.getBalance();
  }
}