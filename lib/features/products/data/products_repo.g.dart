// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_repo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
