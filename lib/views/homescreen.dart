// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shopease/controller/app_controller.dart';
// import 'package:shopease/theme/app_theme.dart';
// import 'package:shopease/views/product_detail.dart';
// import 'package:shopease/widgets/featured_card.dart';
// import 'package:shopease/widgets/fillUp_widget.dart';
// import 'package:shopease/widgets/product_card.dart';
// import 'package:shopease/widgets/tags_widget.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final PageController _featuredPageController = PageController(
//     viewportFraction: 0.9,
//   );

//   Timer? _carouselTimer;
//   int _currentFeaturedPage = 0;
//   int _selectedCategoryIndex = 0;
//   final Set<int> _favoriteProductIds = <int>{};

//   final List<_CategoryItem> _categories = const [
//     _CategoryItem(
//       id: null,
//       label: 'All',
//       icon: Icons.travel_explore_rounded,
//     ),
//     _CategoryItem(
//       id: 1,
//       label: 'Fashion',
//       icon: Icons.checkroom_rounded,
//     ),
//     _CategoryItem(
//       id: 2,
//       label: 'Wearables',
//       icon: Icons.watch_rounded,
//     ),
//     _CategoryItem(
//       id: 3,
//       label: 'Shoes',
//       icon: Icons.directions_run_rounded,
//     ),
//     _CategoryItem(
//       id: 4,
//       label: 'Smartphones',
//       icon: Icons.smartphone_rounded,
//     ),
//   ];

//   final List<_FeaturedItem> _featuredItems = const [
//     _FeaturedItem(
//       productId: 1,
//       imageUrl:
//           'https://images.unsplash.com/photo-1505740420928-5e560c06d30e'
//           '?auto=format&fit=crop&w=1200&q=80',
//       title: 'Premium Headphones',
//       subtitle: 'Clear sound, comfortable design',
//     ),
//     _FeaturedItem(
//       productId: 2,
//       imageUrl:
//           'https://images.unsplash.com/photo-1542291026-7eec264c27ff'
//           '?auto=format&fit=crop&w=1200&q=80',
//       title: 'Running Shoes',
//       subtitle: 'Built for comfort and performance',
//     ),
//     _FeaturedItem(
//       productId: 3,
//       imageUrl:
//           'https://images.unsplash.com/photo-1523275335684-37898b6baf30'
//           '?auto=format&fit=crop&w=1200&q=80',
//       title: 'Smart Wearables',
//       subtitle: 'Stay connected throughout your day',
//     ),
//   ];

//   final List<_HomeProduct> _topPicks = const [
//     _HomeProduct(
//       id: 1,
//       title: 'Wireless Headphones',
//       imageUrl:
//           'https://images.unsplash.com/photo-1505740420928-5e560c06d30e'
//           '?auto=format&fit=crop&w=600&q=80',
//       oldPrice: '1700',
//       newPrice: '1200',
//     ),
//     _HomeProduct(
//       id: 2,
//       title: 'Running Shoes',
//       imageUrl:
//           'https://images.unsplash.com/photo-1542291026-7eec264c27ff'
//           '?auto=format&fit=crop&w=600&q=80',
//       oldPrice: '5500',
//       newPrice: '4200',
//     ),
//     _HomeProduct(
//       id: 3,
//       title: 'Smart Watch',
//       imageUrl:
//           'https://images.unsplash.com/photo-1523275335684-37898b6baf30'
//           '?auto=format&fit=crop&w=600&q=80',
//       oldPrice: '4300',
//       newPrice: '3500',
//     ),
//     _HomeProduct(
//       id: 4,
//       title: 'Smartphone',
//       imageUrl:
//           'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9'
//           '?auto=format&fit=crop&w=600&q=80',
//       oldPrice: '35000',
//       newPrice: '31999',
//     ),
//   ];

