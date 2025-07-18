import 'package:dio/dio.dart';
import 'package:case_digital_wallet/features/crypto/domain/entities/crypto_entity.dart';
import 'package:case_digital_wallet/features/crypto/domain/repositories/crypto_repository.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final Dio _dio = Dio();

  @override
  Future<List<CryptoEntity>> getCryptoPrices() async {
    try {
      // Usar CoinGecko API para obtener precios reales
      final response = await _dio.get(
        'https://api.coingecko.com/api/v3/simple/price',
        queryParameters: {
          'ids': 'bitcoin,ethereum,tether,binancecoin,cardano,solana',
          'vs_currencies': 'usd,bsd',
          'include_24hr_change': 'true',
        },
      );

      final data = response.data as Map<String, dynamic>;
      final List<CryptoEntity> cryptos = [];

      // Mapear los datos de la API a nuestras entidades
      data.forEach((id, priceData) {
        final prices = priceData as Map<String, dynamic>;
        cryptos.add(CryptoEntity(
          id: id,
          symbol: _getSymbolFromId(id),
          name: _getNameFromId(id),
          priceUSD: (prices['usd'] as num).toDouble(),
          priceBSD: (prices['bsd'] as num?)?.toDouble() ?? 0.0,
          change24h: (prices['usd_24h_change'] as num?)?.toDouble() ?? 0.0,
        ));
      });

      return cryptos;
    } catch (e) {
      // Fallback a datos mock si la API falla
      return _getMockCryptoData();
    }
  }

  @override
  Future<CryptoEntity> getCryptoPrice(String cryptoId) async {
    final cryptos = await getCryptoPrices();
    return cryptos.firstWhere((crypto) => crypto.id == cryptoId);
  }

  @override
  Future<List<CryptoBalanceEntity>> getUserCryptoBalances() async {
    // Mock data - en producción vendría del backend
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      CryptoBalanceEntity(symbol: 'USDT', amount: 45.32),
      CryptoBalanceEntity(symbol: 'BTC', amount: 0.0012),
      CryptoBalanceEntity(symbol: 'ETH', amount: 0.023),
    ];
  }

  @override
  Future<List<CryptoTransactionEntity>> getCryptoTransactions() async {
    // Mock data - en producción vendría del backend
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      CryptoTransactionEntity(
        id: '1',
        type: 'buy',
        symbol: 'USDT',
        amount: 100.0,
        price: 1.0,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      CryptoTransactionEntity(
        id: '2',
        type: 'sell',
        symbol: 'BTC',
        amount: 0.001,
        price: 45000.0,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  @override
  Future<bool> buyCrypto(String cryptoId, double amount, double price) async {
    // Mock implementation - en producción haría la transacción real
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<bool> sellCrypto(String cryptoId, double amount, double price) async {
    // Mock implementation - en producción haría la transacción real
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<String?> sendCrypto(String cryptoId, double amount, String toAddress) async {
    // Mock implementation - en producción haría la transacción real
    await Future.delayed(const Duration(seconds: 1));
    return 'tx_hash_123456';
  }

  @override
  Future<bool> convertToCrypto(double bsAmount, String cryptoId) async {
    try {
      // Obtener precio actual de la crypto
      final crypto = await getCryptoPrice(cryptoId);
      
      // Convertir usando el precio actual
      final cryptoAmount = bsAmount / crypto.priceUSD;
      
      // Aquí se haría la transacción real
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> convertFromCrypto(double cryptoAmount, String cryptoId) async {
    try {
      // Obtener precio actual de la crypto
      final crypto = await getCryptoPrice(cryptoId);
      
      // Convertir usando el precio actual
      final bsAmount = cryptoAmount * crypto.priceUSD;
      
      // Aquí se haría la transacción real
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      return false;
    }
  }

  // Helper methods
  String _getSymbolFromId(String id) {
    switch (id) {
      case 'bitcoin': return 'BTC';
      case 'ethereum': return 'ETH';
      case 'tether': return 'USDT';
      case 'binancecoin': return 'BNB';
      case 'cardano': return 'ADA';
      case 'solana': return 'SOL';
      default: return id.toUpperCase();
    }
  }

  String _getNameFromId(String id) {
    switch (id) {
      case 'bitcoin': return 'Bitcoin';
      case 'ethereum': return 'Ethereum';
      case 'tether': return 'Tether';
      case 'binancecoin': return 'Binance Coin';
      case 'cardano': return 'Cardano';
      case 'solana': return 'Solana';
      default: return id;
    }
  }

  List<CryptoEntity> _getMockCryptoData() {
    return [
      CryptoEntity(
        id: 'bitcoin',
        symbol: 'BTC',
        name: 'Bitcoin',
        priceUSD: 45000.0,
        priceBSD: 310500.0,
        change24h: 2.5,
      ),
      CryptoEntity(
        id: 'ethereum',
        symbol: 'ETH',
        name: 'Ethereum',
        priceUSD: 3200.0,
        priceBSD: 220800.0,
        change24h: -1.2,
      ),
      CryptoEntity(
        id: 'tether',
        symbol: 'USDT',
        name: 'Tether',
        priceUSD: 1.0,
        priceBSD: 6.9,
        change24h: 0.1,
      ),
      CryptoEntity(
        id: 'binancecoin',
        symbol: 'BNB',
        name: 'Binance Coin',
        priceUSD: 320.0,
        priceBSD: 2208.0,
        change24h: 3.8,
      ),
    ];
  }
} 