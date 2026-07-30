import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/product_controller.dart';
import 'package:shopease/views/product_detail.dart';
import 'package:shopease/widgets/product_card.dart';

class CategoryProductsPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryProductsPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  final Set<int> favoriteProductIds = {};

  late final ProductController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(ProductController());

    controller.fetchProductsByCategory(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.products.isEmpty) {
          return const Center(child: Text("No Products Found"));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            int crossAxisCount;
            double childAspectRatio;

            if (width < 380) {
              // Small phones
              crossAxisCount = 2;
              childAspectRatio = 0.53;
            } else if (width < 450) {
              // Normal phones
              crossAxisCount = 2;
              childAspectRatio = 0.62;
            } else if (width < 650) {
              // Large phones
              crossAxisCount = 2;
              childAspectRatio = 0.79;
            } else if (width < 950) {
              // Tablet / Small web
              crossAxisCount = 3;
              childAspectRatio = 0.86;
            } else if (width < 1250) {
              // Desktop
              crossAxisCount = 4;
              childAspectRatio = 0.93;
            } else {
              // Large desktop
              crossAxisCount = 5;
              childAspectRatio = 0.82;
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: childAspectRatio,
              ),
              itemBuilder: (context, index) {
                final product = controller.products[index];

                return ProductCard(
                  productId: product.id,
                  productTitle: product.name,
                  image: product.imageUrl,
                  newPrice: product.price.toStringAsFixed(2),
                  oldPrice: product.originalPrice?.toStringAsFixed(2),
                  rating: product.ratingAvg,
                  ratingCount: product.ratingCount,
                  isFavorite: favoriteProductIds.contains(product.id),
                  onFavoritePressed: () {
                    setState(() {
                      if (favoriteProductIds.contains(product.id)) {
                        favoriteProductIds.remove(product.id);
                      } else {
                        favoriteProductIds.add(product.id);
                      }
                    });
                  },
                  onTap: () {
                    Get.to(
                      () => ProductDetail(productId: product.id),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 250),
                    );
                  },
                );
              },
            );
          },
        );
      }),
    );
  }
}
