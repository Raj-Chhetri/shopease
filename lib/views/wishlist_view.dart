// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:shopease/views/product_detail.dart';
// import 'package:shopease/widgets/wishlist_card.dart';

// class Wishlistview extends StatefulWidget {
//   const Wishlistview({super.key});

//   @override
//   State<Wishlistview> createState() => _WishlistviewState();
// }

// class _WishlistviewState extends State<Wishlistview> {
//   final List<String> categories = [
//     "All",
//     "Shoes",
//     "Electronics",
//     "Fashion",
//     "Sports",
//     "Accessories",
//     "Home",
//     "Beauty",
//   ];

//   int selectedCategory = 0;
//   final List<Map<String, dynamic>> wishlist = [
//     {
//       "image":
//           "https://www.bing.com/th/id/OIP.P3Y-J0w1E9u1aFk-Ok-LxgHaHb?w=193&h=194&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
//       "name": "Nike Sneakers",
//       "price": "Rs. 10,000",
//       "oldPrice": "Rs. 12,000",
//       "isFavorite": true,
//     },
//     {
//       "image":
//           "https://www.bing.com/th/id/OIP.Sjb_xI-Mh0fAgfu7zuD_eQHaHa?w=193&h=193&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
//       "name": "Washing Machine",
//       "price": "Rs. 8,500",
//       "oldPrice": "Rs. 9,999",
//       "isFavorite": true,
//     },
//     {
//       "image":
//           "https://www.bing.com/th/id/OIP.EZwrgPYPlEvi4LmWsiMdGgHaHa?w=193&h=193&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
//       "name": "A Grade Jersey",
//       "price": "Rs. 7,200",
//       "oldPrice": "Rs. 8,000",
//       "isFavorite": true,
//     },
//     {
//       "image":
//           "https://th.bing.com/th/id/OIP.-mlXrJBHBDf1TqFWd99xDQHaHb?w=141&h=150&c=6&o=7&dpr=1.3&pid=1.7&rm=3",
//       "name": "Water bottle",
//       "price": "Rs. 9,300",
//       "oldPrice": "Rs. 10,500",
//       "isFavorite": true,
//     },
//     {
//       "image":
//           "https://www.bing.com/th/id/OIP.18tc32s6GkPnZv3ENmHEfAHaHa?w=193&h=193&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
//       "name": "Smart Watch",
//       "price": "Rs. 7,800",
//       "oldPrice": "Rs. 9,200",
//       "isFavorite": true,
//     },
//     {
//       "image":
//           "https://www.bing.com/th/id/OIP.3trQnx1qoS6Rdm9jAJRacQHaId?w=193&h=221&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
//       "name": "Wireless Headphones",
//       "price": "Rs. 5,499",
//       "oldPrice": "Rs. 6,499",
//       "isFavorite": true,
//     },
//     {
//       "image":
//           "https://www.bing.com/th/id/OIP.sMAKo4GpcazOqITP2h6VcAHaIo?w=193&h=225&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
//       "name": "Backpack",
//       "price": "Rs. 2,199",
//       "oldPrice": "Rs. 2,999",
//       "isFavorite": true,
//     },
//     {
//       "image":
//           "https://www.bing.com/th/id/OIP.PhV5SpzcvUFjD5p9kcw_PQHaHa?w=193&h=193&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
//       "name": "Running Shoes",
//       "price": "Rs. 6,999",
//       "oldPrice": "Rs. 8,499",
//       "isFavorite": true,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//         ),
//         title: const Text(
//           "My Wishlist",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 55,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 final bool isSelected = selectedCategory == index;

//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedCategory = index;
//                     });
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.only(right: 10, top: 8, bottom: 8),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? const Color.fromARGB(255, 0, 0, 0)
//                           : const Color.fromARGB(255, 242, 237, 237),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     child: Center(
//                       child: Text(
//                         categories[index],
//                         style: TextStyle(
//                           color: isSelected ? Colors.white : Colors.black87,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: wishlist.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 20,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 0.90,
//               ),
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Get.to(() => ProductDetail());
//                   },
//                   child: WishlistCard(
//                     imageUrl: wishlist[index]["image"],
//                     productName: wishlist[index]["name"],
//                     currentPrice: wishlist[index]["price"],
//                     oldPrice: wishlist[index]["oldPrice"],
//                     isFavorite: wishlist[index]["isFavorite"],
//                     onFavoriteTap: () {
//                       setState(() {
//                         wishlist[index]["isFavorite"] =
//                             !wishlist[index]["isFavorite"];

//                         if (!wishlist[index]["isFavorite"]) {
//                           wishlist.removeAt(index);
//                         }
//                       });
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),

//           Gap(80),
//         ],
//       ),

//       // buttom navigation bar added by Pankaj,

