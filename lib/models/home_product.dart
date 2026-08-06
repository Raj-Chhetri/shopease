class HomeProduct {
  final int id;
  final String title;
  final String imageUrl;
  final String oldPrice;
  final String newPrice;

  const HomeProduct({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.oldPrice,
    required this.newPrice,
  });

  factory HomeProduct.fromApiJson(
    Map<
      String,
      dynamic
    >
    json,
  ) {
    final price =
        double.tryParse(
          json['price']?.toString() ??
              '0',
        ) ??
        0.0;
    final discountPercent =
        double.tryParse(
          json['discount_percent']?.toString() ??
              '0',
        ) ??
        0.0;

    final originalPrice =
        discountPercent >
            0
        ? price /
              (1 -
                  (discountPercent /
                      100))
        : price;
    final discountedPrice =
        discountPercent >
            0
        ? price
        : originalPrice;

    final imageUrl =
        (json['primary_image'] ??
                json['image'] ??
                '')
            .toString()
            .trim();
    final fallbackImage =
        (json['images']
            is List)
        ? (json['images']
                  as List)
              .firstWhere(
                (
                  image,
                ) =>
                    image !=
                    null,
                orElse: () => '',
              )
              .toString()
        : '';

    return HomeProduct(
      id:
          int.tryParse(
            json['id']?.toString() ??
                '0',
          ) ??
          0,
      title:
          json['name']?.toString() ??
          'Untitled product',
      imageUrl: imageUrl.isNotEmpty
          ? imageUrl
          : fallbackImage,
      oldPrice: _formatPrice(
        originalPrice,
      ),
      newPrice: _formatPrice(
        discountedPrice,
      ),
    );
  }

  static String _formatPrice(
    double value,
  ) {
    return value
        .toStringAsFixed(
          value.truncateToDouble() ==
                  value
              ? 0
              : 2,
        )
        .replaceAll(
          RegExp(
            r'\.0+$',
          ),
          '',
        );
  }
}
