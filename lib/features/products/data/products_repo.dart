import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:riverprod/features/products/data/model/products_model.dart';

part 'products_repo.g.dart';

@riverpod
Dio dio(Ref ref) {
  return Dio(BaseOptions(baseUrl: 'https://dummyjson.com/'));
}

@riverpod
ProductsRepo productsRepo(Ref ref) {
  return ProductsRepo(ref.read(dioProvider));
}

class ProductsRepo {
  final Dio _dio;

  ProductsRepo(this._dio);

  Future<PaginatedProducts> getProducts({
    required CancelToken cancelToken,
    int limit = 20,
    int skip = 0,
  }) async {
    try {
      final response = await _dio.get(
        'products',
        queryParameters: {'limit': limit, 'skip': skip},
        cancelToken: cancelToken,
      );

      final Map<String, dynamic> data = Map<String, dynamic>.from(
        response.data as Map,
      );
      final List<dynamic> products = data['products'] as List<dynamic>;

      return PaginatedProducts(
        products: products
            .map(
              (json) => ProductsModel.fromJson(
                Map<String, dynamic>.from(json as Map),
              ),
            )
            .toList(),
        total: data['total'] as int,
        skip: data['skip'] as int,
        limit: data['limit'] as int,
      );
    } on Exception catch (e) {
      throw Exception('Произошла ошибка при получении товаров: $e');
    }
  }
}
