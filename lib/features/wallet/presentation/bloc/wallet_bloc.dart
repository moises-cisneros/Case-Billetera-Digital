import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:case_digital_wallet/features/wallet/data/models/wallet_models.dart';
import 'package:case_digital_wallet/features/wallet/domain/usecases/get_balance_usecase.dart';

// Events
abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class GetBalanceRequested extends WalletEvent {}

// States
abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final WalletBalance balance;

  const WalletLoaded(this.balance);

  @override
  List<Object> get props => [balance];
}

class WalletError extends WalletState {
  final String message;

  const WalletError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetBalanceUseCase getBalanceUseCase;

  WalletBloc({
    required this.getBalanceUseCase,
  }) : super(WalletInitial()) {
    on<GetBalanceRequested>(_onGetBalanceRequested);
  }

  Future<void> _onGetBalanceRequested(
    GetBalanceRequested event,
    Emitter<WalletState> emit,
  ) async {
    emit(WalletLoading());
    
    try {
      final balance = await getBalanceUseCase();
      emit(WalletLoaded(balance));
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }
}