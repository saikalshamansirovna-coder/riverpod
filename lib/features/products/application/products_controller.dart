import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverprod/features/products/data/model/products_model.dart';
import 'package:riverprod/features/products/data/products_repo.dart';

part 'products_controller.g.dart';

@riverpod
class ProductsController extends _$ProductsController {
  static const int _pageSize = 20;
  int _skip = 0;
  bool _hasMore = true;
  bool _isLoadingNextPage = false;

  bool get hasMore => _hasMore;
  bool get isLoadingNextPage => _isLoadingNextPage;

  @override
  FutureOr<List<ProductsModel>> build() async {
    final CancelToken cancelToken = CancelToken();
    ref.onDispose(cancelToken.cancel);

    final result = await ref
        .read(productsRepoProvider)
        .getProducts(cancelToken: cancelToken, limit: _pageSize, skip: 0);

    _skip = result.products.length;
    _hasMore = _skip < result.total;
    return result.products;
  }

  Future<void> loadNextPage() async {
    if (_isLoadingNextPage || !_hasMore) {
      return;
    }

    final current = state.value;
    if (current == null) {
      return;
    }

    _isLoadingNextPage = true;
    ref.notifyListeners();

    try {
      final CancelToken cancelToken = CancelToken();
      ref.onDispose(cancelToken.cancel);

      final result = await ref
          .read(productsRepoProvider)
          .getProducts(cancelToken: cancelToken, limit: _pageSize, skip: _skip);

      _skip += result.products.length;
      _hasMore = _skip < result.total;
      state = AsyncData([...current, ...result.products]);
    } catch (_) {
      state = AsyncData(current);
    } finally {
      _isLoadingNextPage = false;
      ref.notifyListeners();
    }
  }

  Future<void> refresh() async {
    _skip = 0;
    _hasMore = true;
    _isLoadingNextPage = false;
    state = const AsyncLoading();

    try {
      final CancelToken cancelToken = CancelToken();
      ref.onDispose(cancelToken.cancel);
      final result = await ref
          .read(productsRepoProvider)
          .getProducts(cancelToken: cancelToken, limit: _pageSize, skip: 0);

      _skip = result.products.length;
      _hasMore = _skip < result.total;
      state = AsyncData(result.products);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
