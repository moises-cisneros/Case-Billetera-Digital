import 'package:json_annotation/json_annotation.dart';

part 'wallet_models.g.dart';

@JsonSerializable()
class WalletBalance {
  final double balanceBS;
  final double balanceUSDT;
  final double exchangeRate;

  WalletBalance({
    required this.balanceBS,
    required this.balanceUSDT,
    required this.exchangeRate,
  });

  factory WalletBalance.fromJson(Map<String, dynamic> json) =>
      _$WalletBalanceFromJson(json);

  Map<String, dynamic> toJson() => _$WalletBalanceToJson(this);
}

@JsonSerializable()
class DepositRequest {
  final double amount;
  final String receiptImageUrl;

  DepositRequest({
    required this.amount,
    required this.receiptImageUrl,
  });

  factory DepositRequest.fromJson(Map<String, dynamic> json) =>
      _$DepositRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DepositRequestToJson(this);
}

@JsonSerializable()
class DepositResponse {
  final String depositId;
  final String status;

  DepositResponse({
    required this.depositId,
    required this.status,
  });

  factory DepositResponse.fromJson(Map<String, dynamic> json) =>
      _$DepositResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DepositResponseToJson(this);
}

@JsonSerializable()
class TransferRequest {
  final String recipientId;
  final double amount;
  final String currency;
  final String pin;

  TransferRequest({
    required this.recipientId,
    required this.amount,
    required this.currency,
    required this.pin,
  });

  factory TransferRequest.fromJson(Map<String, dynamic> json) =>
      _$TransferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TransferRequestToJson(this);
}

@JsonSerializable()
class TransferResponse {
  final String transactionId;
  final String status;

  TransferResponse({
    required this.transactionId,
    required this.status,
  });

  factory TransferResponse.fromJson(Map<String, dynamic> json) =>
      _$TransferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransferResponseToJson(this);
}

@JsonSerializable()
class Transaction {
  final String id;
  final String type;
  final double amount;
  final String currency;
  final String status;
  final DateTime createdAt;
  final String? description;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.currency,
    required this.status,
    required this.createdAt,
    this.description,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
