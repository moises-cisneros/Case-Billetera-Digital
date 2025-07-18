import 'package:equatable/equatable.dart';

class CryptoEntity extends Equatable {
  final String id;
  final String name;
  final String symbol;
  final double priceUSD;
  final double priceBSD;
  final double change24h;

  const CryptoEntity({
    required this.id,
    required this.name,
    required this.symbol,
    required this.priceUSD,
    required this.priceBSD,
    required this.change24h,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        symbol,
        priceUSD,
        priceBSD,
        change24h,
      ];
}

class CryptoBalanceEntity extends Equatable {
  final String symbol;
  final double amount;

  const CryptoBalanceEntity({
    required this.symbol,
    required this.amount,
  });

  @override
  List<Object?> get props => [symbol, amount];
}

class CryptoTransactionEntity extends Equatable {
  final String id;
  final String type; // 'buy', 'sell', 'send', 'receive'
  final String symbol;
  final double amount;
  final double price;
  final DateTime timestamp;

  const CryptoTransactionEntity({
    required this.id,
    required this.type,
    required this.symbol,
    required this.amount,
    required this.price,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        symbol,
        amount,
        price,
        timestamp,
      ];
} 