import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/core/di/injection_container.dart';
import 'package:case_digital_wallet/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:case_digital_wallet/features/auth/data/services/google_auth_service.dart';
import 'dart:async'; // Import for Timer

class GoogleLoginFlowPage extends StatefulWidget {
  const GoogleLoginFlowPage({super.key});

  @override
  State<GoogleLoginFlowPage> createState() => _GoogleLoginFlowPageState();
}

class _GoogleLoginFlowPageState extends State<GoogleLoginFlowPage> {
  Timer? _timer;
  String _errorMessage = '';
  bool _showRetry = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startGoogleSignIn();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startGoogleSignIn() async {
    if (!mounted) return; // Ensure widget is still mounted

    setState(() {
      _errorMessage = '';
      _showRetry = false;
    });

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar(); // Hide any previous snackbars
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Iniciando Google Sign-In...'))); // Show initial loading

    try {
      final GoogleAuthService googleAuthService = sl<GoogleAuthService>();
      final idToken = await googleAuthService.signInWithGoogle();

      if (!mounted) return;

      if (idToken != null) {
        print('DEBUG: Google Sign-In successful, ID Token received.');
        BlocProvider.of<AuthBloc>(context).add(SignInWithGoogleEvent(idToken));
      } else {
        print('DEBUG: Google Sign-In cancelled or failed (idToken is null).');
        _handleUIError('Google Sign-In cancelado o fallido.');
      }
    } catch (e) {
      if (!mounted) return;
      print('DEBUG: Error during Google Sign-In: $e');
      _handleUIError('Error durante Google Sign-In: ${e.toString()}');
    }
  }

  void _handleUIError(String message) {
    setState(() {
      _errorMessage = message;
      _showRetry = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            _timer?.cancel();
            ScaffoldMessenger.of(context)
                .hideCurrentSnackBar(); // Hide loading snackbar
            context.go('/home'); // Always navigate to home for login
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .hideCurrentSnackBar(); // Hide loading snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      'Error al iniciar sesión con Google: ${state.message}')),
            );
            _handleUIError(state.message); // Update local UI state for retry
          } else if (state is AuthLoading) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Iniciando sesión con Google...')));
            setState(() {
              _errorMessage = '';
              _showRetry = false;
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Iniciando Sesión con Google'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (context.watch<AuthBloc>().state is AuthLoading)
                  const CircularProgressIndicator()
                else if (_showRetry)
                  Column(
                    children: [
                      Text(_errorMessage, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _startGoogleSignIn,
                        child: const Text('Reintentar'),
                      ),
                    ],
                  )
                else
                  const Text(
                      'Por favor espera...'), // Initial state or after a successful attempt
              ],
            ),
          ),
        ),
      ),
    );
  }
}
