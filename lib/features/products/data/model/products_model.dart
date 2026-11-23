class ProductsModel {
  final int id;
  final String title;
  final double price;
  final String image;
  final String description;
  final String brand;
  final String category;
  final double rating;
  final int stock;
  final double discountPercentage;
  final List<String> images;

  ProductsModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.description = '',
    this.brand = '',
    this.category = '',
    this.rating = 0,
    this.stock = 0,
    this.discountPercentage = 0,
    this.images = const [],
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      image: (json['thumbnail'] ?? json['image'] ?? '') as String,
      description: json['description'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      category: json['category'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      stock: json['stock'] as int? ?? 0,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0,
      images: (json['images'] as List<dynamic>? ?? const [])
          .map((image) => image.toString())
          .toList(),
    );
  }
}

class PaginatedProducts {
  final List<ProductsModel> products;
  final int total;
  final int skip;
  final int limit;

  const PaginatedProducts({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });
}
