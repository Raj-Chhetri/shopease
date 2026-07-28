import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/search_product_controller.dart';
import 'package:shopease/services/search_product_service.dart';
import 'package:shopease/widgets/filter_button.dart';
import 'package:shopease/widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  final int? initialCategoryId;
  final String? initialCategoryName;

  const SearchScreen({
    super.key,
    this.initialCategoryId,
    this.initialCategoryName,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  Timer? debounce;

  late final SearchProductController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(SearchProductController(SearchProductService()));

    if (widget.initialCategoryName != null) {
      searchController.text = widget.initialCategoryName!;
    }

    if (widget.initialCategoryId != null) {
      controller.searchProducts(
        queryParameters: {"category_id": widget.initialCategoryId},
      );
    }
  }

  void search(String value) {
    debounce?.cancel();

    debounce = Timer(const Duration(milliseconds: 500), () {
      final keyword = value.trim();

      if (keyword.isEmpty) {
        controller.clearSearch();
        return;
      }

      controller.searchProducts(queryParameters: {"q": keyword});
    });
  }

  @override
  void dispose() {
    debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Products")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: TextField(
              controller: searchController,
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 50,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              children: [
                FilterButton(
                  icon: Icons.category_outlined,
                  title: "Category",
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              title: const Text("Electronics"),
                              onTap: () {
                                Navigator.pop(context);
                                controller.searchProducts(
                                  queryParameters: {"category": "Electronics"},
                                );
                              },
                            ),
                            ListTile(
                              title: const Text("Books"),
                              onTap: () {
                                Navigator.pop(context);
                                controller.searchProducts(
                                  queryParameters: {"category": "Books"},
                                );
                              },
                            ),
                            ListTile(
                              title: const Text("Clothing"),
                              onTap: () {
                                Navigator.pop(context);
                                controller.searchProducts(
                                  queryParameters: {"category": "Clothing"},
                                );
                              },
                            ),
                            ListTile(
                              title: const Text("Home and Garden"),
                              onTap: () {
                                Navigator.pop(context);
                                controller.searchProducts(
                                  queryParameters: {
                                    "category": "Home and Garden",
                                  },
                                );
                              },
                            ),
                            ListTile(
                              title: const Text("Sports"),
                              onTap: () {
                                Navigator.pop(context);
                                controller.searchProducts(
                                  queryParameters: {"category": "Sports"},
                                );
                              },
                            ),
                            ListTile(
                              title: const Text("General"),
                              onTap: () {
                                Navigator.pop(context);
                                controller.searchProducts(
                                  queryParameters: {"category": "General"},
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),

                const SizedBox(width: 10),

                FilterButton(
                  icon: Icons.attach_money,
                  title: "Price",
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  labelText: "Minimum Price",
                                ),
                              ),
                              SizedBox(height: 15),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: "Maximum Price",
                                ),
                              ),
                              SizedBox(height: 20),
                              FilledButton(
                                onPressed: () {},
                                child: Text("Apply"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(width: 10),

                FilterButton(
                  icon: Icons.sort,
                  title: "Sort",
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(title: Text("Price Low to High")),
                            ListTile(title: Text("Price High to Low")),
                            ListTile(title: Text("Highest Rated")),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.error.value != null) {
                return Center(child: Text(controller.error.value!));
              }

              if (controller.products.isEmpty) {
                return const Center(
                  child: Text(
                    "No Products Found",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.56,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final product = controller.products[index];

                  print(product.imageUrl); // Debug

                  return ProductCard(
                    productId: product.id,
                    productTitle: product.name,
                    image: product.imageUrl,
                    newPrice: product.price.toStringAsFixed(2),
                    oldPrice: product.originalPrice?.toStringAsFixed(2),
                    onTap: () {
                      // TODO: Product Detail Page
                    },
                    rating: product.ratingAvg,
                    ratingCount: product.ratingCount,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
