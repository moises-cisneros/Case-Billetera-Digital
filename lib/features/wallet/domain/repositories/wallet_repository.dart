import 'package:case_digital_wallet/features/wallet/data/models/wallet_models.dart';

abstract class WalletRepository {
  Future<WalletBalance> getBalance();
  Future<DepositResponse> requestDeposit(double amount, String receiptImageUrl);
  Future<TransferResponse> transfer(String recipientId, double amount, String currency, String pin);
  Future<List<Transaction>> getTransactions(int page, int limit);
}