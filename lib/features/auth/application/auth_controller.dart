import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverprod/features/auth/data/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  Future<String?> build() {
    return ref.read(authRepositoryProvider).readToken();
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final token = await ref
        .read(authRepositoryProvider)
        .login(username: username, password: password);
    state = AsyncData(token);
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(null);
  }
}
