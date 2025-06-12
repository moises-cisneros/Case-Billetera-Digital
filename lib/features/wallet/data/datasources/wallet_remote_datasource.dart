import 'package:case_digital_wallet/core/network/api_client.dart';
import 'package:case_digital_wallet/features/wallet/data/models/wallet_models.dart';

abstract class WalletRemoteDataSource {
  Future<WalletBalance> getBalance();
  Future<DepositResponse> requestDeposit(double amount, String receiptImageUrl);
  Future<TransferResponse> transfer(String recipientId, double amount, String currency, String pin);
  Future<List<Transaction>> getTransactions(int page, int limit);
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final ApiClient apiClient;

  WalletRemoteDataSourceImpl(this.apiClient);

  @override
  Future<WalletBalance> getBalance() async {
    final response = await apiClient.getBalance();
    
    if (!response.success || response.data == null) {
      throw Exception(response.error ?? 'Failed to get balance');
    }
    
    return response.data!;
  }

  @override
  Future<DepositResponse> requestDeposit(double amount, String receiptImageUrl) async {
    final response = await apiClient.requestDeposit(
      DepositRequest(amount: amount, receiptImageUrl: receiptImageUrl),
    );
    
    if (!response.success || response.data == null) {
      throw Exception(response.error ?? 'Failed to request deposit');
    }
    
    return response.data!;
  }

  @override
  Future<TransferResponse> transfer(String recipientId, double amount, String currency, String pin) async {
    final response = await apiClient.transfer(
      TransferRequest(
        recipientId: recipientId,
        amount: amount,
        currency: currency,
        pin: pin,
      ),
    );
    
    if (!response.success || response.data == null) {
      throw Exception(response.error ?? 'Failed to transfer');
    }
    
    return response.data!;
  }

  @override
  Future<List<Transaction>> getTransactions(int page, int limit) async {
    final response = await apiClient.getTransactions(page, limit);
    
    if (!response.success || response.data == null) {
      throw Exception(response.error ?? 'Failed to get transactions');
    }
    
    return response.data!;
  }
}