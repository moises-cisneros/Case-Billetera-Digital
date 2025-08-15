import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/welcome_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/register_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/privy_auth_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/privy_login_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/create_password_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/create_pin_page.dart';
import 'package:case_digital_wallet/features/kyc/presentation/pages/kyc_start_page.dart';
import 'package:case_digital_wallet/features/kyc/presentation/pages/kyc_document_page.dart';
import 'package:case_digital_wallet/features/kyc/presentation/pages/kyc_selfie_page.dart';
import 'package:case_digital_wallet/features/home/presentation/pages/main_page.dart';
import 'package:case_digital_wallet/features/wallet/presentation/pages/deposit_page.dart';
import 'package:case_digital_wallet/features/wallet/presentation/pages/withdraw_page.dart';
import 'package:case_digital_wallet/features/wallet/presentation/pages/send_money_page.dart';
import 'package:case_digital_wallet/features/wallet/presentation/pages/receive_money_page.dart';
import 'package:case_digital_wallet/features/wallet/presentation/pages/transaction_history_page.dart';
import 'package:case_digital_wallet/features/crypto/presentation/pages/resguardar_page.dart';
import 'package:case_digital_wallet/features/profile/presentation/pages/profile_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
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
        path: '/privy-auth',
        builder: (context, state) => const PrivyAuthPage(),
      ),
      GoRoute(
        path: '/otp-verification',
        builder: (context, state) {
          final phoneNumber = state.extra as String;
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
      GoRoute(
        path: '/login',
        builder: (context, state) => const PrivyLoginPage(),
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

      // Main app routes
      GoRoute(
        path: '/home',
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: '/deposit',
        builder: (context, state) => const DepositPage(),
      ),
      GoRoute(
        path: '/withdraw',
        builder: (context, state) => const WithdrawPage(),
      ),
      GoRoute(
        path: '/send-money',
        builder: (context, state) => const SendMoneyPage(),
      ),
      GoRoute(
        path: '/receive-money',
        builder: (context, state) => const ReceiveMoneyPage(),
      ),
      GoRoute(
        path: '/transaction-history',
        builder: (context, state) => const TransactionHistoryPage(),
      ),
      GoRoute(
        path: '/resguardar',
        builder: (context, state) => const ResguardarPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
}
