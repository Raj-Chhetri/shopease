class ProductModel {
  const ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPercent,
    required this.images,
    required this.ratingAvg,
    required this.ratingCount,
  });

  final int id;
  final int categoryId;
  final String name;
  final String description;
  final double price;
  final int discountPercent;
  final List<String> images;
  final double ratingAvg;
  final int ratingCount;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: _parseInt(json['id']),
      categoryId: _parseInt(json['category_id']),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      discountPercent: _parseInt(json['discount_percent']),
      images: json['images'] == null
          ? []
          : List<String>.from(json['images'].map((e) => e.toString())),

      ratingAvg: double.tryParse(json['rating_avg']?.toString() ?? '0') ?? 0,

      ratingCount: int.tryParse(json['rating_count']?.toString() ?? '0') ?? 0,
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  /// Optional helper
  String? get imageUrl {
    if (images.isEmpty) return null;
    return images.first;
  }

  /// Optional helper
  double get originalPrice {
    if (discountPercent <= 0) return price;

    return price / (1 - (discountPercent / 100));
  }
}
