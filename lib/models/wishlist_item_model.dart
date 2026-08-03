// lib/models/wishlist_item_model.dart

class WishlistItemModel {
  final int productId;
  final String productName;
  final String imageUrl;
  final double currentPrice;
  final double? oldPrice;
  final int? categoryId;

  const WishlistItemModel({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.currentPrice,
    this.oldPrice,
    this.categoryId,
  });

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) {
    // Wishlist API wraps product details under "product"
    final product = json['product'] is Map<String, dynamic>
        ? json['product'] as Map<String, dynamic>
        : json;

    final basePrice = _toDouble(product['price']);
    final discountPercent = _toDouble(product['discount_percent']);
    final hasDiscount = discountPercent > 0;

    final discountedPrice = hasDiscount
        ? double.parse(
            (basePrice - (basePrice * discountPercent / 100)).toStringAsFixed(
              2,
            ),
          )
        : basePrice;

    final image =
        product['primary_image']?.toString() ??
        ((product['image_urls'] is List &&
                (product['image_urls'] as List).isNotEmpty)
            ? (product['image_urls'] as List).first.toString()
            : (product['images'] is List &&
                      (product['images'] as List).isNotEmpty
                  ? (product['images'] as List).first.toString()
                  : ''));

    return WishlistItemModel(
      productId: _toInt(json['product_id'] ?? product['id']),
      productName:
          product['name']?.toString() ??
          product['title']?.toString() ??
          'Product',
      imageUrl: image,
      currentPrice: hasDiscount ? discountedPrice : basePrice,
      oldPrice: hasDiscount ? basePrice : null,
      categoryId: _toNullableInt(product['category_id']),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static int? _toNullableInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double? _toNullableDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
