class ProductDetailModel {
  final int id;
  final String name;
  final String subtitle;
  final String description;
  final double price;
  final double? originalPrice;
  final double rating;
  final int reviewCount;
  final int stockQuantity;
  final List<String> images;
  final List<String> sizes;
  final List<ProductColorModel> colors;
  final bool isFavorite;

  const ProductDetailModel({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.stockQuantity,
    required this.images,
    required this.sizes,
    required this.colors,
    this.isFavorite = false,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: _toInt(json['id']),
      name: json['name']?.toString() ?? '',
      subtitle:
          json['subtitle']?.toString() ??
          json['short_description']?.toString() ??
          '',
      description: json['description']?.toString() ?? '',
      price: _toDouble(json['price']),
      originalPrice: json['original_price'] == null
          ? null
          : _toDouble(json['original_price']),
      rating: _toDouble(json['rating']),
      reviewCount: _toInt(json['review_count'] ?? json['reviews_count']),
      stockQuantity: _toInt(json['stock_quantity'] ?? json['stock']),
      images: _parseImages(json['images']),
      sizes: _parseSizes(json['sizes']),
      colors: _parseColors(json['colors']),
      isFavorite: json['is_favorite'] == true || json['is_wishlist'] == true,
    );
  }

  double get discountPercentage {
    if (originalPrice == null ||
        originalPrice! <= 0 ||
        originalPrice! <= price) {
      return 0;
    }

    return ((originalPrice! - price) / originalPrice!) * 100;
  }

  bool get isOutOfStock => stockQuantity <= 0;

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();

    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static List<String> _parseImages(dynamic value) {
    if (value is! List) return [];

    return value
        .map((item) {
          if (item is String) return item;

          if (item is Map<String, dynamic>) {
            return item['url']?.toString() ??
                item['image']?.toString() ??
                item['path']?.toString() ??
                '';
          }

          return '';
        })
        .where((image) => image.isNotEmpty)
        .toList();
  }

  static List<String> _parseSizes(dynamic value) {
    if (value is! List) return [];

    return value
        .map((item) {
          if (item is String || item is num) {
            return item.toString();
          }

          if (item is Map<String, dynamic>) {
            return item['name']?.toString() ?? item['size']?.toString() ?? '';
          }

          return '';
        })
        .where((size) => size.isNotEmpty)
        .toList();
  }

  static List<ProductColorModel> _parseColors(dynamic value) {
    if (value is! List) return [];

    return value.map((item) {
      if (item is Map<String, dynamic>) {
        return ProductColorModel.fromJson(item);
      }

      return ProductColorModel(name: item.toString(), hexCode: '#6D28FF');
    }).toList();
  }
}

class ProductColorModel {
  final String name;
  final String hexCode;

  const ProductColorModel({required this.name, required this.hexCode});

  factory ProductColorModel.fromJson(Map<String, dynamic> json) {
    return ProductColorModel(
      name: json['name']?.toString() ?? 'Color',
      hexCode:
          json['hex_code']?.toString() ??
          json['hex']?.toString() ??
          json['value']?.toString() ??
          '#6D28FF',
    );
  }

  int get colorValue {
    var value = hexCode.replaceAll('#', '').trim();

    if (value.length == 6) {
      value = 'FF$value';
    }

    return int.tryParse(value, radix: 16) ?? 0xFF6D28FF;
  }
}
