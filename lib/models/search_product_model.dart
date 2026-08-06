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
    final price = double.tryParse(json["price"].toString()) ?? 0;
    final discount = double.tryParse(json["discount_percent"].toString()) ?? 0;

    // print("Price: ${json['price']}");
    // print("Discount: ${json['discount_percent']}");

    return SearchProductModel(
      id: json["id"],
      name: json["name"] ?? "",
      imageUrl:
          json["primary_image"] ??
          ((json["images"] as List?)?.isNotEmpty == true
              ? json["images"][0]
              : null),

      // Backend price (discounted price)
      price: price,

      // Original price before discount
      originalPrice: discount > 0 ? price / (1 - discount / 100) : null,

      ratingAvg: double.tryParse(json["rating_avg"]?.toString() ?? "0") ?? 0,

      ratingCount: int.tryParse(json["rating_count"]?.toString() ?? "0") ?? 0,
    );
  }
}
