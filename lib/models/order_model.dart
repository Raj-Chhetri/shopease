class OrderModel {
  final int id;
  final String orderNumber;
  final String status;
  final String paymentMethod;
  final String paymentStatus;
  final double total;
  final DateTime? createdAt;
  final List<OrderItemModel> items;

  const OrderModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.total,
    required this.items,
    this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] ??
        json['order_items'] ??
        <dynamic>[];

    return OrderModel(
      id: _toInt(json['id']),
      orderNumber: json['order_number']?.toString() ??
          json['order_id']?.toString() ??
          json['id']?.toString() ??
          '',
      status: json['status']?.toString() ?? 'pending',
      paymentMethod:
          json['payment_method']?.toString() ?? '',
      paymentStatus:
          json['payment_status']?.toString() ?? '',
      total: _toDouble(
        json['total'] ??
            json['total_amount'] ??
            json['grand_total'],
      ),
      createdAt: DateTime.tryParse(
        json['created_at']?.toString() ?? '',
      ),
      items: rawItems is List
          ? rawItems
              .whereType<Map<String, dynamic>>()
              .map(OrderItemModel.fromJson)
              .toList()
          : const [],
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
}

class OrderItemModel {
  final int id;
  final int productId;
  final String name;
  final String shopName;
  final String imageUrl;
  final double price;
  final int quantity;
  final String? color;
  final String? size;

  const OrderItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.shopName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    this.color,
    this.size,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'] is Map<String, dynamic>
        ? json['product'] as Map<String, dynamic>
        : json;

    return OrderItemModel(
      id: _toInt(json['id']),
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
      quantity: _toInt(
        json['quantity'] ?? 1,
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
}