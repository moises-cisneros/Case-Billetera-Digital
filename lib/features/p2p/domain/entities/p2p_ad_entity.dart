import 'package:equatable/equatable.dart';

enum P2PAdStatus { active, completed, cancelled }

enum P2PAdType { buy, sell }

class P2PAd extends Equatable {
  final String id;
  final String creatorAddress;
  final String creatorName;
  final P2PAdType type;
  final double amount;
  final double price;
  final String currency;
  final P2PAdStatus status;
  final DateTime createdAt;
  final String? description;
  final double? minAmount;
  final double? maxAmount;
  final String paymentMethod;

  const P2PAd({
    required this.id,
    required this.creatorAddress,
    required this.creatorName,
    required this.type,
    required this.amount,
    required this.price,
    required this.currency,
    required this.status,
    required this.createdAt,
    required this.paymentMethod,
    this.description,
    this.minAmount,
    this.maxAmount,
  });

  double get totalValue => amount * price;

  bool get isActive => status == P2PAdStatus.active;

  @override
  List<Object?> get props => [
        id,
        creatorAddress,
        creatorName,
        type,
        amount,
        price,
        currency,
        status,
        createdAt,
        description,
        minAmount,
        maxAmount,
        paymentMethod,
      ];

  P2PAd copyWith({
    String? id,
    String? creatorAddress,
    String? creatorName,
    P2PAdType? type,
    double? amount,
    double? price,
    String? currency,
    P2PAdStatus? status,
    DateTime? createdAt,
    String? description,
    double? minAmount,
    double? maxAmount,
    String? paymentMethod,
  }) {
    return P2PAd(
      id: id ?? this.id,
      creatorAddress: creatorAddress ?? this.creatorAddress,
      creatorName: creatorName ?? this.creatorName,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
