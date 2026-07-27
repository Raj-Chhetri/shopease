import 'package:flutter/material.dart';
import 'package:shopease/models/home_product.dart';
import 'package:shopease/widgets/product_card.dart';

class ResponsiveProductGrid extends StatelessWidget {
  final List<HomeProduct> products;
  final double availableWidth;
  final Set<int> favoriteProductIds;
  final ValueChanged<int> onProductPressed;
  final ValueChanged<int> onFavoritePressed;

  const ResponsiveProductGrid({
    super.key,
    required this.products,
    required this.availableWidth,
    required this.favoriteProductIds,
    required this.onProductPressed,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    final columns = availableWidth >= 1050
        ? 4
        : availableWidth >= 720
            ? 3
            : 2;
    const spacing = 14.0;
    final itemWidth =
        (availableWidth - spacing * (columns - 1)) / columns;

    return Wrap(
      spacing: spacing,
      runSpacing: 18,
      children: products.map((product) {
        return SizedBox(
          width: itemWidth,
          child: ProductCard(
            productId: product.id,
            imageUrl: product.imageUrl,
            oldPrice: product.oldPrice,
            newPrice: product.newPrice,
            productTitle: product.title,
            isFavorite: favoriteProductIds.contains(product.id),
            onTap: () => onProductPressed(product.id),
            onFavoritePressed: () => onFavoritePressed(product.id),
          ),
        );
      }).toList(),
    );
  }
}
