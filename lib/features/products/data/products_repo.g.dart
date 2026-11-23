// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dio)
final dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'de2009362029273ea40a2642716259c39ba8b6b6';

@ProviderFor(productsRepo)
final productsRepoProvider = ProductsRepoProvider._();

final class ProductsRepoProvider
    extends $FunctionalProvider<ProductsRepo, ProductsRepo, ProductsRepo>
    with $Provider<ProductsRepo> {
  ProductsRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productsRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productsRepoHash();

  @$internal
  @override
  $ProviderElement<ProductsRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ProductsRepo create(Ref ref) {
    return productsRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProductsRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProductsRepo>(value),
    );
  }
}

String _$productsRepoHash() => r'be469aa913f6c7bdc87bc0318cebb9e24d0284a7';
