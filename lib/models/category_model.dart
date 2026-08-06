class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String? icon;
  final bool isActive;
  final int productCount;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.isActive,
    required this.productCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      slug: json["slug"] ?? "",
      icon: json["icon"],
      isActive: json["is_active"] == 1,
      productCount: json["products_count"] ?? 0,
    );
  }
}
