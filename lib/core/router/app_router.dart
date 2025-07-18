import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/welcome_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/register_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/login_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/create_password_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/create_pin_page.dart';
import 'package:case_digital_wallet/features/home/presentation/pages/main_page.dart';
import 'package:case_digital_wallet/features/wallet/presentation/pages/send_money_page.dart';
import 'package:case_digital_wallet/features/wallet/presentation/pages/receive_money_page.dart';
import 'package:case_digital_wallet/features/wallet/presentation/pages/deposit_page.dart';
import 'package:case_digital_wallet/features/wallet/presentation/pages/withdraw_page.dart';
import 'package:case_digital_wallet/features/wallet/presentation/pages/transaction_history_page.dart';
import 'package:case_digital_wallet/features/crypto/presentation/pages/crypto_market_page.dart';
import 'package:case_digital_wallet/features/crypto/presentation/pages/resguardar_page.dart';
import 'package:case_digital_wallet/features/maps/presentation/pages/maps_page.dart';
import 'package:case_digital_wallet/features/qr/presentation/pages/my_qr_page.dart';
import 'package:case_digital_wallet/features/qr/presentation/pages/qr_scanner_page.dart';
import 'package:case_digital_wallet/features/profile/presentation/pages/profile_page.dart';
import 'package:case_digital_wallet/features/kyc/presentation/pages/kyc_start_page.dart';
import 'package:case_digital_wallet/features/kyc/presentation/pages/kyc_document_page.dart';
import 'package:case_digital_wallet/features/kyc/presentation/pages/kyc_selfie_page.dart';
import 'package:case_digital_wallet/features/activities/presentation/pages/activity_page.dart';
import 'package:case_digital_wallet/features/p2p/presentation/pages/p2p_management_page.dart';
import 'package:case_digital_wallet/features/commerce/presentation/pages/commerce_management_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:case_digital_wallet/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:case_digital_wallet/features/crypto/presentation/bloc/crypto_bloc.dart';
import 'package:case_digital_wallet/features/maps/presentation/bloc/maps_bloc.dart';
import 'package:case_digital_wallet/features/qr/presentation/bloc/qr_bloc.dart';
import 'package:case_digital_wallet/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:case_digital_wallet/features/activities/presentation/bloc/activity_bloc.dart';
import 'package:case_digital_wallet/core/di/injection_container.dart' as di;

final GoRouter appRouter = GoRouter(
  initialLocation: '/welcome',
  routes: [
    // Auth routes
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/otp-verification',
      builder: (context, state) {
        final phoneNumber = state.extra as String? ?? '';
        return OtpVerificationPage(phoneNumber: phoneNumber);
      },
    ),
    GoRoute(
      path: '/create-password',
      builder: (context, state) => const CreatePasswordPage(),
    ),
    GoRoute(
      path: '/create-pin',
      builder: (context, state) => const CreatePinPage(),
    ),
    
    // Main app routes
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainPage(),
    ),
    
    // Wallet routes
    GoRoute(
      path: '/send-money',
      builder: (context, state) => BlocProvider(
        create: (context) => di.sl<WalletBloc>(),
        child: const SendMoneyPage(),
      ),
    ),
    GoRoute(
      path: '/receive-money',
      builder: (context, state) => BlocProvider(
        create: (context) => di.sl<WalletBloc>(),
        child: const ReceiveMoneyPage(),
      ),
    ),
    GoRoute(
      path: '/deposit',
      builder: (context, state) => BlocProvider(
        create: (context) => di.sl<WalletBloc>(),
        child: const DepositPage(),
      ),
    ),
    GoRoute(
      path: '/withdraw',
      builder: (context, state) => BlocProvider(
        create: (context) => di.sl<WalletBloc>(),
        child: const WithdrawPage(),
      ),
    ),
    GoRoute(
      path: '/transaction-history',
      builder: (context, state) => BlocProvider(
        create: (context) => di.sl<WalletBloc>(),
        child: const TransactionHistoryPage(),
      ),
    ),
    
    // Crypto routes
    GoRoute(
      path: '/crypto-market',
      builder: (context, state) => BlocProvider(
        create: (context) => di.sl<CryptoBloc>(),
        child: const CryptoMarketPage(),
      ),
    ),
    GoRoute(
      path: '/resguardar',
      builder: (context, state) => BlocProvider(
        create: (context) => di.sl<CryptoBloc>(),
        child: const ResguardarPage(),
      ),
    ),
    
    // Maps routes
    GoRoute(
      path: '/maps',
      builder: (context, state) => BlocProvider(
        create: (context) => di.sl<MapsBloc>(),
        child: const MapsPage(),
      ),
    ),
    
    // QR routes
    GoRoute(
      path: '/my-qr',
      builder: (context, state) => BlocProvider(
        create: (context) => di.sl<QRBloc>(),
        child: const MyQRPage(),
      ),
    ),
    GoRoute(
      path: '/qr-scanner',
      builder: (context, state) => BlocProvider(
        create: (context) => di.sl<QRBloc>(),
        child: const QRScannerPage(),
      ),
    ),
    
    // Profile routes
    GoRoute(
      path: '/profile',
      builder: (context, state) => BlocProvider(
        create: (context) => di.sl<ProfileBloc>(),
        child: const ProfilePage(),
      ),
    ),
    
    // KYC routes
    GoRoute(
      path: '/kyc-start',
      builder: (context, state) => const KycStartPage(),
    ),
    GoRoute(
      path: '/kyc-document',
      builder: (context, state) => const KycDocumentPage(),
    ),
    GoRoute(
      path: '/kyc-selfie',
      builder: (context, state) => const KycSelfiePage(),
    ),
    
    // Activities routes
    GoRoute(
      path: '/activities',
      builder: (context, state) => BlocProvider(
        create: (context) => di.sl<ActivityBloc>(),
        child: const ActivityPage(),
      ),
    ),
    
    // P2P Management routes
    GoRoute(
      path: '/p2p-management',
      builder: (context, state) => const P2PManagementPage(),
    ),
    
    // Commerce Management routes
    GoRoute(
      path: '/commerce-management',
      builder: (context, state) => const CommerceManagementPage(),
    ),
  ],
);
