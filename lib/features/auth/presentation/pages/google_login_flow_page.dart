import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/core/di/injection_container.dart';
import 'package:case_digital_wallet/features/auth/presentation/bloc/auth_bloc.dart';

class GoogleLoginFlowPage extends StatelessWidget {
  const GoogleLoginFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>()..add(GoogleLoginRequested()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // After successful Google login, navigate to home
            context.go('/home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      'Error al iniciar sesión con Google: ${state.message}')),
            );
            context.go('/welcome'); // Go back to welcome page on error
          } else if (state is AuthLoading) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Iniciando sesión con Google...')));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Iniciando Sesión con Google'),
          ),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Por favor espera...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
