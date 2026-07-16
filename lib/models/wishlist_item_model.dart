class WishlistItemModel {
  final int productId;
  final String productName;
  final String imageUrl;
  final double currentPrice;
  final double? oldPrice;
  final int? categoryId;
  final String categoryName;

  const WishlistItemModel({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.currentPrice,
    required this.categoryName,
    this.oldPrice,
    this.categoryId,
  });

  factory WishlistItemModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final product = json['product'] is Map<String, dynamic>
        ? json['product'] as Map<String, dynamic>
        : json;

    final category =
        product['category'] is Map<String, dynamic>
            ? product['category'] as Map<String, dynamic>
            : <String, dynamic>{};

    return WishlistItemModel(
      productId: _toInt(
        json['product_id'] ?? product['id'],
      ),
      productName:
          product['name']?.toString() ??
          product['title']?.toString() ??
          'Product',
      imageUrl:
          product['image_url']?.toString() ??
          product['image']?.toString() ??
          '',
      currentPrice: _toDouble(
        product['sale_price'] ??
            product['price'] ??
            product['current_price'],
      ),
      oldPrice: _toNullableDouble(
        product['original_price'] ??
            product['old_price'] ??
            product['regular_price'],
      ),
      categoryId: _toNullableInt(
        product['category_id'] ?? category['id'],
      ),
      categoryName:
          category['name']?.toString() ??
          product['category_name']?.toString() ??
          'Other',
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;

    return int.tryParse(
          value?.toString() ?? '',
        ) ??
        0;
  }

  static int? _toNullableInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;

    return int.tryParse(value.toString());
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();

    return double.tryParse(
          value?.toString() ?? '',
        ) ??
        0;
  }

  static double? _toNullableDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();

    return double.tryParse(value.toString());
  }
}