import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverprod/features/auth/application/auth_controller.dart';
import 'package:riverprod/features/auth/presentation/login_page.dart';
import 'package:riverprod/features/products/presentation/products_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return MaterialApp(
      title: 'Товары',
      debugShowCheckedModeBanner: false,
      home: authState.when(
        data: (token) =>
            token == null ? const LoginPage() : const ProductsPage(),
        error: (error, stackTrace) => Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Не удалось проверить авторизацию.'),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => ref.invalidate(authControllerProvider),
                  child: const Text('Повторить'),
                ),
              ],
            ),
          ),
        ),
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
