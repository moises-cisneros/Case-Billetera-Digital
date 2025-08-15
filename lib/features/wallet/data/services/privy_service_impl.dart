import 'package:case_digital_wallet/features/wallet/domain/repositories/privy_service.dart';

class PrivyServiceImpl implements PrivyService {
  bool _isConnected = false;
  String? _walletAddress;

  @override
  Future<bool> connectWallet() async {
    // Simular conexión de wallet
    await Future.delayed(const Duration(seconds: 2));

    _isConnected = true;
    _walletAddress = '0x742d35Cc6639C0532fEb86D4AB7B45c3D6B2e326';

    return true;
  }

  @override
  Future<void> disconnectWallet() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isConnected = false;
    _walletAddress = null;
  }

  @override
  Future<String?> getWalletAddress() async {
    return _walletAddress;
  }

  @override
  Future<bool> isWalletConnected() async {
    return _isConnected;
  }

  @override
  Future<bool> authenticateWithGoogle() async {
    // Simular autenticación con Google
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
