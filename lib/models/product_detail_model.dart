class ProductDetailModel {
  ProductDetailModel({required this.success, required this.data});

  final bool? success;
  final Data? data;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      success: json["success"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {"success": success, "data": data?.toJson()};
}

class Data {
  Data({
    required this.id,
    required this.categoryId,
    required this.category,
    required this.name,
    required this.slug,
    required this.description,
    required this.brand,
    required this.price,
    required this.discountPercent,
    required this.stockQuantity,
    required this.images,
    required this.primaryImage,
    required this.isActive,
    required this.ratingAvg,
    required this.ratingCount,
    required this.createdAt,
    required this.updatedAt,
    required this.sizes,
    required this.colors,
  });

  final int? id;
  final int? categoryId;
  final String? category;
  final String? name;
  final String? slug;
  final String? description;
  final dynamic brand;
  final String? price;
  final String? discountPercent;
  final int? stockQuantity;
  final List<String> images;
  final String? primaryImage;
  final bool? isActive;
  final String? ratingAvg;
  final int? ratingCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String> sizes;
  final List<ProductColorModel> colors;

  double get originalPrice {
    return double.tryParse(price ?? '0') ?? 0;
  }

  double get discountPercentage {
    return double.tryParse(discountPercent ?? '0') ?? 0;
  }

  bool get hasDiscount {
    return originalPrice > 0 &&
        discountPercentage > 0 &&
        discountPercentage < 100;
  }

  double get discountedPrice {
    if (!hasDiscount) {
      return originalPrice;
    }

    return originalPrice - (originalPrice * discountPercentage / 100);
  }

  double get rating {
    return double.tryParse(ratingAvg ?? '0') ?? 0;
  }

  bool get isOutOfStock {
    return (stockQuantity ?? 0) <= 0;
  }

  static List<String> _parseSizes(dynamic value) {
    if (value is! List) {
      return [];
    }

    return value
        .map((item) {
          if (item is String || item is num) {
            return item.toString();
          }

          if (item is Map) {
            return item["name"]?.toString() ??
                item["size"]?.toString() ??
                item["value"]?.toString() ??
                "";
          }

          return "";
        })
        .where((size) => size.trim().isNotEmpty)
        .toList();
  }

  static List<ProductColorModel> _parseColors(dynamic value) {
    if (value is! List) {
      return [];
    }

    return value
        .map<ProductColorModel?>((item) {
          if (item is Map) {
            return ProductColorModel.fromJson(Map<String, dynamic>.from(item));
          }

          if (item is String && item.trim().isNotEmpty) {
            return ProductColorModel(name: item, hexCode: "#6D28FF");
          }

          return null;
        })
        .whereType<ProductColorModel>()
        .toList();
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();

    return int.tryParse(value.toString());
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: _toInt(json["id"]),
      categoryId: _toInt(json["category_id"]),
      category: json["category"],
      name: json["name"],
      slug: json["slug"],
      description: json["description"],
      brand: json["brand"],
      price: json["price"]?.toString(),
      discountPercent: json["discount_percent"]?.toString(),
      stockQuantity: _toInt(json["stock_quantity"]),
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      primaryImage: json["primary_image"],
      isActive: json["is_active"],
      ratingAvg: json["rating_avg"]?.toString(),
      ratingCount: _toInt(json["rating_count"]),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      sizes: _parseSizes(json["sizes"]),
      colors: _parseColors(json["colors"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "category": category,
    "name": name,
    "slug": slug,
    "description": description,
    "brand": brand,
    "price": price,
    "discount_percent": discountPercent,
    "stock_quantity": stockQuantity,
    "images": images.map((x) => x).toList(),
    "primary_image": primaryImage,
    "is_active": isActive,
    "rating_avg": ratingAvg,
    "rating_count": ratingCount,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "sizes": sizes,
    "colors": colors.map((color) => color.toJson()).toList(),
  };
}

class ProductColorModel {
  final String name;
  final String hexCode;

  const ProductColorModel({required this.name, required this.hexCode});

  factory ProductColorModel.fromJson(Map<String, dynamic> json) {
    return ProductColorModel(
      name: json["name"]?.toString() ?? json["color"]?.toString() ?? "Color",
      hexCode:
          json["hex_code"]?.toString() ??
          json["hex"]?.toString() ??
          json["value"]?.toString() ??
          "#6D28FF",
    );
  }

  int get colorValue {
    var value = hexCode.replaceAll("#", "").trim();

    if (value.length == 6) {
      value = "FF$value";
    }

    return int.tryParse(value, radix: 16) ?? 0xFF6D28FF;
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "hex_code": hexCode};
  }
}
