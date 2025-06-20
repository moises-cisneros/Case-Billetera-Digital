import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:case_digital_wallet/features/auth/domain/entities/user_entity.dart';
import 'package:case_digital_wallet/features/auth/domain/usecases/login_usecase.dart';
import 'package:case_digital_wallet/features/auth/domain/usecases/register_usecase.dart';
import 'package:case_digital_wallet/features/auth/domain/repositories/auth_repository.dart';
import 'package:case_digital_wallet/features/auth/data/services/google_auth_service.dart';
import 'package:case_digital_wallet/features/auth/domain/usecases/google_sign_in_usecase.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthenticationStatus extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String phoneNumber;
  final String password;

  const LoginRequested({
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object> get props => [phoneNumber, password];
}

class RegisterRequested extends AuthEvent {
  final String phoneNumber;
  final String password;
  final String pin;

  const RegisterRequested({
    required this.phoneNumber,
    required this.password,
    required this.pin,
  });

  @override
  List<Object> get props => [phoneNumber, password, pin];
}

class SignInWithGoogleEvent extends AuthEvent {
  final String googleIdToken;
  const SignInWithGoogleEvent(this.googleIdToken);
  @override
  List<Object> get props => [googleIdToken];
}

class LogoutRequested extends AuthEvent {}

class GenerateWalletRequested extends AuthEvent {}

class RegisterBlockchainRequested extends AuthEvent {
  final String userId;
  final String walletAddress;

  const RegisterBlockchainRequested({
    required this.userId,
    required this.walletAddress,
  });

  @override
  List<Object> get props => [userId, walletAddress];
}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity user;
  final String userStatus;

  const AuthAuthenticated(this.user, {required this.userStatus});

  @override
  List<Object> get props => [user, userStatus];
}

class WalletGenerated extends AuthState {
  final List<String> mnemonicWords;

  const WalletGenerated(this.mnemonicWords);

  @override
  List<Object> get props => [mnemonicWords];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final AuthRepository authRepository;
  final GoogleAuthService googleAuthService;
  final GoogleSignInUseCase googleSignInUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.authRepository,
    required this.googleAuthService,
    required this.googleSignInUseCase,
  }) : super(AuthInitial()) {
    on<CheckAuthenticationStatus>(_onCheckAuthenticationStatus);
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<GenerateWalletRequested>(_onGenerateWalletRequested);
    on<RegisterBlockchainRequested>(_onRegisterBlockchainRequested);
    on<LogoutRequested>(_onLogoutRequested);

    // Verificar estado inicial
    add(CheckAuthenticationStatus());
  }

  Future<void> _onCheckAuthenticationStatus(
    CheckAuthenticationStatus event,
    Emitter<AuthState> emit,
  ) async {
    if (await authRepository.isLoggedIn()) {
      final user = await authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user, userStatus: user.status));
      } else {
        await authRepository.logout();
        emit(AuthUnauthenticated());
      }
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await loginUseCase(event.phoneNumber, event.password);
      emit(AuthAuthenticated(user, userStatus: user.status));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await registerUseCase.completeRegistration(
        event.phoneNumber,
        event.password,
        event.pin,
      );
      emit(AuthAuthenticated(user, userStatus: user.status));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await googleSignInUseCase(event.googleIdToken);
      emit(AuthAuthenticated(user, userStatus: user.status));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onGenerateWalletRequested(
    GenerateWalletRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final mnemonic = await authRepository.generateWalletMnemonic();
      emit(WalletGenerated(mnemonic));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegisterBlockchainRequested(
    RegisterBlockchainRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.registerBlockchain(
          event.userId, event.walletAddress);
      emit(AuthAuthenticated(user, userStatus: user.status));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.logout();
    emit(AuthUnauthenticated());
  }
}
