import 'package:case_digital_wallet/features/crypto/domain/entities/crypto_entity.dart';

abstract class CryptoRepository {
  Future<List<CryptoEntity>> getCryptoPrices();
  Future<CryptoEntity> getCryptoPrice(String cryptoId);
  Future<List<CryptoBalanceEntity>> getUserCryptoBalances();
  Future<List<CryptoTransactionEntity>> getCryptoTransactions();
  Future<bool> buyCrypto(String cryptoId, double amount, double price);
  Future<bool> sellCrypto(String cryptoId, double amount, double price);
  Future<String?> sendCrypto(String cryptoId, double amount, String toAddress);
  Future<bool> convertToCrypto(double bsAmount, String cryptoId);
  Future<bool> convertFromCrypto(double cryptoAmount, String cryptoId);
} 