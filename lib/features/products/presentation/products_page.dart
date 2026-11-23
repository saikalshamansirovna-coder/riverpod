import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverprod/features/products/application/products_controller.dart';
import 'package:riverprod/features/products/presentation/product_detail_page.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      ref.read(productsControllerProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Products List")),
      body: products.when(
        data: (data) {
          final controller = ref.read(productsControllerProvider.notifier);
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(productsControllerProvider.notifier).refresh(),
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: data.length + (controller.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == data.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return ListTile(
                  leading: data[index].image.isEmpty
                      ? const Icon(Icons.image_not_supported)
                      : Image.network(
                          data[index].image,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                  title: Text(data[index].title),
                  subtitle: Text("\$${data[index].price}"),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: data[index]),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
        error: (error, stackTrace) =>
            Center(child: Text("Произошла ошибка при загрузке товаров $error")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
