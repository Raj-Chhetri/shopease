import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/search_product_controller.dart';
import 'package:shopease/services/search_product_service.dart';
import 'package:shopease/views/product_detail.dart';
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
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  final TextEditingController minRatingController = TextEditingController();
  final TextEditingController maxRatingController = TextEditingController();
  final Set<int> favoriteProductIds = {};

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
    minPriceController.dispose();
    maxPriceController.dispose();
    minRatingController.dispose();
    maxRatingController.dispose();

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
                      isScrollControlled: true,
                      builder: (_) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 20,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: minPriceController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Minimum Price",
                                ),
                              ),

                              const SizedBox(height: 15),

                              TextField(
                                controller: maxPriceController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: "Maximum Price",
                                ),
                              ),

                              const SizedBox(height: 20),

                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  controller.searchProducts(
                                    queryParameters: {
                                      "q": searchController.text.trim(),
                                      "min_price": minPriceController.text,
                                      "max_price": maxPriceController.text,
                                    },
                                  );
                                },
                                child: const Text("Apply"),
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
                  icon: Icons.star_outline,
                  title: "Rating",
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 20,
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 20,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: minRatingController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                decoration: const InputDecoration(
                                  labelText: "Minimum Rating (0 - 5)",
                                ),
                              ),

                              const SizedBox(height: 15),

                              TextField(
                                controller: maxRatingController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                decoration: const InputDecoration(
                                  labelText: "Maximum Rating (0 - 5)",
                                ),
                              ),

                              const SizedBox(height: 20),

                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  controller.searchProducts(
                                    queryParameters: {
                                      "q": searchController.text.trim(),
                                      "min_rating": minRatingController.text,
                                      "max_rating": maxRatingController.text,
                                    },
                                  );
                                },
                                child: const Text("Apply"),
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
                  icon: Icons.refresh,
                  title: "Clear",
                  onPressed: () {
                    searchController.clear();
                    minPriceController.clear();
                    maxPriceController.clear();
                    minRatingController.clear();
                    maxRatingController.clear();

                    controller.clearSearch();
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          const SizedBox(width: 10),

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
                    childAspectRatio = 0.95;
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
          ),
        ],
      ),
    );
  }
}