//       // navigation bar ends here
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/models/wishlist_item_model.dart';
import 'package:shopease/views/product_detail.dart';
import 'package:shopease/widgets/wishlist_card.dart';

class Wishlistview extends StatefulWidget {

  final bool showBackButton;

  const Wishlistview({
    super.key,
    this.showBackButton = false,
  });

  @override
  State<Wishlistview> createState() => _WishlistviewState();
}

class _WishlistviewState extends State<Wishlistview> {
  static const Color _primaryColor = Color(0xFF6D28FF);

  bool _isLoading = false;
  String? _errorMessage;

  String _selectedCategory = 'All';

  final Set<int> _removingProductIds = <int>{};

  final List<WishlistItemModel> _wishlist = [
    const WishlistItemModel(
      productId: 1,
      productName: 'Nike Sneakers',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff'
          '?auto=format&fit=crop&w=600&q=80',
      currentPrice: 10000,
      oldPrice: 12000,
      categoryId: 1,
      categoryName: 'Shoes',
    ),
    const WishlistItemModel(
      productId: 2,
      productName: 'Washing Machine',
      imageUrl:
          'https://images.unsplash.com/photo-1626806787461-102c1bfaaea1'
          '?auto=format&fit=crop&w=600&q=80',
      currentPrice: 8500,
      oldPrice: 9999,
      categoryId: 2,
      categoryName: 'Electronics',
    ),
    const WishlistItemModel(
      productId: 3,
      productName: 'A Grade Jersey',
      imageUrl:
          'https://images.unsplash.com/photo-1579952363873-27f3bade9f55'
          '?auto=format&fit=crop&w=600&q=80',
      currentPrice: 7200,
      oldPrice: 8000,
      categoryId: 3,
      categoryName: 'Sports',
    ),
    const WishlistItemModel(
      productId: 4,
      productName: 'Smart Watch',
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30'
          '?auto=format&fit=crop&w=600&q=80',
      currentPrice: 7800,
      oldPrice: 9200,
      categoryId: 2,
      categoryName: 'Electronics',
    ),
    const WishlistItemModel(
      productId: 5,
      productName: 'Wireless Headphones',
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e'
          '?auto=format&fit=crop&w=600&q=80',
      currentPrice: 5499,
      oldPrice: 6499,
      categoryId: 2,
      categoryName: 'Electronics',
    ),
    const WishlistItemModel(
      productId: 6,
      productName: 'Backpack',
      imageUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62'
          '?auto=format&fit=crop&w=600&q=80',
      currentPrice: 2199,
      oldPrice: 2999,
      categoryId: 4,
      categoryName: 'Accessories',
    ),
  ];

