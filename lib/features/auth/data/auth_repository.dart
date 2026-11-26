import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverprod/core/network/dio_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(dioProvider));
});

class AuthRepository {
  AuthRepository(this._dio);

  static const _tokenKey = 'auth_token';
  static const _demoUsername = 'saikal';
  static const _demoPassword = 'saikalpass';
  static const _demoToken = 'local-demo-token';

  final Dio _dio;

  Future<String?> readToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKey);
  }

  Future<String> login({
    required String username,
    required String password,
  }) async {
    String token;
    if (username == _demoUsername && password == _demoPassword) {
      token = _demoToken;
    } else {
      final response = await _dio.post<Map<String, dynamic>>(
        'auth/login',
        data: {'username': username, 'password': password},
      );
      final responseToken =
          response.data?['accessToken'] ?? response.data?['token'];
      if (responseToken is! String || responseToken.isEmpty) {
        throw const FormatException('Сервер не вернул токен авторизации.');
      }
      token = responseToken;
    }

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenKey, token);
    return token;
  }

  Future<void> logout() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_tokenKey);
  }
}
