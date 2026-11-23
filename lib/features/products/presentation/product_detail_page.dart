import 'package:flutter/material.dart';
import 'package:riverprod/features/products/data/model/products_model.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final ProductsModel product;

  @override
  Widget build(BuildContext context) {
    final gallery = product.images.isNotEmpty
        ? product.images
        : product.image.isNotEmpty
        ? [product.image]
        : <String>[];

    return Scaffold(
      appBar: AppBar(title: const Text('Информация о товаре')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: gallery.isEmpty
                    ? const ColoredBox(
                        color: Color(0xFFEFEFEF),
                        child: Icon(Icons.image_not_supported, size: 64),
                      )
                    : PageView.builder(
                        itemCount: gallery.length,
                        itemBuilder: (context, index) => Image.network(
                          gallery[index],
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 64),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (product.discountPercentage > 0) ...[
              const SizedBox(height: 4),
              Text(
                'Скидка ${product.discountPercentage.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 20),
            if (product.description.isNotEmpty) ...[
              Text('Описание', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 6),
              Text(product.description),
              const SizedBox(height: 16),
            ],
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    _InfoRow(
                      icon: Icons.category_outlined,
                      label: 'Категория',
                      value: product.category.isEmpty
                          ? 'Не указана'
                          : product.category,
                    ),
                    _InfoRow(
                      icon: Icons.business_outlined,
                      label: 'Бренд',
                      value: product.brand.isEmpty
                          ? 'Не указан'
                          : product.brand,
                    ),
                    _InfoRow(
                      icon: Icons.star_outline,
                      label: 'Рейтинг',
                      value: product.rating.toStringAsFixed(1),
                    ),
                    _InfoRow(
                      icon: Icons.inventory_2_outlined,
                      label: 'В наличии',
                      value: '${product.stock} шт.',
                    ),
                    _InfoRow(
                      icon: Icons.tag_outlined,
                      label: 'ID',
                      value: product.id.toString(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Text(label),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
