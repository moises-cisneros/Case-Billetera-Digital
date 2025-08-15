abstract class PrivyService {
  Future<bool> connectWallet();
  Future<void> disconnectWallet();
  Future<String?> getWalletAddress();
  Future<bool> isWalletConnected();
  Future<bool> authenticateWithGoogle();
}
