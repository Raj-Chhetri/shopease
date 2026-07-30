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

        return GridView.builder(
          padding: const EdgeInsets.all(16),

          itemCount: controller.products.length,

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.57,
          ),

          itemBuilder: (context, index) {
            final product = controller.products[index];

            return ProductCard(
              productId: product.id,

              productTitle: product.name,

              image: product.images.isNotEmpty ? product.images.first : null,
              newPrice: product.price.toStringAsFixed(2),
              oldPrice: product.originalPrice?.toStringAsFixed(2),

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
                ); // Product Detail Page later
              },
              rating: product.ratingAvg,
              ratingCount: product.ratingCount,
            );
          },
        );
      }),
    );
  }
}
