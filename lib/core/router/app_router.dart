import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/welcome_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/register_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/create_password_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/create_pin_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/login_page.dart';
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
import 'package:case_digital_wallet/features/settings/presentation/pages/settings_page.dart';
import 'package:case_digital_wallet/features/security/presentation/pages/security_settings_page.dart';
import 'package:case_digital_wallet/features/notifications/presentation/pages/notifications_page.dart';
import 'package:case_digital_wallet/features/activity_log/presentation/pages/activity_log_page.dart';
import 'package:case_digital_wallet/features/support/presentation/pages/support_page.dart';
import 'package:case_digital_wallet/features/faq/presentation/pages/faq_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/onboarding_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/mnemonic_display_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/mnemonic_confirm_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/registration_success_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/splash_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/google_registration_flow_page.dart';
import 'package:case_digital_wallet/features/auth/presentation/pages/google_login_flow_page.dart';
import 'package:case_digital_wallet/core/di/injection_container.dart';
import 'package:case_digital_wallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final authBloc = sl<AuthBloc>();
      final bool isAuthenticated = authBloc.state is AuthAuthenticated;
      final bool isSplash = state.matchedLocation == '/splash';
      final bool isAuthRoute = state.matchedLocation == '/welcome' ||
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register' ||
          state.matchedLocation == '/google-registration-flow' ||
          state.matchedLocation == '/google-login-flow' ||
          state.matchedLocation == '/onboarding' ||
          state.matchedLocation == '/mnemonic-display' ||
          state.matchedLocation == '/mnemonic-confirm' ||
          state.matchedLocation == '/registration-success';

      if (isSplash) {
        return null;
      }

      if (isAuthenticated && isAuthRoute) {
        return '/home';
      } else if (!isAuthenticated && !isAuthRoute) {
        return '/welcome';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      // Auth routes
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/google-registration-flow',
        builder: (context, state) => const GoogleRegistrationFlowPage(),
      ),
      GoRoute(
        path: '/google-login-flow',
        builder: (context, state) => const GoogleLoginFlowPage(),
      ),

      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/mnemonic-display',
        builder: (context, state) => const MnemonicDisplayPage(),
      ),
      GoRoute(
        path: '/mnemonic-confirm',
        builder: (context, state) {
          final mnemonicWords = state.extra as List<String>?;
          if (mnemonicWords == null) {
            return const Text(
                'Error: Mnemonic words not provided.'); // Handle error or redirect
          }
          return MnemonicConfirmPage(mnemonicWords: mnemonicWords);
        },
      ),
      GoRoute(
        path: '/registration-success',
        builder: (context, state) => const RegistrationSuccessPage(),
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
        builder: (context, state) => const LoginPage(),
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
        routes: [
          // Rutas anidadas para la navegación dentro de MainPage
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: 'activity',
            builder: (context, state) => const TransactionHistoryPage(),
          ),
        ],
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
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/security',
        builder: (context, state) => const SecuritySettingsPage(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: '/activity-log',
        builder: (context, state) => const ActivityLogPage(),
      ),
      GoRoute(
        path: '/support',
        builder: (context, state) => const SupportPage(),
      ),
      GoRoute(
        path: '/faq',
        builder: (context, state) => const FAQPage(),
      ),
    ],
  );
}
