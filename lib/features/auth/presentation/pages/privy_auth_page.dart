import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';
import 'package:case_digital_wallet/features/wallet/data/services/privy_service_impl.dart';
import 'package:case_digital_wallet/core/di/injection_container.dart' as di;

class PrivyAuthPage extends StatefulWidget {
  const PrivyAuthPage({super.key});

  @override
  State<PrivyAuthPage> createState() => _PrivyAuthPageState();
}

class _PrivyAuthPageState extends State<PrivyAuthPage> {
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
        title: const Text('Crear Cuenta'),
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
                      'Crear tu Billetera Digital',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Elige cómo quieres registrarte',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Sección: Registro con credenciales
              _buildSectionTitle('Registro con credenciales'),
              const SizedBox(height: 16),

              // Opción: Teléfono
              _buildAuthOption(
                icon: Icons.phone,
                title: 'Continuar con Teléfono',
                subtitle: 'Usa tu número de teléfono',
                onTap: () => _showPhoneDialog(),
                color: Colors.green,
              ),

              const SizedBox(height: 12),

              // Opción: Email
              _buildAuthOption(
                icon: Icons.email,
                title: 'Continuar con Email',
                subtitle: 'Usa tu dirección de correo',
                onTap: () => _showEmailDialog(),
                color: Colors.blue,
              ),

              const SizedBox(height: 32),

              // Sección: Redes sociales
              _buildSectionTitle('Redes sociales'),
              const SizedBox(height: 16),

              // Opción: Google
              _buildAuthOption(
                icon: Icons.g_mobiledata,
                title: 'Continuar con Google',
                subtitle: 'Acceso rápido con tu cuenta Google',
                onTap: () => _handleGoogleAuth(),
                color: Colors.red,
              ),

              const SizedBox(height: 32),

              // Sección: Wallets Web3
              _buildSectionTitle('Wallets Web3'),
              const SizedBox(height: 16),

              // Opción: MetaMask
              _buildAuthOption(
                icon: Icons.account_balance_wallet,
                title: 'MetaMask',
                subtitle: 'Conectar con MetaMask',
                onTap: () => _handleWalletAuth('MetaMask'),
                color: Colors.orange,
              ),

              const SizedBox(height: 12),

              // Opción: Core Wallet
              _buildAuthOption(
                icon: Icons.wallet,
                title: 'Core Wallet',
                subtitle: 'Conectar con Core Wallet',
                onTap: () => _handleWalletAuth('Core Wallet'),
                color: Colors.purple,
              ),

              const SizedBox(height: 12),

              // Opción: WalletConnect
              _buildAuthOption(
                icon: Icons.link,
                title: 'WalletConnect',
                subtitle: 'Conectar cualquier wallet compatible',
                onTap: () => _handleWalletAuth('WalletConnect'),
                color: Colors.indigo,
              ),

              const SizedBox(height: 12),

              // Opción: Coinbase Wallet
              _buildAuthOption(
                icon: Icons.currency_bitcoin,
                title: 'Coinbase Wallet',
                subtitle: 'Conectar con Coinbase Wallet',
                onTap: () => _handleWalletAuth('Coinbase Wallet'),
                color: Colors.blueAccent,
              ),

              const SizedBox(height: 32),

              // Términos y condiciones
              const Text(
                'Al continuar, aceptas nuestros Términos y Condiciones y Política de Privacidad',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
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
        title: const Text('Registro con Teléfono'),
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
              _handlePhoneAuth(_phoneController.text);
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
        title: const Text('Registro con Email'),
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
              _handleEmailAuth(_emailController.text);
            },
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePhoneAuth(String phone) async {
    await _authenticateWith('Teléfono: $phone');
  }

  Future<void> _handleEmailAuth(String email) async {
    await _authenticateWith('Email: $email');
  }

  Future<void> _handleGoogleAuth() async {
    await _authenticateWith('Google');
  }

  Future<void> _handleWalletAuth(String walletName) async {
    await _authenticateWith('Wallet: $walletName');
  }

  Future<void> _authenticateWith(String method) async {
    setState(() => _isLoading = true);

    try {
      final privyService = di.sl<PrivyServiceImpl>();

      // Mostrar proceso de verificación mockup
      _showVerificationProcess(method);

      // Simular autenticación
      await Future.delayed(const Duration(seconds: 3));

      if (method.startsWith('Wallet:') || method == 'Google') {
        await privyService.connectWallet();
      }

      if (!mounted) return;

      // Ir a la pantalla principal
      context.go('/home');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Cuenta creada exitosamente con $method!'),
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

  void _showVerificationProcess(String method) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text('Verificando con $method...'),
            const SizedBox(height: 8),
            const Text(
              'Por favor espera un momento',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );

    // Cerrar el diálogo después de 2.5 segundos
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }
}
