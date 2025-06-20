import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class GoogleAuthService {
  Future<String?> signInWithGoogle();
  Future<void> signOutGoogle();
}

class GoogleAuthServiceImpl implements GoogleAuthService {
  final String clientId = dotenv.env['GOOGLE_CLIENT_ID'] ?? '';
  final String serverClientId = dotenv.env['GOOGLE_SERVER_CLIENT_ID'] ?? '';

  GoogleAuthServiceImpl() {
    print('DEBUG: Loaded GOOGLE_CLIENT_ID: $clientId');
    print('DEBUG: Loaded GOOGLE_SERVER_CLIENT_ID: $serverClientId');
  }

  late final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
    clientId: clientId,
    serverClientId: serverClientId,
  );

  @override
  Future<String?> signInWithGoogle() async {
    try {
      print('DEBUG: Attempting GoogleSignIn.signIn()...');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        print(
            'DEBUG: GoogleSignIn.signIn() returned null (user cancelled or failed silently).');
        return null;
      }
      print(
          'DEBUG: Google user obtained: ${googleUser.displayName} (${googleUser.email})');

      print('DEBUG: Attempting to get authentication...');
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      if (googleAuth.idToken == null) {
        print('DEBUG: GoogleSignInAuthentication.idToken is null.');
        return null;
      }

      print('DEBUG: ID Token successfully retrieved.');
      return googleAuth.idToken; // This is the ID token to send to your backend
    } catch (e) {
      print('DEBUG: Error signing in with Google in GoogleAuthServiceImpl: $e');
      return null;
    }
  }

  @override
  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }
}
