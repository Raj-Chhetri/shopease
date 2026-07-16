class CategoryModel {
  final int id;
  final String name;
  final String? imageUrl;
  final int productCount;

  const CategoryModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.productCount = 0,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: _parseInt(json['id']),
      name:
          json['name']?.toString() ??
          json['title']?.toString() ??
          'Category',
      imageUrl:
          json['image_url']?.toString() ??
          json['image']?.toString(),
      productCount: _parseInt(
        json['products_count'] ??
            json['product_count'] ??
            json['productsCount'],
      ),
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}