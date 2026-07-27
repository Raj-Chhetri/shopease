class SearchProductModel {
  final int id;
  final String name;
  final String? imageUrl;
  final double price;
  final double? originalPrice;
  final double ratingAvg;
  final int ratingCount;

  const SearchProductModel({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.price,
    this.originalPrice,
    required this.ratingAvg,
    required this.ratingCount,
  });

  factory SearchProductModel.fromJson(Map<String, dynamic> json) {
    return SearchProductModel(
      id: json["id"],
      name: json["name"] ?? "",
      imageUrl:
          json["primary_image"] ??
          ((json["images"] as List?)?.isNotEmpty == true
              ? json["images"][0]
              : null),
      price: double.parse(json["price"].toString()),
      originalPrice: json["discount_percent"] != null
          ? _calculateOriginalPrice(
              double.parse(json["price"].toString()),
              double.parse(json["discount_percent"].toString()),
            )
          : null,
      ratingAvg: double.tryParse(json['rating_avg']?.toString() ?? '0') ?? 0,

      ratingCount: int.tryParse(json['rating_count']?.toString() ?? '0') ?? 0,
    );
  }

  static double? _calculateOriginalPrice(double price, double discount) {
    if (discount <= 0) return null;
    return price / (1 - discount / 100);
  }
}
