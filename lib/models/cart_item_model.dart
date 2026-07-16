class CartItemModel {
  final int id;
  final int productId;
  final String name;
  final String shopName;
  final String imageUrl;
  final double price;
  final double? originalPrice;
  final int quantity;
  final int stockQuantity;
  final String? color;
  final String? size;

  const CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.shopName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.stockQuantity,
    this.originalPrice,
    this.color,
    this.size,
  });

  CartItemModel copyWith({
    int? quantity,
  }) {
    return CartItemModel(
      id: id,
      productId: productId,
      name: name,
      shopName: shopName,
      imageUrl: imageUrl,
      price: price,
      originalPrice: originalPrice,
      quantity: quantity ?? this.quantity,
      stockQuantity: stockQuantity,
      color: color,
      size: size,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'] is Map<String, dynamic>
        ? json['product'] as Map<String, dynamic>
        : json;

    return CartItemModel(
      id: _toInt(
        json['id'] ??
            json['cart_item_id'],
      ),
      productId: _toInt(
        json['product_id'] ??
            product['id'],
      ),
      name: product['name']?.toString() ??
          product['title']?.toString() ??
          'Product',
      shopName: product['shop_name']?.toString() ??
          product['store_name']?.toString() ??
          'ShopEase',
      imageUrl: product['image_url']?.toString() ??
          product['image']?.toString() ??
          '',
      price: _toDouble(
        json['price'] ??
            product['price'],
      ),
      originalPrice: _toNullableDouble(
        product['original_price'] ??
            product['old_price'],
      ),
      quantity: _toInt(
        json['quantity'] ?? 1,
      ),
      stockQuantity: _toInt(
        product['stock_quantity'] ??
            product['stock'] ??
            999,
      ),
      color: json['color']?.toString(),
      size: json['size']?.toString(),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
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