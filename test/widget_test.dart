// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:riverprod/features/auth/data/auth_repository.dart';
import 'package:riverprod/features/products/data/model/products_model.dart';
import 'package:riverprod/features/products/data/products_repo.dart';
import 'package:riverprod/main.dart';

class FakeProductsRepo extends ProductsRepo {
  FakeProductsRepo() : super(Dio());

  @override
  Future<PaginatedProducts> getProducts({
    required CancelToken cancelToken,
    int limit = 20,
    int skip = 0,
  }) async {
    return const PaginatedProducts(products: [], total: 0, skip: 0, limit: 20);
  }
}

class FakeAuthRepository extends AuthRepository {
  FakeAuthRepository({this.token}) : super(Dio());

  String? token;

  @override
  Future<String?> readToken() async => token;

  @override
  Future<String> login({
    required String username,
    required String password,
  }) async {
    token = 'test-token';
    return token!;
  }

  @override
  Future<void> logout() async {
    token = null;
  }
}

void main() {
  testWidgets('user without a token can log in and log out', (
    WidgetTester tester,
  ) async {
    final authRepository = FakeAuthRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          productsRepoProvider.overrideWithValue(FakeProductsRepo()),
          authRepositoryProvider.overrideWithValue(authRepository),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Вход'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'user');
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    await tester.tap(find.text('Войти'));
    await tester.pumpAndSettle();

    expect(find.text('Products List'), findsOneWidget);

    await tester.tap(find.byTooltip('Выйти'));
    await tester.pumpAndSettle();

    expect(find.text('Вход'), findsOneWidget);
  });

  testWidgets('saved token opens products without login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          productsRepoProvider.overrideWithValue(FakeProductsRepo()),
          authRepositoryProvider.overrideWithValue(
            FakeAuthRepository(token: 'saved-token'),
          ),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Products List'), findsOneWidget);
    expect(find.text('Вход'), findsNothing);
  });
}
