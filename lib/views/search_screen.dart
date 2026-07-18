// // search screen

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopease/controller/filter_controller.dart';
// import 'package:shopease/views/homescreen.dart';
// import 'package:shopease/widgets/filter_button.dart';
// import 'package:shopease/widgets/product_card.dart';

// class SearchScreen extends StatelessWidget {
//   const SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final categories = [
//       {
//         "productName": "Electronics",
//         "image":
//             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlnDGMoPVwxaNdwOHBekAEWpCR-T8eEPb7m9OxUV-xxg&s=10",
//         "currentPrice": "Rs. 10000",
//         "oldPrice": "Rs. 12000",
//       },
//       {
//         "productName": "Electronics",
//         "image":
//             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlnDGMoPVwxaNdwOHBekAEWpCR-T8eEPb7m9OxUV-xxg&s=10",
//         "currentPrice": "Rs. 10000",
//         "oldPrice": "Rs. 12000",
//       },
//       {
//         "productName": "Electronics",
//         "image":
//             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlnDGMoPVwxaNdwOHBekAEWpCR-T8eEPb7m9OxUV-xxg&s=10",
//         "currentPrice": "Rs. 10000",
//         "oldPrice": "Rs. 12000",
//       },
//       {
//         "productName": "Electronics",
//         "image":
//             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlnDGMoPVwxaNdwOHBekAEWpCR-T8eEPb7m9OxUV-xxg&s=10",
//         "currentPrice": "Rs. 10000",
//         "oldPrice": "Rs. 12000",
//       },
//       {
//         "productName": "Electronics",
//         "image":
//             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlnDGMoPVwxaNdwOHBekAEWpCR-T8eEPb7m9OxUV-xxg&s=10",
//         "currentPrice": "Rs. 10000",
//         "oldPrice": "Rs. 12000",
//       },
//       {
//         "productName": "Electronics",
//         "image":
//             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlnDGMoPVwxaNdwOHBekAEWpCR-T8eEPb7m9OxUV-xxg&s=10",
//         "currentPrice": "Rs. 10000",
//         "oldPrice": "Rs. 12000",
//       },
//       {
//         "productName": "Electronics",
//         "image":
//             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlnDGMoPVwxaNdwOHBekAEWpCR-T8eEPb7m9OxUV-xxg&s=10",
//         "currentPrice": "Rs. 10000",
//         "oldPrice": "Rs. 12000",
//       },
//     ];
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F8F8),
    
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text(
//           "Search",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 28,
//           ),
//         ),
    
//         leading: BackButton(
//           color: Colors.black,
//           onPressed: () {
//             Get.off(() => HomeScreen());
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
    
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
    
//           children: [
//             /// Search Bar
//             TextField(
//               autofocus: true,
//               decoration: InputDecoration(
//                 hintText: "Search here",
    
//                 prefixIcon: IconButton(
//                   icon: const Icon(Icons.search, color: Color(0xFF7A5AF8)),
//                   onPressed: () {
//                     // Add your search logic here
//                   },
//                 ),
    
//                 // suffixIcon: MenuAnchor(
//                 //   builder: (context, controller, child) {
//                 //     return IconButton(
//                 //       icon: const Icon(Icons.tune, color: Color(0xFF7A5AF8)),
//                 //       onPressed: () {
//                 //         if (controller.isOpen) {
//                 //           controller.close();
//                 //         } else {
//                 //           controller.open();
//                 //         }
//                 //       },
//                 //     );
//                 //   },
//                 //   menuChildren: [
//                 //     MenuItemButton(
//                 //       onPressed: () {
//                 //         print("Price selected");
//                 //       },
//                 //       child: const Text("Price"),
//                 //     ),
//                 //     MenuItemButton(
//                 //       onPressed: () {
//                 //         print("Category selected");
//                 //       },
//                 //       child: const Text("Category"),
//                 //     ),
//                 //     MenuItemButton(
//                 //       onPressed: () {
//                 //         print("Rating selected");
//                 //       },
//                 //       child: const Text("Rating"),
//                 //     ),
//                 //     MenuItemButton(
//                 //       onPressed: () {
//                 //         print("Reset filters");
//                 //       },
//                 //       child: const Text("Reset Filters"),
//                 //     ),
//                 //   ],
//                 // ),
//                 filled: true,
//                 fillColor: Colors.white,
    
//                 contentPadding: const EdgeInsets.symmetric(vertical: 14),
    
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: const BorderSide(color: Color(0xFF7A5AF8)),
//                 ),
    
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: const BorderSide(color: Color(0xFF7A5AF8)),
//                 ),
    
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: const BorderSide(
//                     color: Color(0xFF7A5AF8),
//                     width: 2,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: Text(
//                 "Can't find what you are looking for?",
//                 style: TextStyle(fontSize: 12, color: Colors.black),
//               ),
//             ),
//             Center(
//               child: Text(
//                 "Try different keywords or remove some filters",
//                 style: TextStyle(fontSize: 10, color: Colors.grey),
//               ),
//             ),
//             SizedBox(height: 20),
    
//             Container(
//               margin: const EdgeInsets.all(6),
//               padding: const EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF2EEF8),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Filters",
//                         style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.grey,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
    
//                       InkWell(
//                         onTap: () {
//                           Get.find<FilterController>().clearAllFilters();
//                         },
//                         child: const Text(
//                           "Clear All",
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Color(0xFF7A5AF8),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
    
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: filterButton(
//                           icon: Icons.local_offer_outlined,
//                           title: "Category",
//                           options: const [
//                             "Electronics",
//                             "Fashion",
//                             "Furniture",
//                             "Groceries",
//                           ],
//                         ),
//                       ),
    
//                       const SizedBox(width: 5),
    
//                       Expanded(
//                         child: filterButton(
//                           icon: Icons.shopping_bag,
//                           title: "Brand",
//                           options: const [
//                             "Apple",
//                             "Samsung",
//                             "Nike",
//                             "Adidas",
//                           ],
//                         ),
//                       ),
    
//                       const SizedBox(width: 5),
    
//                       Expanded(
//                         child: filterButton(
//                           icon: Icons.attach_money,
//                           title: "Price",
//                           options: const [
//                             "Under Rs.500",
//                             "Rs.500 - 1000",
//                             "Rs.1000 - 5000",
//                             "Above Rs.5000",
//                           ],
//                         ),
//                       ),
    
//                       const SizedBox(width: 5),
    
//                       Expanded(
//                         child: filterButton(
//                           icon: Icons.star,
//                           title: "Rating",
//                           options: const ["5 ★", "4 ★ & Up", "3 ★ & Up"],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
    
//             SizedBox(height: 20),
    
//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: categories.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // 2 cards per row
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//                 childAspectRatio: 0.75,
//               ),
//               itemBuilder: (context, index) {
//                 return ProductCard(
//                   productTitle: categories[index]["productName"] as String,
//                   imageUrl: categories[index]["image"] as String,
//                   newPrice: categories[index]["currentPrice"] as String,
//                   oldPrice: categories[index]["oldPrice"] as String, productId: null,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/filter_controller.dart';
import 'package:shopease/models/category_model.dart';
import 'package:shopease/models/search_product_model.dart';
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
  State<SearchScreen> createState() =>
      _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  final ScrollController _scrollController =
      ScrollController();

  late final FilterController _filterController;

  Timer? _debounce;

  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _errorMessage;

  int _currentPage = 1;
  int _lastPage = 1;

  final Set<int> _favoriteProductIds = <int>{};

  final List<CategoryModel> _availableCategories = const [
    CategoryModel(id: 1, name: 'Electronics'),
    CategoryModel(id: 2, name: 'Fashion'),
    CategoryModel(id: 3, name: 'Grocery'),
    CategoryModel(id: 4, name: 'Sports'),
    CategoryModel(id: 5, name: 'Beauty'),
  ];

  final List<SearchProductModel> _products = [
    const SearchProductModel(
      id: 1,
      name: 'Wireless Headphones',
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e'
          '?auto=format&fit=crop&w=600&q=80',
      price: 10000,
      originalPrice: 12000,
    ),
    const SearchProductModel(
      id: 2,
      name: 'Running Shoes',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff'
          '?auto=format&fit=crop&w=600&q=80',
      price: 4200,
      originalPrice: 5500,
    ),
    const SearchProductModel(
      id: 3,
      name: 'Smart Watch',
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30'
          '?auto=format&fit=crop&w=600&q=80',
      price: 3500,
      originalPrice: 4300,
    ),
    const SearchProductModel(
      id: 4,
      name: 'Smartphone',
      imageUrl:
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9'
          '?auto=format&fit=crop&w=600&q=80',
      price: 31999,
      originalPrice: 35000,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _filterController = Get.put(
      FilterController(),
      tag: 'product-search-filter',
    );

    if (widget.initialCategoryId != null) {
      _filterController.selectCategory(
        id: widget.initialCategoryId,
        name: widget.initialCategoryName,
      );
    }

    _scrollController.addListener(_handlePagination);

    // Call _searchProducts() once the API service is ready.
  }

  void _handlePagination() {
    if (!_scrollController.hasClients ||
        _isLoadingMore ||
        _currentPage >= _lastPage) {
      return;
    }

    final position = _scrollController.position;

    if (position.pixels >=
        position.maxScrollExtent - 300) {
      _loadMoreProducts();
    }
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 450),
      () {
        _searchProducts();
      },
    );
  }

  Future<void> _searchProducts({
    bool resetPage = true,
  }) async {
    FocusScope.of(context).unfocus();

    if (resetPage) {
      _currentPage = 1;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final queryParameters =
          _filterController.buildQueryParameters(
        searchQuery: _searchController.text,
        page: _currentPage,
      );

      debugPrint(
        'GET /api/products query: $queryParameters',
      );

      // Backend:
      // GET /api/products
      //
      // queryParameters may contain:
      // q
      // category_id
      // min_price
      // max_price
      // page
      //
      // Paginated response:
      // response.data['data']['data']

      await Future<void>.delayed(
        const Duration(milliseconds: 500),
      );

      if (!mounted) return;

      // When connected:
      //
      // final pagination =
      //     response.data['data'] as Map<String, dynamic>;
      //
      // final items =
      //     pagination['data'] as List<dynamic>;
      //
      // final parsedProducts = items
      //     .whereType<Map<String, dynamic>>()
      //     .map(SearchProductModel.fromJson)
      //     .toList();
      //
      // setState(() {
      //   _products
      //     ..clear()
      //     ..addAll(parsedProducts);
      //
      //   _currentPage =
      //       pagination['current_page'] as int? ?? 1;
      //
      //   _lastPage =
      //       pagination['last_page'] as int? ?? 1;
      // });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            'Unable to search products. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadMoreProducts() async {
    if (_currentPage >= _lastPage) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final nextPage = _currentPage + 1;

      final queryParameters =
          _filterController.buildQueryParameters(
        searchQuery: _searchController.text,
        page: nextPage,
      );

      debugPrint(
        'GET /api/products query: $queryParameters',
      );

      // Fetch next page and append products.

      await Future<void>.delayed(
        const Duration(milliseconds: 500),
      );

      if (!mounted) return;

      setState(() {
        _currentPage = nextPage;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  Future<void> _showCategoryFilter() async {
    final selectedCategory =
        await showModalBottomSheet<CategoryModel?>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 16),
            children: [
              ListTile(
                leading: const Icon(
                  Icons.apps_rounded,
                ),
                title: const Text('All categories'),
                onTap: () {
                  Navigator.pop(context, null);
                },
              ),
              ..._availableCategories.map(
                (category) {
                  return ListTile(
                    leading: const Icon(
                      Icons.category_outlined,
                    ),
                    title: Text(category.name),
                    trailing:
                        _filterController
                                    .selectedCategoryId ==
                                category.id
                            ? const Icon(
                                Icons.check_rounded,
                              )
                            : null,
                    onTap: () {
                      Navigator.pop(
                        context,
                        category,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );

    if (!mounted) return;

    if (selectedCategory == null) {
      _filterController.clearCategory();
    } else {
      _filterController.selectCategory(
        id: selectedCategory.id,
        name: selectedCategory.name,
      );
    }

    _searchProducts();
  }

  Future<void> _showPriceFilter() async {
    final result =
        await showModalBottomSheet<_PriceFilterResult>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return _PriceFilterSheet(
          initialMinimum:
              _filterController.minimumPrice,
          initialMaximum:
              _filterController.maximumPrice,
        );
      },
    );

    if (result == null) return;

    _filterController.selectPriceRange(
      minimum: result.minimum,
      maximum: result.maximum,
    );

    _searchProducts();
  }

  void _clearAllFilters() {
    _filterController.clearAllFilters();
    _searchProducts();
  }

  void _toggleFavorite(int productId) {
    setState(() {
      if (_favoriteProductIds.contains(productId)) {
        _favoriteProductIds.remove(productId);

        // DELETE /api/wishlist/$productId
      } else {
        _favoriteProductIds.add(productId);

        // POST /api/wishlist/add/$productId
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _scrollController.dispose();

    if (Get.isRegistered<FilterController>(
      tag: 'product-search-filter',
    )) {
      Get.delete<FilterController>(
        tag: 'product-search-filter',
      );
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.scaffoldBackgroundColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
        title: Text(
          'Search',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final horizontalPadding = switch (width) {
              < 360 => 14.0,
              < 700 => 18.0,
              < 1100 => 32.0,
              _ => 48.0,
            };

            final crossAxisCount = switch (width) {
              < 650 => 2,
              < 950 => 3,
              _ => 4,
            };

            return CustomScrollView(
              controller: _scrollController,
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    12,
                    horizontalPadding,
                    110,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 1200,
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _searchController,
                              autofocus:
                                  widget.initialCategoryId ==
                                      null,
                              textInputAction:
                                  TextInputAction.search,
                              onChanged: _onSearchChanged,
                              onSubmitted: (_) {
                                _searchProducts();
                              },
                              decoration: InputDecoration(
                                hintText: 'Search products',
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                ),
                                suffixIcon:
                                    _searchController.text.isEmpty
                                        ? null
                                        : IconButton(
                                            onPressed: () {
                                              _searchController
                                                  .clear();

                                              setState(() {});

                                              _searchProducts();
                                            },
                                            icon: const Icon(
                                              Icons.close_rounded,
                                            ),
                                          ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            GetBuilder<FilterController>(
                              tag: 'product-search-filter',
                              builder: (controller) {
                                return Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: theme
                                        .colorScheme
                                        .surfaceContainerHighest,
                                    borderRadius:
                                        BorderRadius.circular(18),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Filters',
                                            style: theme
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight:
                                                      FontWeight
                                                          .w700,
                                                ),
                                          ),
                                          const Spacer(),
                                          if (controller
                                              .hasActiveFilters)
                                            TextButton(
                                              onPressed:
                                                  _clearAllFilters,
                                              child: const Text(
                                                'Clear all',
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: [
                                          FilterButton(
                                            icon: Icons
                                                .category_outlined,
                                            title: controller
                                                    .selectedCategoryName ??
                                                'Category',
                                            isActive: controller
                                                    .selectedCategoryId !=
                                                null,
                                            onPressed:
                                                _showCategoryFilter,
                                          ),
                                          FilterButton(
                                            icon: Icons
                                                .payments_outlined,
                                            title: controller
                                                        .minimumPrice !=
                                                    null ||
                                                controller
                                                        .maximumPrice !=
                                                    null
                                                ? _priceFilterLabel(
                                                    controller,
                                                  )
                                                : 'Price',
                                            isActive: controller
                                                        .minimumPrice !=
                                                    null ||
                                                controller
                                                        .maximumPrice !=
                                                    null,
                                            onPressed:
                                                _showPriceFilter,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 22),
                            if (_isLoading)
                              const SizedBox(
                                height: 300,
                                child: Center(
                                  child:
                                      CircularProgressIndicator(),
                                ),
                              )
                            else if (_errorMessage != null)
                              _SearchErrorState(
                                message: _errorMessage!,
                                onRetry: _searchProducts,
                              )
                            else if (_products.isEmpty)
                              const _EmptySearchState()
                            else
                              GridView.builder(
                                shrinkWrap: true,
                                physics:
                                    const NeverScrollableScrollPhysics(),
                                itemCount: _products.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          crossAxisCount,
                                      crossAxisSpacing: 14,
                                      mainAxisSpacing: 16,
                                      childAspectRatio:
                                          width < 400
                                              ? 0.62
                                              : 0.68,
                                    ),
                                itemBuilder: (context, index) {
                                  final product =
                                      _products[index];

                                  return ProductCard(
                                    productId: product.id,
                                    productTitle:
                                        product.name,
                                    imageUrl:
                                        product.imageUrl,
                                    newPrice: _formatPrice(
                                      product.price,
                                    ),
                                    oldPrice:
                                        product.originalPrice ==
                                                null
                                            ? null
                                            : _formatPrice(
                                                product
                                                    .originalPrice!,
                                              ),
                                    isFavorite:
                                        _favoriteProductIds
                                            .contains(
                                              product.id,
                                            ),
                                    onTap: () {
                                      Get.to(
                                        () => ProductDetail(
                                          productId:
                                              product.id,
                                        ),
                                      );
                                    },
                                    onFavoritePressed: () {
                                      _toggleFavorite(
                                        product.id,
                                      );
                                    },
                                  );
                                },
                              ),
                            if (_isLoadingMore)
                              const Padding(
                                padding:
                                    EdgeInsets.all(24),
                                child: Center(
                                  child:
                                      CircularProgressIndicator(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _priceFilterLabel(
    FilterController controller,
  ) {
    final min = controller.minimumPrice;
    final max = controller.maximumPrice;

    if (min != null && max != null) {
      return 'Rs. ${min.toInt()}–${max.toInt()}';
    }

    if (min != null) {
      return 'Above Rs. ${min.toInt()}';
    }

    if (max != null) {
      return 'Under Rs. ${max.toInt()}';
    }

    return 'Price';
  }

  String _formatPrice(num price) {
    return price.toStringAsFixed(
      price % 1 == 0 ? 0 : 2,
    );
  }
}

class _PriceFilterSheet extends StatefulWidget {
  final double? initialMinimum;
  final double? initialMaximum;

  const _PriceFilterSheet({
    this.initialMinimum,
    this.initialMaximum,
  });

  @override
  State<_PriceFilterSheet> createState() =>
      _PriceFilterSheetState();
}

class _PriceFilterSheetState
    extends State<_PriceFilterSheet> {
  late final TextEditingController _minimumController;
  late final TextEditingController _maximumController;

  @override
  void initState() {
    super.initState();

    _minimumController = TextEditingController(
      text: widget.initialMinimum?.toStringAsFixed(0) ?? '',
    );

    _maximumController = TextEditingController(
      text: widget.initialMaximum?.toStringAsFixed(0) ?? '',
    );
  }

  @override
  void dispose() {
    _minimumController.dispose();
    _maximumController.dispose();
    super.dispose();
  }

  void _apply() {
    final minimum = double.tryParse(
      _minimumController.text.trim(),
    );

    final maximum = double.tryParse(
      _maximumController.text.trim(),
    );

    if (minimum != null &&
        maximum != null &&
        minimum > maximum) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Minimum price cannot exceed maximum price',
          ),
        ),
      );

      return;
    }

    Navigator.pop(
      context,
      _PriceFilterResult(
        minimum: minimum,
        maximum: maximum,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight =
        MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        8,
        20,
        keyboardHeight + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          Text(
            'Price range',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _minimumController,
                  keyboardType:
                      const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Minimum',
                    prefixText: 'Rs. ',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _maximumController,
                  keyboardType:
                      const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Maximum',
                    prefixText: 'Rs. ',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _apply,
            child: const Text('Apply filter'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(
                context,
                const _PriceFilterResult(),
              );
            },
            child: const Text('Clear price filter'),
          ),
        ],
      ),
    );
  }
}

class _PriceFilterResult {
  final double? minimum;
  final double? maximum;

  const _PriceFilterResult({
    this.minimum,
    this.maximum,
  });
}

class _SearchErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _SearchErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 60,
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 56,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptySearchState extends StatelessWidget {
  const _EmptySearchState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 70),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.manage_search_rounded,
              size: 64,
            ),
            SizedBox(height: 14),
            Text(
              'No products found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Try another keyword or remove a filter.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}