  List<String> get _categories {
    final categoryNames = _wishlist
        .map((item) => item.categoryName)
        .where((name) => name.trim().isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    return [
      'All',
      ...categoryNames,
    ];
  }

  List<WishlistItemModel> get _visibleWishlist {
    if (_selectedCategory == 'All') {
      return List.unmodifiable(_wishlist);
    }

    return _wishlist
        .where(
          (item) =>
              item.categoryName == _selectedCategory,
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();

    // Call _loadWishlist() when the API service is ready.
  }

  Future<void> _loadWishlist() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Backend:
      // GET /api/wishlist
      //
      // final response = await wishlistService.getWishlist();
      // final responseData = response.data['data'];
      //
      // The returned list might be directly in data or
      // inside data['data'], depending on pagination.
      //
      // final rawItems = responseData is List
      //     ? responseData
      //     : responseData['data'] as List<dynamic>;
      //
      // final items = rawItems
      //     .whereType<Map<String, dynamic>>()
      //     .map(WishlistItemModel.fromJson)
      //     .toList();
      //
      // setState(() {
      //   _wishlist
      //     ..clear()
      //     ..addAll(items);
      // });

      await Future<void>.delayed(
        const Duration(milliseconds: 500),
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            'Unable to load your wishlist. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _removeFromWishlist(
    WishlistItemModel item,
  ) async {
    if (_removingProductIds.contains(item.productId)) {
      return;
    }

    setState(() {
      _removingProductIds.add(item.productId);
    });

    try {
      // Backend:
      // DELETE /api/wishlist/${item.productId}

      await Future<void>.delayed(
        const Duration(milliseconds: 400),
      );

      if (!mounted) return;

      setState(() {
        _wishlist.removeWhere(
          (wishlistItem) =>
              wishlistItem.productId == item.productId,
        );

        _removingProductIds.remove(item.productId);

        if (_selectedCategory != 'All' &&
            !_wishlist.any(
              (wishlistItem) =>
                  wishlistItem.categoryName ==
                  _selectedCategory,
            )) {
          _selectedCategory = 'All';
        }
      });

      Get.snackbar(
        'Removed from wishlist',
        '${item.productName} was removed.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _removingProductIds.remove(item.productId);
      });

      Get.snackbar(
        'Unable to remove product',
        'Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  void _openProduct(WishlistItemModel item) {
    Get.to(
      () => ProductDetail(
        productId: item.productId,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibleItems = _visibleWishlist;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        leading: widget.showBackButton
            ? IconButton(
                onPressed: Get.back,
                tooltip: 'Back',
                icon: const Icon(
                  Icons.arrow_back_rounded,
                ),
              )
            : null,

        title: Text(
          'My Wishlist',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _errorMessage != null
                ? _WishlistErrorState(
                    message: _errorMessage!,
                    onRetry: _loadWishlist,
                  )
                : Column(
                    children: [
                      if (_wishlist.isNotEmpty)
                        SizedBox(
                          height: 58,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            itemCount: _categories.length,
                            separatorBuilder: (_, __) {
                              return const SizedBox(width: 9);
                            },
                            itemBuilder: (context, index) {
                              final category =
                                  _categories[index];

                              final isSelected =
                                  category ==
                                  _selectedCategory;

                              return ChoiceChip(
                                label: Text(category),
                                selected: isSelected,
                                onSelected: (_) {
                                  setState(() {
                                    _selectedCategory =
                                        category;
                                  });
                                },
                                selectedColor:
                                    theme.colorScheme.primary,
                                backgroundColor: theme
                                    .colorScheme
                                    .surfaceContainerHighest,
                                side: BorderSide.none,
                                labelStyle: TextStyle(
                                  color: isSelected
                                      ? theme.colorScheme.onPrimary
                                      : theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ),
                      Expanded(
                        child: visibleItems.isEmpty
                            ? _EmptyWishlistState(
                                hasWishlistItems:
                                    _wishlist.isNotEmpty,
                                onClearFilter: () {
                                  setState(() {
                                    _selectedCategory = 'All';
                                  });
                                },
                                onRefresh: _loadWishlist,
                              )
                            : RefreshIndicator(
                                onRefresh: _loadWishlist,
                                child: LayoutBuilder(
                                  builder: (
                                    context,
                                    constraints,
                                  ) {
                                    final width =
                                        constraints.maxWidth;

                                    final horizontalPadding =
                                        width < 700
                                            ? 14.0
                                            : 32.0;

                                    final crossAxisCount =
                                        switch (width) {
                                      < 650 => 2,
                                      < 950 => 3,
                                      _ => 4,
                                    };

                                    return GridView.builder(
                                      padding: EdgeInsets.fromLTRB(
                                        horizontalPadding,
                                        10,
                                        horizontalPadding,
                                        110,
                                      ),
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemCount:
                                          visibleItems.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            crossAxisCount,
                                        crossAxisSpacing: 14,
                                        mainAxisSpacing: 16,
                                        childAspectRatio:
                                            width < 380
                                                ? 0.64
                                                : 0.70,
                                      ),
                                      itemBuilder: (
                                        context,
                                        index,
                                      ) {
                                        final item =
                                            visibleItems[index];

                                        return WishlistCard(
                                          imageUrl:
                                              item.imageUrl,
                                          productName:
                                              item.productName,
                                          currentPrice:
                                              item.currentPrice,
                                          oldPrice:
                                              item.oldPrice,
                                          isRemoving:
                                              _removingProductIds
                                                  .contains(
                                            item.productId,
                                          ),
                                          onTap: () {
                                            _openProduct(item);
                                          },
                                          onFavoriteTap: () {
                                            _removeFromWishlist(
                                              item,
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
      ),
    );
  }
}

class _WishlistErrorState extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const _WishlistErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRetry,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 150),
          Icon(
            Icons.cloud_off_rounded,
            size: 62,
            color: Theme.of(context)
                .colorScheme
                .onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          Center(
            child: FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try again'),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyWishlistState extends StatelessWidget {
  final bool hasWishlistItems;
  final VoidCallback onClearFilter;
  final Future<void> Function() onRefresh;

  const _EmptyWishlistState({
    required this.hasWishlistItems,
    required this.onClearFilter,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        children: [
          const SizedBox(height: 120),
          Icon(
            hasWishlistItems
                ? Icons.filter_alt_off_outlined
                : Icons.favorite_border_rounded,
            size: 72,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 18),
          Text(
            hasWishlistItems
                ? 'No products in this category'
                : 'Your wishlist is empty',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            hasWishlistItems
                ? 'Choose another category to view your saved products.'
                : 'Products you save will appear here.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (hasWishlistItems) ...[
            const SizedBox(height: 20),
            Center(
              child: OutlinedButton(
                onPressed: onClearFilter,
                child: const Text('Show all'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
