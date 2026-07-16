class SearchProductModel {
  final int id;
  final String name;
  final String imageUrl;
  final num price;
  final num? originalPrice;

  const SearchProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
  });

  factory SearchProductModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final images = json['images'];

    String imageUrl = '';

    if (json['image_url'] != null) {
      imageUrl = json['image_url'].toString();
    } else if (json['image'] != null) {
      imageUrl = json['image'].toString();
    } else if (images is List && images.isNotEmpty) {
      final firstImage = images.first;

      if (firstImage is Map<String, dynamic>) {
        imageUrl =
            firstImage['url']?.toString() ??
            firstImage['image_url']?.toString() ??
            '';
      } else {
        imageUrl = firstImage.toString();
      }
    }

    return SearchProductModel(
      id: _parseInt(json['id']),
      name:
          json['name']?.toString() ??
          json['title']?.toString() ??
          'Product',
      imageUrl: imageUrl,
      price: _parseNum(
        json['price'] ??
            json['sale_price'] ??
            json['current_price'],
      ),
      originalPrice: _parseNullableNum(
        json['original_price'] ??
            json['old_price'] ??
            json['regular_price'],
      ),
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static num _parseNum(dynamic value) {
    if (value is num) return value;
    return num.tryParse(value?.toString() ?? '') ?? 0;
  }

  static num? _parseNullableNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    return num.tryParse(value.toString());
  }
}