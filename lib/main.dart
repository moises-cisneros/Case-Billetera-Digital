import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:case_digital_wallet/core/router/app_router.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';
import 'package:case_digital_wallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:case_digital_wallet/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:case_digital_wallet/core/di/injection_container.dart' as di;
import 'package:case_digital_wallet/core/config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with default options
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Error initializing Firebase: $e');
    // Continuar la ejecución aunque Firebase falle
  }

  // Initialize dependencies
  await di.init();
  runApp(const CaseApp());
}

class CaseApp extends StatelessWidget {
  const CaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<WalletBloc>()),
      ],
      child: MaterialApp.router(
        title: 'CASE - Billetera Digital',
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
