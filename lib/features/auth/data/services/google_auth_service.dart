abstract class GoogleAuthService {
  Future<Map<String, dynamic>> signIn();
}

class MockGoogleAuthService implements GoogleAuthService {
  @override
  Future<Map<String, dynamic>> signIn() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock response
    return {
      "email": "user@example.com",
      "displayName": "Juan Pérez",
      "photoUrl": "https://example.com/photo.jpg",
    };
  }
}
