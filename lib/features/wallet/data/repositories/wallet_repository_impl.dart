import 'package:case_digital_wallet/features/wallet/data/datasources/wallet_remote_datasource.dart';
import 'package:case_digital_wallet/features/wallet/data/models/wallet_models.dart';
import 'package:case_digital_wallet/features/wallet/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;

  WalletRepositoryImpl(this.remoteDataSource);

  @override
  Future<WalletBalance> getBalance() {
    return remoteDataSource.getBalance();
  }

  @override
  Future<DepositResponse> requestDeposit(double amount, String receiptImageUrl) {
    return remoteDataSource.requestDeposit(amount, receiptImageUrl);
  }

  @override
  Future<TransferResponse> transfer(String recipientId, double amount, String currency, String pin) {
    return remoteDataSource.transfer(recipientId, amount, currency, pin);
  }

  @override
  Future<List<Transaction>> getTransactions(int page, int limit) {
    return remoteDataSource.getTransactions(page, limit);
  }
}