import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverprod/features/auth/data/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test(
    'demo credentials create a saved local token without a server',
    () async {
      SharedPreferences.setMockInitialValues({});
      final repository = AuthRepository(Dio());

      final token = await repository.login(
        username: 'saikal',
        password: 'saikalpass',
      );

      expect(token, isNotEmpty);
      expect(await repository.readToken(), token);
    },
  );

  test(
    'login saves token for the next app launch and logout removes it',
    () async {
      SharedPreferences.setMockInitialValues({});
      final dio = Dio();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            handler.resolve(
              Response(
                requestOptions: options,
                data: {'accessToken': 'saved-token'},
                statusCode: 200,
              ),
            );
          },
        ),
      );
      final repository = AuthRepository(dio);

      await repository.login(username: 'user', password: 'password');
      expect(await repository.readToken(), 'saved-token');

      await repository.logout();
      expect(await repository.readToken(), isNull);
    },
  );
}
