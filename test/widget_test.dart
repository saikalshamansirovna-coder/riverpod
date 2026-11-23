// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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

void main() {
  testWidgets('Products app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [productsRepoProvider.overrideWithValue(FakeProductsRepo())],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Products List'), findsOneWidget);
  });
}
