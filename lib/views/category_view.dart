// // categoryScreen

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopease/views/homescreen.dart';
// import 'package:shopease/views/search_screen.dart';
// import 'package:shopease/widgets/bottomNavigationBar.dart';
// import 'package:shopease/widgets/category_card.dart';

// class CategoryPage extends StatelessWidget {
//   const CategoryPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F8F8),

//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text(
//           "Categories",
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
//               readOnly: true,
//               onTap: () {
//                 Get.to(() => SearchScreen());
//               },
//               decoration: InputDecoration(
//                 hintText: "Search here",

//                 prefixIcon: const Icon(Icons.search, color: Color(0xFF7A5AF8)),

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

//             const SizedBox(height: 24),

//             const Text(
//               "All Categories",
//               style: TextStyle(
//                 color: Color.fromARGB(255, 105, 105, 105),
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 16),

//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),

//               itemCount: 5,

//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 16,
//                 crossAxisSpacing: 16,
//                 childAspectRatio: 0.95,
//               ),

//               itemBuilder: (context, index) {
//                 final categories = [
//                   {
//                     "title": "Electronics",
//                     "image": "assets/images/electronics.png",
//                     "color": Color(0xFFEAF4FF),
//                   },
//                   {
//                     "title": "Fashion",
//                     "image": "assets/images/fashion.png",
//                     "color": Color(0xFFF1F8F0),
//                   },
//                   {
//                     "title": "Grocery",
//                     "image": "assets/images/grocery.png",
//                     "color": Color(0xFFEFF7F0),
//                   },
//                   {
//                     "title": "Sports",
//                     "image": "assets/images/sports.png",
//                     "color": Color(0xFFFFF6E7),
//                   },
//                   {
//                     "title": "Beauty",
//                     "image": "assets/images/beauty.png",
//                     "color": Color(0xFFF8EFFA),
//                   },
//                 ];

//                 return CategoryCard(
//                   title: categories[index]["title"] as String,
//                   image: categories[index]["image"] as String,
//                   backgroundColor: categories[index]["color"] as Color,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),

//       // buttom navigation bar added by Pankaj
//       extendBody: true,
//       bottomNavigationBar: ButtomNavigationBar(),

//       // navigation bar ends here
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/models/category_model.dart';
import 'package:shopease/views/search_screen.dart';
import 'package:shopease/widgets/category_card.dart';
import 'package:shopease/widgets/fillUp_widget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool _isLoading = false;
  String? _errorMessage;

  final List<CategoryModel> _categories = const [
    CategoryModel(
      id: 1,
      name: 'Electronics',
      imageUrl: null,
      productCount: 125,
    ),
    CategoryModel(
      id: 2,
      name: 'Fashion',
      imageUrl: null,
      productCount: 89,
    ),
    CategoryModel(
      id: 3,
      name: 'Grocery',
      imageUrl: null,
      productCount: 64,
    ),
    CategoryModel(
      id: 4,
      name: 'Sports',
      imageUrl: null,
      productCount: 48,
    ),
    CategoryModel(
      id: 5,
      name: 'Beauty',
      imageUrl: null,
      productCount: 37,
    ),
  ];

  final List<String> _fallbackAssets = const [
    'assets/images/electronics.png',
    'assets/images/fashion.png',
    'assets/images/grocery.png',
    'assets/images/sports.png',
    'assets/images/beauty.png',
  ];

  final List<Color> _lightCardColors = const [
    Color(0xFFEAF4FF),
    Color(0xFFF1F8F0),
    Color(0xFFEFF7F0),
    Color(0xFFFFF6E7),
    Color(0xFFF8EFFA),
  ];

  @override
  void initState() {
    super.initState();

    // Call _loadCategories() when your API service is ready.
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Backend:
      // GET /api/categories
      //
      // Expected top-level shape:
      // {
      //   "success": true,
      //   "message": "Categories retrieved",
      //   "data": [...]
      // }

      await Future<void>.delayed(
        const Duration(milliseconds: 500),
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            'Unable to load categories. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _openSearch() {
    Get.to(
      () => const SearchScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  void _openCategory(CategoryModel category) {
    Get.to(
      () => SearchScreen(
        initialCategoryId: category.id,
        initialCategoryName: category.name,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );

    // Alternative backend endpoint:
    // GET /api/categories/${category.id}/products
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Categories',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
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

            return RefreshIndicator(
              onRefresh: _loadCategories,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
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
                              FillupWidget(
                                hintText: 'Search products',
                                icon: Icons.search_rounded,
                                keyboardType: TextInputType.text,
                                readOnly: true,
                                onTap: _openSearch,
                              ),
                              const SizedBox(height: 26),
                              Text(
                                'All Categories',
                                style: theme.textTheme.titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: theme
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              if (_isLoading)
                                const SizedBox(
                                  height: 260,
                                  child: Center(
                                    child:
                                        CircularProgressIndicator(),
                                  ),
                                )
                              else if (_errorMessage != null)
                                _CategoryErrorState(
                                  message: _errorMessage!,
                                  onRetry: _loadCategories,
                                )
                              else if (_categories.isEmpty)
                                const _EmptyCategoryState()
                              else
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  itemCount: _categories.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            crossAxisCount,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16,
                                        childAspectRatio:
                                            width < 400
                                                ? 0.88
                                                : 0.95,
                                      ),
                                  itemBuilder: (context, index) {
                                    final category =
                                        _categories[index];

                                    final backgroundColor =
                                        isDark
                                            ? theme
                                                .colorScheme
                                                .surfaceContainerHighest
                                            : _lightCardColors[
                                                index %
                                                    _lightCardColors
                                                        .length];

                                    return CategoryCard(
                                      title: category.name,
                                      imageUrl:
                                          category.imageUrl,
                                      assetImage:
                                          index <
                                                  _fallbackAssets
                                                      .length
                                              ? _fallbackAssets[
                                                  index]
                                              : null,
                                      productCount:
                                          category.productCount,
                                      backgroundColor:
                                          backgroundColor,
                                      onTap: () {
                                        _openCategory(category);
                                      },
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CategoryErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _CategoryErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              size: 52,
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

class _EmptyCategoryState extends StatelessWidget {
  const _EmptyCategoryState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.category_outlined,
              size: 56,
            ),
            SizedBox(height: 12),
            Text('No categories are available'),
          ],
        ),
      ),
    );
  }
}