import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';
import 'package:case_digital_wallet/features/wallet/data/services/privy_service_impl.dart';
import 'package:case_digital_wallet/core/di/injection_container.dart' as di;

class PrivyLoginPage extends StatefulWidget {
  const PrivyLoginPage({super.key});

  @override
  State<PrivyLoginPage> createState() => _PrivyLoginPageState();
}

class _PrivyLoginPageState extends State<PrivyLoginPage> {
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),

              // Logo y titulo
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primaryColor,
                            AppTheme.primaryColor.withValues(alpha: 0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Bienvenido de vuelta',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Accede a tu billetera digital',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Opciones de login rápido
              _buildSectionTitle('Acceso rápido'),
              const SizedBox(height: 16),

              // Opción: Google
              _buildAuthOption(
                icon: Icons.g_mobiledata,
                title: 'Continuar con Google',
                subtitle: 'Acceso rápido con tu cuenta Google',
                onTap: () => _handleGoogleLogin(),
                color: Colors.red,
              ),

              const SizedBox(height: 12),

              // Opción: MetaMask (para usuarios Web3)
              _buildAuthOption(
                icon: Icons.account_balance_wallet,
                title: 'Conectar MetaMask',
                subtitle: 'Acceder con tu wallet MetaMask',
                onTap: () => _handleWalletLogin('MetaMask'),
                color: Colors.orange,
              ),

              const SizedBox(height: 32),

              // Sección: Login tradicional
              _buildSectionTitle('Login tradicional'),
              const SizedBox(height: 16),

              // Opción: Teléfono
              _buildAuthOption(
                icon: Icons.phone,
                title: 'Iniciar con Teléfono',
                subtitle: 'Usa tu número registrado',
                onTap: () => _showPhoneDialog(),
                color: Colors.green,
              ),

              const SizedBox(height: 12),

              // Opción: Email
              _buildAuthOption(
                icon: Icons.email,
                title: 'Iniciar con Email',
                subtitle: 'Usa tu correo registrado',
                onTap: () => _showEmailDialog(),
                color: Colors.blue,
              ),

              const SizedBox(height: 32),

              // Link para crear cuenta
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿No tienes cuenta? '),
                  TextButton(
                    onPressed: () => context.go('/privy-auth'),
                    child: const Text('Crear cuenta'),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildAuthOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: _isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              if (_isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPhoneDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Iniciar con Teléfono'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Número de teléfono',
                prefixText: '+591 ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            const Text(
              'Se enviará un código de verificación a tu teléfono',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _handlePhoneLogin(_phoneController.text);
            },
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  void _showEmailDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Iniciar con Email'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            const Text(
              'Se enviará un enlace de acceso a tu correo',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _handleEmailLogin(_emailController.text);
            },
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePhoneLogin(String phone) async {
    await _loginWith('Teléfono: $phone');
  }

  Future<void> _handleEmailLogin(String email) async {
    await _loginWith('Email: $email');
  }

  Future<void> _handleGoogleLogin() async {
    await _loginWith('Google');
  }

  Future<void> _handleWalletLogin(String walletName) async {
    await _loginWith('Wallet: $walletName');
  }

  Future<void> _loginWith(String method) async {
    setState(() => _isLoading = true);

    try {
      final privyService = di.sl<PrivyServiceImpl>();

      // Mostrar proceso de autenticación mockup
      _showAuthProcess(method);

      // Simular autenticación
      await Future.delayed(const Duration(seconds: 2));

      if (method.startsWith('Wallet:') || method == 'Google') {
        await privyService.connectWallet();
      }

      if (!mounted) return;

      // Ir a la pantalla principal
      context.go('/home');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Bienvenido! Sesión iniciada con $method'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showAuthProcess(String method) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text('Autenticando con $method...'),
            const SizedBox(height: 8),
            const Text(
              'Verificando credenciales',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );

    // Cerrar el diálogo después de 1.5 segundos
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }
}
