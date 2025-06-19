import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:case_digital_wallet/features/auth/domain/entities/user_entity.dart';

class AuthService {
  static const String _keyIsAuthenticated = 'isAuthenticated';
  static const String _keyUser = 'user';

  Future<void> saveAuthState(bool isAuthenticated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsAuthenticated, isAuthenticated);
  }

  Future<void> saveUser(UserEntity user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUser, jsonEncode(user.toJson()));
  }

  Future<UserEntity?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_keyUser);
    if (userJson == null) return null;

    try {
      return UserEntity.fromJson(jsonDecode(userJson));
    } catch (e) {
      print('Error al deserializar usuario: $e');
      return null;
    }
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsAuthenticated) ?? false;
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
