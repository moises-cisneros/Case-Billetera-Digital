import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:case_digital_wallet/features/crypto/domain/entities/crypto_entity.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/get_crypto_prices_usecase.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/get_user_crypto_balances_usecase.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/get_crypto_transactions_usecase.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/buy_crypto_usecase.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/sell_crypto_usecase.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/send_crypto_usecase.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/convert_to_crypto_usecase.dart';
import 'package:case_digital_wallet/features/crypto/domain/usecases/convert_from_crypto_usecase.dart';

// Events
abstract class CryptoEvent extends Equatable {
  const CryptoEvent();

  @override
  List<Object?> get props => [];
}

class LoadCryptoPrices extends CryptoEvent {}

class LoadUserCryptoBalances extends CryptoEvent {}

class LoadCryptoTransactions extends CryptoEvent {}

class BuyCrypto extends CryptoEvent {
  final String cryptoId;
  final double amount;
  final double price;

  const BuyCrypto({
    required this.cryptoId,
    required this.amount,
    required this.price,
  });

  @override
  List<Object?> get props => [cryptoId, amount, price];
}

class SellCrypto extends CryptoEvent {
  final String cryptoId;
  final double amount;
  final double price;

  const SellCrypto({
    required this.cryptoId,
    required this.amount,
    required this.price,
  });

  @override
  List<Object?> get props => [cryptoId, amount, price];
}

class SendCrypto extends CryptoEvent {
  final String cryptoId;
  final double amount;
  final String toAddress;

  const SendCrypto({
    required this.cryptoId,
    required this.amount,
    required this.toAddress,
  });

  @override
  List<Object?> get props => [cryptoId, amount, toAddress];
}

class ConvertToCrypto extends CryptoEvent {
  final double bsAmount;
  final String cryptoId;

  const ConvertToCrypto({
    required this.bsAmount,
    required this.cryptoId,
  });

  @override
  List<Object?> get props => [bsAmount, cryptoId];
}

class ConvertFromCrypto extends CryptoEvent {
  final double cryptoAmount;
  final String cryptoId;

  const ConvertFromCrypto({
    required this.cryptoAmount,
    required this.cryptoId,
  });

  @override
  List<Object?> get props => [cryptoAmount, cryptoId];
}

// States
abstract class CryptoState extends Equatable {
  const CryptoState();

  @override
  List<Object?> get props => [];
}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoPricesLoaded extends CryptoState {
  final List<CryptoEntity> cryptos;

  const CryptoPricesLoaded(this.cryptos);

  @override
  List<Object?> get props => [cryptos];
}

class CryptoBalancesLoaded extends CryptoState {
  final List<CryptoBalanceEntity> balances;

  const CryptoBalancesLoaded(this.balances);

  @override
  List<Object?> get props => [balances];
}

class CryptoTransactionsLoaded extends CryptoState {
  final List<CryptoTransactionEntity> transactions;

  const CryptoTransactionsLoaded(this.transactions);

  @override
  List<Object?> get props => [transactions];
}

class CryptoOperationSuccess extends CryptoState {
  final String message;