//   final List<_HomeProduct> _forYouProducts = const [
//     _HomeProduct(
//       id: 5,
//       title: 'Classic Sneakers',
//       imageUrl:
//           'https://images.unsplash.com/photo-1549298916-b41d501d3772'
//           '?auto=format&fit=crop&w=600&q=80',
//       oldPrice: '4200',
//       newPrice: '3499',
//     ),
//     _HomeProduct(
//       id: 6,
//       title: 'Premium Headset',
//       imageUrl:
//           'https://images.unsplash.com/photo-1583394838336-acd977736f90'
//           '?auto=format&fit=crop&w=600&q=80',
//       oldPrice: '6800',
//       newPrice: '5799',
//     ),
//     _HomeProduct(
//       id: 7,
//       title: 'Smart Watch',
//       imageUrl:
//           'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3'
//           '?auto=format&fit=crop&w=600&q=80',
//       oldPrice: '5200',
//       newPrice: '4499',
//     ),
//     _HomeProduct(
//       id: 8,
//       title: 'Travel Backpack',
//       imageUrl:
//           'https://images.unsplash.com/photo-1553062407-98eeb64c6a62'
//           '?auto=format&fit=crop&w=600&q=80',
//       oldPrice: '3600',
//       newPrice: '2999',
//     ),
//     _HomeProduct(
//       id: 9,
//       title: 'Casual Shirt',
//       imageUrl:
//           'https://images.unsplash.com/photo-1603252109303-2751441dd157'
//           '?auto=format&fit=crop&w=600&q=80',
//       oldPrice: '2500',
//       newPrice: '1999',
//     ),
//     _HomeProduct(
//       id: 10,
//       title: 'Smartphone',
//       imageUrl:
//           'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9'
//           '?auto=format&fit=crop&w=600&q=80',
//       oldPrice: '45000',
//       newPrice: '41999',
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _carouselTimer = Timer.periodic(
//       const Duration(seconds: 4),
//       (_) => _moveToNextFeaturedPage(),
//     );
//   }

//   void _moveToNextFeaturedPage() {
//     if (!_featuredPageController.hasClients || _featuredItems.length < 2) {
//       return;
//     }

//     final nextPage = (_currentFeaturedPage + 1) % _featuredItems.length;

//     _featuredPageController.animateToPage(
//       nextPage,
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeInOutCubic,
//     );
//   }

//   void _toggleTheme() {
//     if (Get.isRegistered<AppController>()) {
//       Get.find<AppController>().toggleTheme();
//       return;
//     }

//     Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
//   }

//   void _openProductDetails(int productId) {
//     Get.to(
//       () => ProductDetail(productId: productId),
//       transition: Transition.rightToLeft,
//       duration: const Duration(milliseconds: 250),
//     );
//   }

//   void _toggleFavorite(int productId) {
//     setState(() {
//       if (!_favoriteProductIds.add(productId)) {
//         _favoriteProductIds.remove(productId);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _carouselTimer?.cancel();
//     _featuredPageController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final width = MediaQuery.sizeOf(context).width;
//     final horizontalPadding = switch (width) {
//       < 360 => 14.0,
//       < 700 => 18.0,
//       < 1100 => 32.0,
//       _ => 48.0,
//     };

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       body: SafeArea(
//         bottom: false,
//         child: CustomScrollView(
//           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//           physics: const BouncingScrollPhysics(),
//           slivers: [
//             SliverPadding(
//               padding: EdgeInsets.fromLTRB(
//                 horizontalPadding,
//                 14,
//                 horizontalPadding,
//                 118,
//               ),
//               sliver: SliverToBoxAdapter(
//                 child: Center(
//                   child: ConstrainedBox(
//                     constraints: const BoxConstraints(maxWidth: 1200),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _HomeHeader(
//                           userName: 'Mahesh',
//                           isDarkMode: theme.brightness == Brightness.dark,
//                           onThemePressed: _toggleTheme,
//                         ),
//                         const SizedBox(height: 22),
//                         FillupWidget(
//                           hintText: 'Search products',
//                           icon: Icons.search_rounded,
//                           keyboardType: TextInputType.text,
//                           controller: _searchController,
//                           textInputAction: TextInputAction.search,
//                           onSubmitted: (_) {},
//                           onClear: _searchController.clear,
//                         ),
//                         const SizedBox(height: 18),
//                         SizedBox(
//                           height: 48,
//                           child: ListView.separated(
//                             scrollDirection: Axis.horizontal,
//                             physics: const BouncingScrollPhysics(),
//                             itemCount: _categories.length,
//                             separatorBuilder: (_, __) =>
//                                 const SizedBox(width: 10),
//                             itemBuilder: (context, index) {
//                               final category = _categories[index];

//                               return TagsWidget(
//                                 label: category.label,
//                                 icon: category.icon,
//                                 isSelected: index == _selectedCategoryIndex,
//                                 onPressed: () {
//                                   setState(() {
//                                     _selectedCategoryIndex = index;
//                                   });
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 28),
//                         const _SectionTitle(
//                           title: 'Featured',
//                           icon: CupertinoIcons.flame_fill,
//                           iconColor: Color(0xFFFF7300),
//                         ),
//                         const SizedBox(height: 14),
//                         _FeaturedCarousel(
//                           controller: _featuredPageController,
//                           items: _featuredItems,
//                           currentPage: _currentFeaturedPage,
//                           onPageChanged: (index) {
//                             setState(() {
//                               _currentFeaturedPage = index;
//                             });
//                           },
//                           onProductPressed: _openProductDetails,
//                         ),
//                         const SizedBox(height: 30),
//                         const _SectionTitle(
//                           title: 'Top Picks',
//                           icon: CupertinoIcons.heart_fill,
//                           iconColor: Colors.redAccent,
//                         ),
//                         const SizedBox(height: 14),
//                         SizedBox(
//                           height: width < 360 ? 270 : 290,
//                           child: ListView.separated(
//                             scrollDirection: Axis.horizontal,
//                             physics: const BouncingScrollPhysics(),
//                             itemCount: _topPicks.length,
//                             separatorBuilder: (_, __) =>
//                                 const SizedBox(width: 14),
//                             itemBuilder: (context, index) {
//                               final product = _topPicks[index];

//                               return SizedBox(
//                                 width: width < 420 ? 170 : 195,
//                                 child: ProductCard(
//                                   productId: product.id,
//                                   imageUrl: product.imageUrl,
//                                   oldPrice: product.oldPrice,
//                                   newPrice: product.newPrice,
//                                   productTitle: product.title,
//                                   isFavorite: _favoriteProductIds.contains(
//                                     product.id,
//                                   ),
//                                   onTap: () =>
//                                       _openProductDetails(product.id),
//                                   onFavoritePressed: () =>
//                                       _toggleFavorite(product.id),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         const _SectionTitle(
//                           title: 'For You',
//                           icon: CupertinoIcons.bag_fill,
//                           iconColor: Color(0xFFFFB000),
//                         ),
//                         const SizedBox(height: 14),
//                         _ResponsiveProductGrid(
//                           products: _forYouProducts,
//                           availableWidth: width - (horizontalPadding * 2),
//                           favoriteProductIds: _favoriteProductIds,
//                           onProductPressed: _openProductDetails,
//                           onFavoritePressed: _toggleFavorite,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _HomeHeader extends StatelessWidget {
//   final String userName;
//   final bool isDarkMode;
//   final VoidCallback onThemePressed;

//   const _HomeHeader({
//     required this.userName,
//     required this.isDarkMode,
//     required this.onThemePressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Wrap(
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 children: [
//                   Text(
//                     'Welcome to ',
//                     style: theme.textTheme.bodyLarge?.copyWith(
//                       color: theme.colorScheme.onSurface,
//                       fontSize: 16,
//                     ),
//                   ),
//                   Text(
//                     'ShopEase!',
//                     style: GoogleFonts.itim(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: AppTheme.primary,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4),
//               Wrap(
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 children: [
//                   Text(
//                     'Hello, ',
//                     style: theme.textTheme.bodyLarge?.copyWith(
//                       color: theme.colorScheme.onSurface,
//                       fontSize: 16,
//                     ),
//                   ),
//                   Text(
//                     '$userName.',
//                     style: GoogleFonts.itim(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: AppTheme.primary,
//                     ),
//                   ),
//                   Text(
//                     ' Greetings!',
//                     style: theme.textTheme.bodyLarge?.copyWith(
//                       color: theme.colorScheme.onSurface,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 10),
//         Material(
//           color: theme.colorScheme.surfaceContainerHighest,
//           borderRadius: BorderRadius.circular(14),
//           child: IconButton(
//             onPressed: onThemePressed,
//             tooltip: isDarkMode ? 'Use light mode' : 'Use dark mode',
//             icon: Icon(
//               isDarkMode
//                   ? Icons.light_mode_rounded
//                   : Icons.dark_mode_rounded,
//               color: isDarkMode ? Colors.amber : AppTheme.primary,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _FeaturedCarousel extends StatelessWidget {
//   final PageController controller;
//   final List<_FeaturedItem> items;
//   final int currentPage;
//   final ValueChanged<int> onPageChanged;
//   final ValueChanged<int> onProductPressed;

//   const _FeaturedCarousel({
//     required this.controller,
//     required this.items,
//     required this.currentPage,
//     required this.onPageChanged,
//     required this.onProductPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 205,
//           child: PageView.builder(
//             controller: controller,
//             itemCount: items.length,
//             onPageChanged: onPageChanged,
//             physics: const BouncingScrollPhysics(),
//             itemBuilder: (context, index) {
//               final item = items[index];
//               final selected = index == currentPage;

//               return AnimatedPadding(
//                 duration: const Duration(milliseconds: 220),
//                 padding: EdgeInsets.only(
//                   right: 12,
//                   top: selected ? 0 : 7,
//                   bottom: selected ? 0 : 7,
//                 ),
//                 child: FeaturedCard(
//                   imageUrl: item.imageUrl,
//                   title: item.title,
//                   subtitle: item.subtitle,
//                   onTap: () => onProductPressed(item.productId),
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 12),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: List.generate(items.length, (index) {
//             final selected = index == currentPage;

//             return AnimatedContainer(
//               duration: const Duration(milliseconds: 220),
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               width: selected ? 22 : 8,
//               height: 8,
//               decoration: BoxDecoration(
//                 color: selected
//                     ? AppTheme.primary
//                     : Theme.of(context).colorScheme.outline,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }

// class _ResponsiveProductGrid extends StatelessWidget {
//   final List<_HomeProduct> products;
//   final double availableWidth;
//   final Set<int> favoriteProductIds;
//   final ValueChanged<int> onProductPressed;
//   final ValueChanged<int> onFavoritePressed;

//   const _ResponsiveProductGrid({
//     required this.products,
//     required this.availableWidth,
//     required this.favoriteProductIds,
//     required this.onProductPressed,
//     required this.onFavoritePressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final columns = availableWidth >= 1050
//         ? 4
//         : availableWidth >= 720
//             ? 3
//             : 2;
//     const spacing = 14.0;
//     final itemWidth =
//         (availableWidth - spacing * (columns - 1)) / columns;

//     return Wrap(
//       spacing: spacing,
//       runSpacing: 18,
//       children: products.map((product) {
//         return SizedBox(
//           width: itemWidth,
//           child: ProductCard(
//             productId: product.id,
//             imageUrl: product.imageUrl,
//             oldPrice: product.oldPrice,
//             newPrice: product.newPrice,
//             productTitle: product.title,
//             isFavorite: favoriteProductIds.contains(product.id),
//             onTap: () => onProductPressed(product.id),
//             onFavoritePressed: () => onFavoritePressed(product.id),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

// class _SectionTitle extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final Color iconColor;

//   const _SectionTitle({
//     required this.title,
//     required this.icon,
//     required this.iconColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final titleSize = MediaQuery.sizeOf(context).width < 360 ? 27.0 : 32.0;

//     return Row(
//       children: [
//         Flexible(
//           child: Text(
//             title,
//             overflow: TextOverflow.ellipsis,
//             style: theme.textTheme.headlineMedium?.copyWith(
//               color: theme.colorScheme.onSurface,
//               fontSize: titleSize,
//               height: 1.15,
//               fontWeight: FontWeight.w900,
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Icon(icon, color: iconColor, size: titleSize),
//       ],
//     );
//   }
// }

// class _CategoryItem {
//   final int? id;
//   final String label;
//   final IconData icon;

//   const _CategoryItem({
//     required this.id,
//     required this.label,
//     required this.icon,
//   });
// }

// class _FeaturedItem {
//   final int productId;
//   final String imageUrl;
//   final String title;
//   final String subtitle;

//   const _FeaturedItem({
//     required this.productId,
//     required this.imageUrl,
//     required this.title,
//     required this.subtitle,
//   });
// }

// class _HomeProduct {
//   final int id;
//   final String title;
//   final String imageUrl;
//   final String oldPrice;
//   final String newPrice;

//   const _HomeProduct({
//     required this.id,
//     required this.title,
//     required this.imageUrl,
//     required this.oldPrice,
//     required this.newPrice,
//   });
// }


import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopease/controller/app_controller.dart';
import 'package:shopease/theme/app_theme.dart';
import 'package:shopease/views/product_detail.dart';
import 'package:shopease/views/search_screen.dart';
import 'package:shopease/widgets/featured_card.dart';
import 'package:shopease/widgets/fillUp_widget.dart';
import 'package:shopease/widgets/product_card.dart';
import 'package:shopease/widgets/tags_widget.dart';

class HomeScreen
    extends
        StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<
    HomeScreen
  >
  createState() => _HomeScreenState();
}

class _HomeScreenState
    extends
        State<
          HomeScreen
        > {
  final TextEditingController _searchController = TextEditingController();
  final PageController _featuredPageController = PageController(
    viewportFraction: 0.9,
  );

  // Scroll controller for the whole page — used to detect when the user
  // nears the bottom so we can load the next page of "For You" products.
  final ScrollController _scrollController = ScrollController();

  Timer? _carouselTimer;
  int _currentFeaturedPage = 0;
  int _selectedCategoryIndex = 0;
  final Set<
    int
  >
  _favoriteProductIds =
      <
        int
      >{};

  final List<
    _CategoryItem
  >
  _categories = const [
    _CategoryItem(
      id: null,
      label: 'All',
      icon: Icons.travel_explore_rounded,
    ),
    _CategoryItem(
      id: 1,
      label: 'Fashion',
      icon: Icons.checkroom_rounded,
    ),
    _CategoryItem(
      id: 2,
      label: 'Wearables',
      icon: Icons.watch_rounded,
    ),
    _CategoryItem(
      id: 3,
      label: 'Shoes',
      icon: Icons.directions_run_rounded,
    ),
    _CategoryItem(
      id: 4,
      label: 'Smartphones',
      icon: Icons.smartphone_rounded,
    ),
  ];

  final List<
    _FeaturedItem
  >
  _featuredItems = const [
    _FeaturedItem(
      productId: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e'
          '?auto=format&fit=crop&w=1200&q=80',
      title: 'Premium Headphones',
      subtitle: 'Clear sound, comfortable design',
    ),
    _FeaturedItem(
      productId: 2,
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff'
          '?auto=format&fit=crop&w=1200&q=80',
      title: 'Running Shoes',
      subtitle: 'Built for comfort and performance',
    ),
    _FeaturedItem(
      productId: 3,
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30'
          '?auto=format&fit=crop&w=1200&q=80',
      title: 'Smart Wearables',
      subtitle: 'Stay connected throughout your day',
    ),
  ];

  final List<
    _HomeProduct
  >
  _topPicks = const [
    _HomeProduct(
      id: 1,
      title: 'Wireless Headphones',
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '1700',
      newPrice: '1200',
    ),
    _HomeProduct(
      id: 2,
      title: 'Running Shoes',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '5500',
      newPrice: '4200',
    ),
    _HomeProduct(
      id: 3,
      title: 'Smart Watch',
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '4300',
      newPrice: '3500',
    ),
    _HomeProduct(
      id: 4,
      title: 'Smartphone',
      imageUrl:
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '35000',
      newPrice: '31999',
    ),
  ];

  // ---------------------------------------------------------------------
  // "For You" section — this is the mock full dataset we paginate through.
  // In a real app, delete this and call your API with page/pageSize params
  // inside _loadMoreForYouProducts() below.
  // ---------------------------------------------------------------------
  final List<
    _HomeProduct
  >
  _allForYouProducts = const [
    _HomeProduct(
      id: 5,
      title: 'Classic Sneakers',
      imageUrl:
          'https://images.unsplash.com/photo-1549298916-b41d501d3772'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '4200',
      newPrice: '3499',
    ),
    _HomeProduct(
      id: 6,
      title: 'Premium Headset',
      imageUrl:
          'https://images.unsplash.com/photo-1583394838336-acd977736f90'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '6800',
      newPrice: '5799',
    ),
    _HomeProduct(
      id: 7,
      title: 'Smart Watch',
      imageUrl:
          'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '5200',
      newPrice: '4499',
    ),
    _HomeProduct(
      id: 8,
      title: 'Travel Backpack',
      imageUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '3600',
      newPrice: '2999',
    ),
    _HomeProduct(
      id: 9,
      title: 'Casual Shirt',
      imageUrl:
          'https://images.unsplash.com/photo-1603252109303-2751441dd157'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '2500',
      newPrice: '1999',
    ),
    _HomeProduct(
      id: 10,
      title: 'Smartphone',
      imageUrl:
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '45000',
      newPrice: '41999',
    ),
    // --- extra mock items so pagination has more than one page to show ---
    _HomeProduct(
      id: 11,
      title: 'Leather Wallet',
      imageUrl:
          'https://images.unsplash.com/photo-1627123424574-724758594e93'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '1800',
      newPrice: '1399',
    ),
    _HomeProduct(
      id: 12,
      title: 'Sunglasses',
      imageUrl:
          'https://images.unsplash.com/photo-1572635196237-14b3f281503f'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '2200',
      newPrice: '1699',
    ),
    _HomeProduct(
      id: 13,
      title: 'Denim Jacket',
      imageUrl:
          'https://images.unsplash.com/photo-1551028719-00167b16eac5'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '4800',
      newPrice: '3999',
    ),
    _HomeProduct(
      id: 14,
      title: 'Bluetooth Speaker',
      imageUrl:
          'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '3200',
      newPrice: '2599',
    ),
    _HomeProduct(
      id: 15,
      title: 'Formal Shoes',
      imageUrl:
          'https://images.unsplash.com/photo-1614252369475-531eba835eb1'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '5200',
      newPrice: '4299',
    ),
    _HomeProduct(
      id: 16,
      title: 'Fitness Tracker',
      imageUrl:
          'https://images.unsplash.com/photo-1576243345690-4e4b79b63288'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '3900',
      newPrice: '2999',
    ),
  ];

  // Products currently visible in the "For You" grid.
  final List<
    _HomeProduct
  >
  _forYouProducts = [];

  int _forYouPage = 1;
  final int _forYouPageSize = 6;
  bool _isLoadingMoreForYou = false;
  bool _hasMoreForYou = true;

  @override
  void initState() {
    super.initState();
    _carouselTimer = Timer.periodic(
      const Duration(
        seconds: 5,
      ),
      (
        _,
      ) => _moveToNextFeaturedPage(),
    );

    _loadMoreForYouProducts(); // load the first page on start
    _scrollController.addListener(
      _onScroll,
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final nearBottom =
        _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent -
            300;

    if (nearBottom &&
        !_isLoadingMoreForYou &&
        _hasMoreForYou) {
      _loadMoreForYouProducts();
    }
  }

  Future<
    void
  >
  _loadMoreForYouProducts() async {
    setState(
      () => _isLoadingMoreForYou = true,
    );

    // -----------------------------------------------------------------
    // This block will be replaced with a real API call, e.g.:
    //
    // final newProducts = await ProductApi.fetchForYou(
    //   page: _forYouPage,
    //   pageSize: _forYouPageSize,
    // );
    // -----------------------------------------------------------------
    await Future.delayed(
      const Duration(
        milliseconds: 700,
      ),
    );

    final start =
        (_forYouPage -
            1) *
        _forYouPageSize;
    final end =
        (start +
                _forYouPageSize)
            .clamp(
              0,
              _allForYouProducts.length,
            );
    final newProducts =
        start <
            _allForYouProducts.length
        ? _allForYouProducts.sublist(
            start,
            end,
          )
        : <
            _HomeProduct
          >[];

    if (!mounted) return;

    setState(
      () {
        _forYouProducts.addAll(
          newProducts,
        );
        _forYouPage++;
        _hasMoreForYou =
            newProducts.length ==
            _forYouPageSize;
        _isLoadingMoreForYou = false;
      },
    );
  }

  Future<
    void
  >
  _refreshForYouProducts() async {
    setState(
      () {
        _forYouProducts.clear();
        _forYouPage = 1;
        _hasMoreForYou = true;
      },
    );
    await _loadMoreForYouProducts();
  }

  void _moveToNextFeaturedPage() {
    if (!_featuredPageController.hasClients ||
        _featuredItems.length <
            2) {
      return;
    }

    final nextPage =
        (_currentFeaturedPage +
            1) %
        _featuredItems.length;

    _featuredPageController.animateToPage(
      nextPage,
      duration: const Duration(
        milliseconds: 400,
      ),
      curve: Curves.easeInOutCubic,
    );
  }

  void _openSearch() {
    Get.to(
      () => const SearchScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(
        milliseconds: 250,
      ),
    );
  }

  void _toggleTheme() {
    if (Get.isRegistered<
      AppController
    >()) {
      Get.find<
            AppController
          >()
          .toggleTheme();
      return;
    }

    Get.changeThemeMode(
      Get.isDarkMode
          ? ThemeMode.light
          : ThemeMode.dark,
    );
  }

  void _openProductDetails(
    int productId,
  ) {
    Get.to(
      () => ProductDetail(
        productId: productId,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(
        milliseconds: 250,
      ),
    );
  }

  void _toggleFavorite(
    int productId,
  ) {
    setState(
      () {
        if (!_favoriteProductIds.add(
          productId,
        )) {
          _favoriteProductIds.remove(
            productId,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _featuredPageController.dispose();
    _searchController.dispose();
    _scrollController.removeListener(
      _onScroll,
    );
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(
      context,
    );
    final width = MediaQuery.sizeOf(
      context,
    ).width;
    final horizontalPadding = switch (width) {
      < 360 => 14.0,
      < 700 => 18.0,
      < 1100 => 32.0,
      _ => 48.0,
    };

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: _refreshForYouProducts,
          child: CustomScrollView(
            controller: _scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  14,
                  horizontalPadding,
                  118,
                ),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 1200,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _HomeHeader(
                            userName: 'Mahesh',
                            isDarkMode:
                                theme.brightness ==
                                Brightness.dark,
                            onThemePressed: _toggleTheme,
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          FillupWidget(
                            hintText: 'Search products',
                            icon: Icons.search_rounded,
                            keyboardType: TextInputType.text,
                            onTap: () => _openSearch(),
                            controller: _searchController,
                            textInputAction: TextInputAction.search,
                            onSubmitted:
                                (
                                  _,
                                ) {},
                            onClear: _searchController.clear,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          SizedBox(
                            height: 48,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: _categories.length,
                              separatorBuilder:
                                  (
                                    _,
                                    __,
                                  ) => const SizedBox(
                                    width: 10,
                                  ),
                              itemBuilder:
                                  (
                                    context,
                                    index,
                                  ) {
                                    final category = _categories[index];

                                    return TagsWidget(
                                      label: category.label,
                                      icon: category.icon,
                                      isSelected:
                                          index ==
                                          _selectedCategoryIndex,
                                      onPressed: () {
                                        setState(
                                          () {
                                            _selectedCategoryIndex = index;
                                          },
                                        );
                                      },
                                    );
                                  },
                            ),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          const _SectionTitle(
                            title: 'Featured',
                            icon: CupertinoIcons.flame_fill,
                            iconColor: Color(
                              0xFFFF7300,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          _FeaturedCarousel(
                            controller: _featuredPageController,
                            items: _featuredItems,
                            currentPage: _currentFeaturedPage,
                            onPageChanged:
                                (
                                  index,
                                ) {
                                  setState(
                                    () {
                                      _currentFeaturedPage = index;
                                    },
                                  );
                                },
                            onProductPressed: _openProductDetails,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const _SectionTitle(
                            title: 'Top Picks',
                            icon: CupertinoIcons.heart_fill,
                            iconColor: Colors.redAccent,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          SizedBox(
                            height:
                                width <
                                    360
                                ? 270
                                : 290,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: _topPicks.length,
                              separatorBuilder:
                                  (
                                    _,
                                    __,
                                  ) => const SizedBox(
                                    width: 14,
                                  ),
                              itemBuilder:
                                  (
                                    context,
                                    index,
                                  ) {
                                    final product = _topPicks[index];

                                    return SizedBox(
                                      width:
                                          width <
                                              420
                                          ? 170
                                          : 195,
                                      child: ProductCard(
                                        productId: product.id,
                                        imageUrl: product.imageUrl,
                                        oldPrice: product.oldPrice,
                                        newPrice: product.newPrice,
                                        productTitle: product.title,
                                        isFavorite: _favoriteProductIds.contains(
                                          product.id,
                                        ),
                                        onTap: () => _openProductDetails(
                                          product.id,
                                        ),
                                        onFavoritePressed: () => _toggleFavorite(
                                          product.id,
                                        ),
                                      ),
                                    );
                                  },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const _SectionTitle(
                            title: 'For You',
                            icon: CupertinoIcons.bag_fill,
                            iconColor: Color(
                              0xFFFFB000,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          _ResponsiveProductGrid(
                            products: _forYouProducts,
                            availableWidth:
                                width -
                                (horizontalPadding *
                                    2),
                            favoriteProductIds: _favoriteProductIds,
                            onProductPressed: _openProductDetails,
                            onFavoritePressed: _toggleFavorite,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          _ForYouPaginationFooter(
                            isLoading: _isLoadingMoreForYou,
                            hasMore: _hasMoreForYou,
                            hasProducts: _forYouProducts.isNotEmpty,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shows a loading spinner while the next page is fetching, or an
/// "end of list" message once there's nothing left to load.
class _ForYouPaginationFooter
    extends
        StatelessWidget {
  final bool isLoading;
  final bool hasMore;
  final bool hasProducts;

  const _ForYouPaginationFooter({
    required this.isLoading,
    required this.hasMore,
    required this.hasProducts,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(
      context,
    );

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Center(
          child: SizedBox(
            width: 26,
            height: 26,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
            ),
          ),
        ),
      );
    }

    if (!hasMore &&
        hasProducts) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Center(
          child: Text(
            "You've reached the end 🎉",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class _HomeHeader
    extends
        StatelessWidget {
  final String userName;
  final bool isDarkMode;
  final VoidCallback onThemePressed;

  const _HomeHeader({
    required this.userName,
    required this.isDarkMode,
    required this.onThemePressed,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(
      context,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Welcome to ',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'ShopEase!',
                    style: GoogleFonts.itim(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Hello, ',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '$userName.',
                    style: GoogleFonts.itim(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                  Text(
                    ' Greetings!',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Material(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(
            14,
          ),
          child: IconButton(
            onPressed: onThemePressed,
            tooltip: isDarkMode
                ? 'Use light mode'
                : 'Use dark mode',
            icon: Icon(
              isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              color: isDarkMode
                  ? Colors.amber
                  : AppTheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _FeaturedCarousel
    extends
        StatelessWidget {
  final PageController controller;
  final List<
    _FeaturedItem
  >
  items;
  final int currentPage;
  final ValueChanged<
    int
  >
  onPageChanged;
  final ValueChanged<
    int
  >
  onProductPressed;

  const _FeaturedCarousel({
    required this.controller,
    required this.items,
    required this.currentPage,
    required this.onPageChanged,
    required this.onProductPressed,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: [
        SizedBox(
          height: 205,
          child: PageView.builder(
            controller: controller,
            itemCount: items.length,
            onPageChanged: onPageChanged,
            physics: const BouncingScrollPhysics(),
            itemBuilder:
                (
                  context,
                  index,
                ) {
                  final item = items[index];
                  final selected =
                      index ==
                      currentPage;

                  return AnimatedPadding(
                    duration: const Duration(
                      milliseconds: 220,
                    ),
                    padding: EdgeInsets.only(
                      right: 12,
                      top: selected
                          ? 0
                          : 7,
                      bottom: selected
                          ? 0
                          : 7,
                    ),
                    child: FeaturedCard(
                      imageUrl: item.imageUrl,
                      title: item.title,
                      subtitle: item.subtitle,
                      onTap: () => onProductPressed(
                        item.productId,
                      ),
                    ),
                  );
                },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            items.length,
            (
              index,
            ) {
              final selected =
                  index ==
                  currentPage;

              return AnimatedContainer(
                duration: const Duration(
                  milliseconds: 220,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                width: selected
                    ? 22
                    : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: selected
                      ? AppTheme.primary
                      : Theme.of(
                          context,
                        ).colorScheme.outline,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ResponsiveProductGrid
    extends
        StatelessWidget {
  final List<
    _HomeProduct
  >
  products;
  final double availableWidth;
  final Set<
    int
  >
  favoriteProductIds;
  final ValueChanged<
    int
  >
  onProductPressed;
  final ValueChanged<
    int
  >
  onFavoritePressed;

  const _ResponsiveProductGrid({
    required this.products,
    required this.availableWidth,
    required this.favoriteProductIds,
    required this.onProductPressed,
    required this.onFavoritePressed,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final columns =
        availableWidth >=
            1050
        ? 4
        : availableWidth >=
              720
        ? 3
        : 2;
    const spacing = 14.0;
    final itemWidth =
        (availableWidth -
            spacing *
                (columns -
                    1)) /
        columns;

    return Wrap(
      spacing: spacing,
      runSpacing: 18,
      children: products.map(
        (
          product,
        ) {
          return SizedBox(
            width: itemWidth,
            child: ProductCard(
              productId: product.id,
              imageUrl: product.imageUrl,
              oldPrice: product.oldPrice,
              newPrice: product.newPrice,
              productTitle: product.title,
              isFavorite: favoriteProductIds.contains(
                product.id,
              ),
              onTap: () => onProductPressed(
                product.id,
              ),
              onFavoritePressed: () => onFavoritePressed(
                product.id,
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

class _SectionTitle
    extends
        StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;

  const _SectionTitle({
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(
      context,
    );
    final titleSize =
        MediaQuery.sizeOf(
              context,
            ).width <
            360
        ? 27.0
        : 32.0;

    return Row(
      children: [
        Flexible(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontSize: titleSize,
              height: 1.15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Icon(
          icon,
          color: iconColor,
          size: titleSize,
        ),
      ],
    );
  }
}

class _CategoryItem {
  final int? id;
  final String label;
  final IconData icon;

  const _CategoryItem({
    required this.id,
    required this.label,
    required this.icon,
  });
}

class _FeaturedItem {
  final int productId;
  final String imageUrl;
  final String title;
  final String subtitle;

  const _FeaturedItem({
    required this.productId,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });
}

class _HomeProduct {
  final int id;
  final String title;
  final String imageUrl;
  final String oldPrice;
  final String newPrice;

  const _HomeProduct({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.oldPrice,
    required this.newPrice,
  });
}
