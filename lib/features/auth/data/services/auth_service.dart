import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:case_digital_wallet/features/auth/domain/entities/user_entity.dart';

class AuthService {
  static const String _keyIsAuthenticated = 'isAuthenticated';
  static const String _keyUser = 'user';
  static const String _keyAuthToken = 'auth_token';

  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _sharedPreferences;

  AuthService(this._secureStorage, this._sharedPreferences);

  Future<void> saveAuthState(bool isAuthenticated) async {
    await _sharedPreferences.setBool(_keyIsAuthenticated, isAuthenticated);
  }

  Future<void> saveUser(UserEntity user) async {
    await _sharedPreferences.setString(_keyUser, jsonEncode(user.toJson()));
  }

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _keyAuthToken, value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: _keyAuthToken);
  }

  Future<UserEntity?> getUser() async {
    final userJson = _sharedPreferences.getString(_keyUser);
    if (userJson == null) return null;

    try {
      return UserEntity.fromJson(jsonDecode(userJson));
    } catch (e) {
      print('Error al deserializar usuario: $e');
      return null;
    }
  }

  Future<bool> isAuthenticated() async {
    // Simulate backend token validation delay
    await Future.delayed(const Duration(milliseconds: 500));
    final token = await getToken();
    return token != null &&
        (await _sharedPreferences.getBool(_keyIsAuthenticated) ?? false);
  }

  Future<void> clearSession() async {
    await _secureStorage.delete(key: _keyAuthToken);
    await _sharedPreferences.clear();
  }
}