  const CryptoOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CryptoError extends CryptoState {
  final String message;

  const CryptoError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final GetCryptoPricesUseCase getCryptoPrices;
  final GetUserCryptoBalancesUseCase getUserCryptoBalances;
  final GetCryptoTransactionsUseCase getCryptoTransactions;
  final BuyCryptoUseCase buyCrypto;
  final SellCryptoUseCase sellCrypto;
  final SendCryptoUseCase sendCrypto;
  final ConvertToCryptoUseCase convertToCrypto;
  final ConvertFromCryptoUseCase convertFromCrypto;

  CryptoBloc({
    required this.getCryptoPrices,
    required this.getUserCryptoBalances,
    required this.getCryptoTransactions,
    required this.buyCrypto,
    required this.sellCrypto,
    required this.sendCrypto,
    required this.convertToCrypto,
    required this.convertFromCrypto,
  }) : super(CryptoInitial()) {
    on<LoadCryptoPrices>(_onLoadCryptoPrices);
    on<LoadUserCryptoBalances>(_onLoadUserCryptoBalances);
    on<LoadCryptoTransactions>(_onLoadCryptoTransactions);
    on<BuyCrypto>(_onBuyCrypto);
    on<SellCrypto>(_onSellCrypto);
    on<SendCrypto>(_onSendCrypto);
    on<ConvertToCrypto>(_onConvertToCrypto);
    on<ConvertFromCrypto>(_onConvertFromCrypto);
  }

  Future<void> _onLoadCryptoPrices(
    LoadCryptoPrices event,
    Emitter<CryptoState> emit,
  ) async {
    emit(CryptoLoading());
    try {
      final cryptos = await getCryptoPrices();
      emit(CryptoPricesLoaded(cryptos));
    } catch (e) {
      emit(CryptoError(e.toString()));
    }
  }

  Future<void> _onLoadUserCryptoBalances(
    LoadUserCryptoBalances event,
    Emitter<CryptoState> emit,
  ) async {
    emit(CryptoLoading());
    try {
      final balances = await getUserCryptoBalances();
      emit(CryptoBalancesLoaded(balances));
    } catch (e) {
      emit(CryptoError(e.toString()));
    }
  }

  Future<void> _onLoadCryptoTransactions(
    LoadCryptoTransactions event,
    Emitter<CryptoState> emit,
  ) async {
    emit(CryptoLoading());
    try {
      final transactions = await getCryptoTransactions();
      emit(CryptoTransactionsLoaded(transactions));
    } catch (e) {
      emit(CryptoError(e.toString()));
    }
  }

  Future<void> _onBuyCrypto(
    BuyCrypto event,
    Emitter<CryptoState> emit,
  ) async {
    emit(CryptoLoading());
    try {
      final success = await buyCrypto(event.cryptoId, event.amount, event.price);
      if (success) {
        emit(const CryptoOperationSuccess('Compra realizada exitosamente'));
      } else {
        emit(const CryptoError('Error al realizar la compra'));
      }
    } catch (e) {
      emit(CryptoError(e.toString()));
    }
  }

  Future<void> _onSellCrypto(
    SellCrypto event,
    Emitter<CryptoState> emit,
  ) async {
    emit(CryptoLoading());
    try {
      final success = await sellCrypto(event.cryptoId, event.amount, event.price);
      if (success) {
        emit(const CryptoOperationSuccess('Venta realizada exitosamente'));
      } else {
        emit(const CryptoError('Error al realizar la venta'));
      }
    } catch (e) {
      emit(CryptoError(e.toString()));
    }
  }

  Future<void> _onSendCrypto(
    SendCrypto event,
    Emitter<CryptoState> emit,
  ) async {
    emit(CryptoLoading());
    try {
      final transactionHash = await sendCrypto(
        event.cryptoId,
        event.amount,
        event.toAddress,
      );
      if (transactionHash != null) {
        emit(CryptoOperationSuccess('Envío realizado. Hash: $transactionHash'));
      } else {
        emit(const CryptoError('Error al enviar crypto'));
      }
    } catch (e) {
      emit(CryptoError(e.toString()));
    }
  }

  Future<void> _onConvertToCrypto(
    ConvertToCrypto event,
    Emitter<CryptoState> emit,
  ) async {
    emit(CryptoLoading());
    try {
      final success = await convertToCrypto(event.bsAmount, event.cryptoId);
      if (success) {
        emit(const CryptoOperationSuccess('Conversión a crypto exitosa'));
      } else {
        emit(const CryptoError('Error en la conversión'));
      }
    } catch (e) {
      emit(CryptoError(e.toString()));
    }
  }

  Future<void> _onConvertFromCrypto(
    ConvertFromCrypto event,
    Emitter<CryptoState> emit,
  ) async {
    emit(CryptoLoading());
    try {
      final success = await convertFromCrypto(event.cryptoAmount, event.cryptoId);
      if (success) {
        emit(const CryptoOperationSuccess('Conversión desde crypto exitosa'));
      } else {
        emit(const CryptoError('Error en la conversión'));
      }
    } catch (e) {
      emit(CryptoError(e.toString()));
    }
  }
} 