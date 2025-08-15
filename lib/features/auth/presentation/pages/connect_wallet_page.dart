import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:case_digital_wallet/core/theme/app_theme.dart';
import 'package:case_digital_wallet/core/di/injection_container.dart' as di;
import 'package:case_digital_wallet/features/wallet/data/services/privy_service_impl.dart';

class ConnectWalletPage extends StatefulWidget {
  const ConnectWalletPage({super.key});

  @override
  State<ConnectWalletPage> createState() => _ConnectWalletPageState();
}

class _ConnectWalletPageState extends State<ConnectWalletPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conectar Wallet'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 32),

              // Logo Web3
              Container(
                width: 100,
                height: 100,
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
                  size: 50,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 24),

              // Title
              const Text(
                'Conecta tu Wallet',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Subtitle
              const Text(
                'Elige tu método de autenticación Web3 preferido. Privy te permite conectar con Google o con tu wallet existente.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Wallet options
              Column(
                children: [
                  // Google OAuth (Privy)
                  _buildWalletOption(
                    icon: Icons.g_mobiledata,
                    title: 'Continuar con Google',
                    subtitle: 'Crear Smart Account via Privy',
                    color: Colors.red,
                    onTap: () => _handleGoogleAuth(),
                  ),

                  const SizedBox(height: 16),

                  // MetaMask
                  _buildWalletOption(
                    icon: Icons.account_balance_wallet,
                    title: 'Conectar MetaMask',
                    subtitle: 'Usa tu wallet existente',
                    color: Colors.orange,
                    onTap: () => _handleMetaMaskConnect(),
                  ),

                  const SizedBox(height: 16),

                  // WalletConnect
                  _buildWalletOption(
                    icon: Icons.qr_code_scanner,
                    title: 'WalletConnect',
                    subtitle: 'Escanear QR desde otra wallet',
                    color: Colors.blue,
                    onTap: () => _handleWalletConnect(),
                  ),

                  const SizedBox(height: 16),

                  // Coinbase Wallet
                  _buildWalletOption(
                    icon: Icons.currency_bitcoin,
                    title: 'Coinbase Wallet',
                    subtitle: 'Conectar con Coinbase',
                    color: Colors.indigo,
                    onTap: () => _handleCoinbaseConnect(),
                  ),

                  const SizedBox(height: 32),

                  // Alternative: Phone registration
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'o crea cuenta tradicional',
                          style: TextStyle(color: AppTheme.textTertiary),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Traditional phone registration
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => context.go('/register'),
                      icon: const Icon(Icons.phone, size: 20),
                      label: const Text('Registrarse con teléfono'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: AppTheme.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWalletOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
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
          padding: const EdgeInsets.all(16),
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
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textTertiary,
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
                  size: 16,
                  color: AppTheme.textTertiary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleGoogleAuth() async {
    setState(() => _isLoading = true);

    try {
      final privyService = di.sl<PrivyServiceImpl>();

      // Simular proceso de autenticación con Google via Privy
      await Future.delayed(const Duration(seconds: 2));

      final success = await privyService.authenticateWithGoogle();

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Smart Account creada con Google'),
            backgroundColor: Colors.green,
          ),
        );

        // Navegar al dashboard
        context.go('/home');
      } else {
        throw Exception('Error en autenticación con Google');
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleMetaMaskConnect() async {
    setState(() => _isLoading = true);

    try {
      final privyService = di.sl<PrivyServiceImpl>();

      // Simular conexión con MetaMask
      await Future.delayed(const Duration(seconds: 2));

      final success = await privyService.connectWallet();

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ MetaMask conectada exitosamente'),
            backgroundColor: Colors.green,
          ),
        );

        context.go('/home');
      } else {
        throw Exception('Error conectando MetaMask');
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleWalletConnect() async {
    setState(() => _isLoading = true);

    try {
      final privyService = di.sl<PrivyServiceImpl>();

      // Simular WalletConnect
      await Future.delayed(const Duration(seconds: 3));

      final success = await privyService.connectWallet();

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Wallet conectada via WalletConnect'),
            backgroundColor: Colors.green,
          ),
        );

        context.go('/home');
      } else {
        throw Exception('Error con WalletConnect');
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleCoinbaseConnect() async {
    setState(() => _isLoading = true);

    try {
      final privyService = di.sl<PrivyServiceImpl>();

      // Simular Coinbase Wallet
      await Future.delayed(const Duration(seconds: 2));

      final success = await privyService.connectWallet();

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Coinbase Wallet conectada'),
            backgroundColor: Colors.green,
          ),
        );

        context.go('/home');
      } else {
        throw Exception('Error conectando Coinbase Wallet');
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
