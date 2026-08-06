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
    final rawItems = json['items'] ?? json['order_items'] ?? <dynamic>[];

    return OrderModel(
      id: _toInt(json['id']),
      orderNumber:
          json['order_number']?.toString() ??
          json['order_id']?.toString() ??
          json['id']?.toString() ??
          '',
      status:
          json['order_status']?.toString() ??
          json['status']?.toString() ??
          'pending',
      paymentMethod:
          json['payment_method']?.toString() ??
          _nestedValue(json, 'payment', 'payment_method') ??
          _nestedValue(json, 'payment', 'method') ??
          '',
      paymentStatus:
          json['payment_status']?.toString() ??
          _nestedValue(json, 'payment', 'status') ??
          '',
      total: _toDouble(
        json['grand_total'] ??
            json['total_amount'] ??
            json['payable_amount'] ??
            json['total'],
      ),
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? ''),
      items: rawItems is List
          ? rawItems
                .whereType<Map>()
                .map(Map<String, dynamic>.from)
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

  static String? _nestedValue(
    Map<String, dynamic> json,
    String objectKey,
    String valueKey,
  ) {
    final object = json[objectKey];
    if (object is! Map) return null;
    return object[valueKey]?.toString();
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
      productId: _toInt(json['product_id'] ?? product['id']),
      name:
          product['name']?.toString() ??
          product['title']?.toString() ??
          'Product',
      shopName:
          product['shop_name']?.toString() ??
          product['store_name']?.toString() ??
          'ShopEase',
      imageUrl: _readImageUrl(product),
      price: _toDouble(json['price'] ?? product['price']),
      quantity: _toInt(json['quantity'] ?? 1),
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

  static String _readImageUrl(Map<String, dynamic> product) {
    final directImage =
        product['image_url'] ?? product['primary_image'] ?? product['image'];

    if (directImage != null && directImage.toString().isNotEmpty) {
      return _normalizeImageUrl(directImage.toString());
    }

    final imageUrls = product['image_urls'];
    if (imageUrls is List && imageUrls.isNotEmpty) {
      return _normalizeImageUrl(imageUrls.first.toString());
    }

    final images = product['images'];
    if (images is List && images.isNotEmpty) {
      return _normalizeImageUrl(images.first.toString());
    }

    return '';
  }

  static String _normalizeImageUrl(String value) {
    final image = value.trim();
    if (image.isEmpty) return '';

    final uri = Uri.tryParse(image);

    if (uri != null &&
        uri.hasScheme &&
        (uri.host == '127.0.0.1' || uri.host == 'localhost')) {
      return 'https://shopease.sudamhub.com${uri.path}';
    }

    if (image.startsWith('http://') || image.startsWith('https://')) {
      return image;
    }

    if (image.startsWith('/')) {
      return 'https://shopease.sudamhub.com$image';
    }

    final path = image.startsWith('storage/') ? image : 'storage/$image';
    return 'https://shopease.sudamhub.com/$path';
  }
}
