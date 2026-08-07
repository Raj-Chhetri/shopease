class OrderDetailsModel {
  final int id;
  final String orderNumber;
  final String status;
  final String paymentMethod;
  final String paymentStatus;

  final double subtotal;
  final double shippingFee;
  final double deliveryFee;
  final double discountAmount;
  final double total;

  final DateTime? createdAt;

  final AddressModel? address;

  final List<OrderProductModel> products;

  const OrderDetailsModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.subtotal,
    required this.shippingFee,
    required this.deliveryFee,
    required this.discountAmount,
    required this.total,
    required this.products,
    this.address,
    this.createdAt,
  });

  factory OrderDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawItems = json['items'] ?? [];
    final rawAddress = json['address'];

    return OrderDetailsModel(
      id: _toInt(json['id']),
      orderNumber:
          json['order_number']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      paymentMethod:
          json['payment_method']?.toString() ?? '',
      paymentStatus:
          json['payment_status']?.toString() ?? '',
      subtotal: _toDouble(json['subtotal']),
      shippingFee: _toDouble(json['shipping_cost']),
      deliveryFee: _toDouble(json['delivery_amount']),
      discountAmount:
          _toDouble(json['discount_amount']),
      total: _toDouble(
        json['grand_total'] ??
            json['total_amount'],
      ),
      createdAt: DateTime.tryParse(
        json['created_at']?.toString() ?? '',
      ),
      address:
          rawAddress is Map<String, dynamic>
              ? AddressModel.fromJson(rawAddress)
              : null,
      products: rawItems is List
          ? rawItems
              .whereType<Map<String, dynamic>>()
              .map(OrderProductModel.fromJson)
              .toList()
          : [],
    );
  }

  int get totalQuantity {
    return products.fold(
      0,
      (sum, item) => sum + item.quantity,
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }
}

class OrderProductModel {
  final int id;
  final int productId;
  final String name;
  final String shopName;
  final String imageUrl;
  final double price;
  final int quantity;

  const OrderProductModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.shopName,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  double get total => price * quantity;

  factory OrderProductModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final product =
        json['product'] is Map<String, dynamic>
            ? json['product']
                as Map<String, dynamic>
            : {};

    return OrderProductModel(
      id: _toInt(json['id']),
      productId: _toInt(
        json['product_id'] ?? product['id'],
      ),
      name:
          product['name']?.toString() ??
              'Product',
      shopName:
          product['shop_name']?.toString() ??
              'ShopEase',
      imageUrl:
          product['primary_image']?.toString() ??
              '',
      price: _toDouble(json['price']),
      quantity: _toInt(json['quantity']),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }
}

class AddressModel {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String zipCode;
  final String country;

  const AddressModel({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
  });

  factory AddressModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AddressModel(
      addressLine1:
          json['address_line1']?.toString() ?? '',
      addressLine2:
          json['address_line2']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
      zipCode:
          json['zip_code']?.toString() ?? '',
      country:
          json['country']?.toString() ?? '',
    );
  }

  String get fullAddress =>
      '$addressLine1, $addressLine2, $city, $state, $zipCode, $country';
}