// // product detail

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:shopease/views/cartScrenn_view.dart';
// import 'package:shopease/views/payment_screen.dart';
// import 'package:shopease/widgets/button_widget.dart';

// ValueNotifier<bool> addFavorite = ValueNotifier(false);

// class ProductDetail extends StatefulWidget {
//   const ProductDetail({super.key});

//   @override
//   State<ProductDetail> createState() => _ProductDetailState();
// }

// class _ProductDetailState extends State<ProductDetail> {
//   final PageController pageController = PageController();

//   int currentImageIndex = 0;
//   int selectedSizeIndex = 0;
//   int selectedColorIndex = 0;
//   bool isDescriptionExpanded = false;

//   final List<String> sizes = ['6', '7', '8', '9', '10', '11'];

//   final List<Color> colorOptions = [
//     Colors.white,
//     Colors.black,
//     const Color(0xFF8C2AE7),
//   ];

//   final List<String> images = [
//     'https://i.pinimg.com/736x/18/6b/a7/186ba725b7390c2621adb344ccb30ffc.jpg',
//     'https://i.pinimg.com/736x/82/f4/f9/82f4f92d83b7d6feeb68769d425b5954.jpg',
//     'https://i.pinimg.com/736x/64/6c/fe/646cfe978869e8079aee0932307c6b42.jpg',
//     'https://i.pinimg.com/736x/2f/ea/40/2fea40bec026594df56f547eb6dba1be.jpg',
//   ];

//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: const Text(
//           "Details",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: () {
//               addFavorite.value = !addFavorite.value;
//             },
//             icon: ValueListenableBuilder(
//               valueListenable: addFavorite,
//               builder: (context, value, child) {
//                 return Icon(
//                   value ? Icons.favorite : Icons.favorite_border,
//                   color: value ? Colors.red : Colors.grey,
//                 );
//               },
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               Get.to(() => Cartscreenview());
//             },
//             icon: const Icon(Icons.shopping_cart),
//           ),
//         ],
//       ),
      


//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(22.0),
//           child: Column(
//             children: [
//               imageSlider(),
//               Gap(15),
//               fourImages(),
//               Gap(15),
//               productTitle(),
//               Gap(5),
//               price(),
//               Divider(color: Colors.grey.shade200),
//               description(),
//               Gap(15),
//               sizeSelector(),
//               Gap(15),
//               colorSelector(),
//               Gap(5),
//               Divider(color: Colors.grey.shade200),
//               Gap(5),
//               deliveryInfo(),
//               Gap(5),
//               Divider(color: Colors.grey.shade200),
//               Gap(5),
//               bottomBar(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget imageSlider() {
//     return Container(
//       height: 300,
//       decoration: BoxDecoration(
//         color: const Color(0xFFF3F1FB),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         children: [
//           Expanded(
//             child: PageView.builder(
//               controller: pageController,
//               itemCount: images.length,
//               onPageChanged: (index) {
//                 setState(() {
//                   currentImageIndex = index;
//                 });
//               },
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 6),
//                   child: Image.network(
//                     images[index],
//                     fit: BoxFit.cover,
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) return child;

//                       return const Center(child: CircularProgressIndicator());
//                     },
//                     errorBuilder: (context, error, stackTrace) => Icon(
//                       Icons.image_outlined,
//                       size: 90,
//                       color: Colors.grey.shade300,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           slideBar(),
//         ],
//       ),
//     );
//   }

//   Widget slideBar() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 13),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: List.generate(images.length, (index) {
//           final bool isActive = index == currentImageIndex;

//           return AnimatedContainer(
//             duration: const Duration(milliseconds: 250),
//             margin: const EdgeInsets.symmetric(horizontal: 3),
//             width: isActive ? 18 : 6,
//             height: 6,
//             decoration: BoxDecoration(
//               color: isActive ? const Color(0xFF6D28FF) : Colors.grey.shade300,
//               borderRadius: BorderRadius.circular(3),
//             ),
//           );
//         }),
//       ),
//     );
//   }

//   Widget fourImages() {
//     return SizedBox(
//       height: 80,
//       child: Row(
//         children: List.generate(images.length, (index) {
//           final bool isSelected = index == currentImageIndex;
//           return Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 4),
//               child: GestureDetector(
//                 onTap: () {
//                   pageController.animateToPage(
//                     index,
//                     duration: Duration(microseconds: 300),
//                     curve: Curves.easeInOut,
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF3F1FB),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: isSelected
//                           ? Color(0xFF6D28FF)
//                           : Colors.transparent,
//                       width: 2,
//                     ),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//                       images[index],
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       height: double.infinity,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }

//   Widget productTitle() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Product_Name",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 2),
//             Text(
//               "Sub_title",
//               style: TextStyle(fontSize: 14, color: Colors.grey),
//             ),
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Row(
//               children: [
//                 Icon(Icons.star, color: Colors.amber, size: 18),
//                 SizedBox(width: 4),
//                 Text(
//                   "4.6",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 2),
//             Text(
//               "(128 reviews)",
//               style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget price() {
//     return Row(
//       children: [
//         const Text(
//           "Rs. 5,399",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF6D28FF),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Text(
//           "Rs. 6,000",
//           style: TextStyle(
//             fontSize: 15,
//             color: Colors.grey.shade400,
//             decoration: TextDecoration.lineThrough,
//           ),
//         ),
//         const SizedBox(width: 10),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: const Color(0xFFFFE3E3),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: const Text(
//             "10% OFF",
//             style: TextStyle(
//               fontSize: 11,
//               color: Color(0xFFE05A5A),
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget description() {
//     const String description =
//         "The morning breeze drifted through the quiet streets as the city slowly came to life. People hurried toward their destinations, carrying hopes, plans, and the promise of a new day.";

//     return RichText(
//       text: TextSpan(
//         style: TextStyle(
//           color: Colors.grey.shade600,
//           fontSize: 15,
//           height: 1.5,
//         ),
//         children: [
//           TextSpan(
//             text: isDescriptionExpanded
//                 ? description
//                 : "${description.substring(0, 90)}...",
//           ),
//           TextSpan(
//             text: isDescriptionExpanded ? " Read less" : " Read more",
//             style: const TextStyle(
//               color: Color(0xFF6D28FF),
//               fontWeight: FontWeight.w600,
//             ),
//             recognizer: TapGestureRecognizer()
//               ..onTap = () {
//                 setState(() {
//                   isDescriptionExpanded = !isDescriptionExpanded;
//                 });
//               },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget sizeSelector() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Size",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Row(
//           children: List.generate(sizes.length, (index) {
//             final bool isSelected = index == selectedSizeIndex;
    
//             return Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4),
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedSizeIndex = index;
//                     });
//                   },
//                   child: Container(
//                     width: 44,
//                     height: 44,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? const Color(0xFF6D28FF)
//                           : const Color(0xFFF3F1FB),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       sizes[index],
//                       style: TextStyle(
//                         color: isSelected ? Colors.white : Colors.black87,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }

//   Widget colorSelector() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Color',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Row(
//           children: List.generate(colorOptions.length, (index) {
//             final bool isSelected = index == selectedColorIndex;
    
//             return Padding(
//               padding: const EdgeInsets.only(right: 14),
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedColorIndex = index;
//                   });
//                 },
//                 child: Container(
//                   width: 32,
//                   height: 32,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: colorOptions[index],
//                     border: Border.all(
//                       color: isSelected
//                           ? const Color(0xFF6D28FF)
//                           : Colors.grey.shade400,
//                       width: isSelected ? 2 : 1,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }

//   Widget deliveryInfo() {
//     return Row(
//       children: [
//         infoItem(
//           Icons.local_shipping_outlined,
//           "Free Delivery",
//           "Inside Valley\n2-3 days",
//         ),
//         Spacer(),
//         infoItem(
//           Icons.verified_outlined,
//           "100% original",
//           "Authentic\nProducts",
//         ),
//         Spacer(),
//         infoItem(Icons.cached, "Easy Returns", "within 7 days\nof delivery"),
//       ],
//     );
//   }

//   Widget bottomBar() {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 12,
//             offset: const Offset(0, -4),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: ButtonWidget(
//               buttonText: "Add to Cart",
//               backgroundColor: const Color(0xffF5F6FA),
//               color: const Color(0xFF6D28FF),
//               onPressed: () {
//                 Get.to(() => Cartscreenview());
//               },
//               icon: Icons.shopping_cart_outlined,
//               iconColor: const Color(0xFF6D28FF),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: ButtonWidget(
//               buttonText: "Buy Now",
//               backgroundColor: const Color(0xFF6D28FF),
//               color: Colors.white,
//               onPressed: () {
//                 Get.to(() => PaymentScreen());
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget infoItem(IconData icon, String title, String subtitle) {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: const Color(0xFFF3F1FB),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(icon, color: const Color(0xFF6D28FF), size: 20),
//         ),
//         const SizedBox(width: 8),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
//             ),
//             Text(
//               subtitle,
//               style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/views/main_navigation_screen.dart';
import 'package:shopease/views/payment_screen.dart';
import 'package:shopease/widgets/button_widget.dart';

class ProductDetail extends StatefulWidget {
  final int productId;

  const ProductDetail({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  static const Color _primaryColor = Color(0xFF6D28FF);

  final PageController _pageController = PageController();

  int _currentImageIndex = 0;
  int _selectedSizeIndex = 0;
  int _selectedColorIndex = 0;

  bool _isDescriptionExpanded = false;
  bool _isFavorite = false;
  bool _isAddingToCart = false;
  bool _isBuyingNow = false;

  // Temporary mock data.
  // Replace this with GET /api/products/{productId}.
  late final _ProductDetailsData _product;

  @override
  void initState() {
    super.initState();

    _product = const _ProductDetailsData(
      id: 1,
      name: 'Premium Running Shoes',
      subtitle: 'Comfortable everyday performance footwear',
      description:
          'These premium running shoes combine lightweight materials, '
          'responsive cushioning and breathable fabric. They are suitable '
          'for everyday wear, running and long walks while providing comfort '
          'and support throughout the day.',
      price: 5399,
      originalPrice: 6000,
      rating: 4.6,
      reviewCount: 128,
      stockQuantity: 25,
      images: [
        'https://i.pinimg.com/736x/18/6b/a7/'
            '186ba725b7390c2621adb344ccb30ffc.jpg',
        'https://i.pinimg.com/736x/82/f4/f9/'
            '82f4f92d83b7d6feeb68769d425b5954.jpg',
        'https://i.pinimg.com/736x/64/6c/fe/'
            '646cfe978869e8079aee0932307c6b42.jpg',
        'https://i.pinimg.com/736x/2f/ea/40/'
            '2fea40bec026594df56f547eb6dba1be.jpg',
      ],
      sizes: ['6', '7', '8', '9', '10', '11'],
      colors: [
        _ProductColor(
          name: 'White',
          value: Color(0xFFFFFFFF),
        ),
        _ProductColor(
          name: 'Black',
          value: Color(0xFF111111),
        ),
        _ProductColor(
          name: 'Purple',
          value: Color(0xFF8C2AE7),
        ),
      ],
    );
  }

  double get _discountPercentage {
    if (_product.originalPrice == null ||
        _product.originalPrice! <= _product.price) {
      return 0;
    }

    return ((_product.originalPrice! - _product.price) /
            _product.originalPrice! *
            100);
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    if (_isFavorite) {
      // Backend:
      // POST /api/wishlist/add/${widget.productId}
    } else {
      // Backend:
      // DELETE /api/wishlist/${widget.productId}
    }
  }

  Future<void> _addToCart() async {
    if (_isAddingToCart || _product.stockQuantity <= 0) {
      return;
    }

    setState(() {
      _isAddingToCart = true;
    });

    try {
      // Replace with:
      // POST /api/cart/add
      //
      // The exact request body is not documented in the collection.
      // It will likely need product_id, quantity and selected variants.
      await Future<void>.delayed(
        const Duration(milliseconds: 600),
      );

      if (!mounted) return;

      Get.snackbar(
        'Added to cart',
        '${_product.name} was added to your cart',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        icon: const Icon(
          Icons.shopping_cart_rounded,
          color: Colors.white,
        ),
        backgroundColor: _primaryColor,
        colorText: Colors.white,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isAddingToCart = false;
        });
      }
    }
  }

  void _openCart() {
  Get.offAll(
    () => const MainNavigationScreen(
      initialIndex: 3,
    ),
    transition: Transition.fadeIn,
    duration: const Duration(milliseconds: 250),
  );
}

  Future<void> _buyNow() async {
    if (_isBuyingNow || _product.stockQuantity <= 0) {
      return;
    }

    setState(() {
      _isBuyingNow = true;
    });

    try {
      await Future<void>.delayed(
        const Duration(milliseconds: 250),
      );

      if (!mounted) return;

      Get.to(
        () => PaymentScreen(
        amount: _product.price.toDouble(),),
        transition: Transition.rightToLeft,
        duration: const Duration(milliseconds: 250),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isBuyingNow = false;
        });
      }
    }
  }

  void _selectImage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          tooltip: 'Back',
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
        title: Text(
          'Details',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            tooltip: _isFavorite
                ? 'Remove from wishlist'
                : 'Add to wishlist',
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: Icon(
                _isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                key: ValueKey(_isFavorite),
                color: _isFavorite
                    ? Colors.red
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     // The main navigation shell should ideally switch to cart.
          //     Get.snackbar(
          //       'Cart',
          //       'Open the cart tab from the navigation bar.',
          //       snackPosition: SnackPosition.BOTTOM,
          //       margin: const EdgeInsets.all(16),
          //     );
          //   },
          //   tooltip: 'Cart',
          //   icon: const Badge(
          //     child: Icon(
          //       Icons.shopping_cart_outlined,
          //     ),
          //   ),
          // ),
          IconButton(
            onPressed: _openCart,
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding =
                constraints.maxWidth < 360 ? 16.0 : 22.0;

            return SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                12,
                horizontalPadding,
                32,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 850,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImageSlider(context),
                      const SizedBox(height: 14),
                      _buildThumbnails(context),
                      const SizedBox(height: 22),
                      _buildProductHeading(context),
                      const SizedBox(height: 12),
                      _buildPrice(context),
                      const SizedBox(height: 18),
                      Divider(
                        color: theme.colorScheme.outlineVariant,
                      ),
                      const SizedBox(height: 14),
                      _buildDescription(context),
                      const SizedBox(height: 24),
                      _buildSizeSelector(context),
                      const SizedBox(height: 24),
                      _buildColorSelector(context),
                      const SizedBox(height: 22),
                      Divider(
                        color: theme.colorScheme.outlineVariant,
                      ),
                      const SizedBox(height: 18),
                      _buildDeliveryInformation(context),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildBottomActions(context),
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;

    final sliderHeight = screenWidth < 360
        ? 260.0
        : screenWidth < 700
            ? 330.0
            : 430.0;

    return Container(
      height: sliderHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _product.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return _NetworkProductImage(
                imageUrl: _product.images[index],
                fit: BoxFit.cover,
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 14,
            child: _buildPageIndicator(),
          ),
          if (_product.stockQuantity <= 0)
            Positioned.fill(
              child: ColoredBox(
                color: Colors.black.withValues(alpha: 0.45),
                child: const Center(
                  child: Text(
                    'OUT OF STOCK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _product.images.length,
        (index) {
          final isActive = index == _currentImageIndex;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: isActive ? 22 : 7,
            height: 7,
            decoration: BoxDecoration(
              color: isActive
                  ? _primaryColor
                  : Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }

  Widget _buildThumbnails(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 78,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _product.images.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: 10);
        },
        itemBuilder: (context, index) {
          final isSelected = index == _currentImageIndex;

          return Semantics(
            button: true,
            selected: isSelected,
            label: 'View product image ${index + 1}',
            child: InkWell(
              onTap: () => _selectImage(index),
              borderRadius: BorderRadius.circular(13),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 76,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(
                    color: isSelected
                        ? _primaryColor
                        : theme.colorScheme.outlineVariant,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: _NetworkProductImage(
                  imageUrl: _product.images[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductHeading(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _product.name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _product.subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  _product.rating.toStringAsFixed(1),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              '(${_product.reviewCount} reviews)',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPrice(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 10,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'Rs. ${_formatPrice(_product.price)}',
          style: theme.textTheme.titleLarge?.copyWith(
            color: _primaryColor,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (_product.originalPrice != null)
          Text(
            'Rs. ${_formatPrice(_product.originalPrice!)}',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        if (_discountPercentage > 0)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE3E3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${_discountPercentage.round()}% OFF',
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFFE05A5A),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    final theme = Theme.of(context);
    final description = _product.description;

    final shouldTruncate = description.length > 130;

    final displayedDescription =
        !_isDescriptionExpanded && shouldTruncate
            ? '${description.substring(0, 130)}...'
            : description;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          child: Text(
            displayedDescription,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ),
        if (shouldTruncate)
          TextButton(
            onPressed: () {
              setState(() {
                _isDescriptionExpanded =
                    !_isDescriptionExpanded;
              });
            },
            style: TextButton.styleFrom(
              foregroundColor: _primaryColor,
              padding: const EdgeInsets.only(
                top: 5,
                right: 8,
              ),
              minimumSize: const Size(0, 38),
            ),
            child: Text(
              _isDescriptionExpanded
                  ? 'Read less'
                  : 'Read more',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSizeSelector(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
            _product.sizes.length,
            (index) {
              final isSelected =
                  index == _selectedSizeIndex;

              return Semantics(
                button: true,
                selected: isSelected,
                label: 'Size ${_product.sizes[index]}',
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedSizeIndex = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 180),
                    width: 50,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? _primaryColor
                          : theme.colorScheme
                              .surfaceContainerHighest,
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: Text(
                      _product.sizes[index],
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildColorSelector(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor =
        _product.colors[_selectedColorIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color: ${selectedColor.name}',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 14,
          runSpacing: 10,
          children: List.generate(
            _product.colors.length,
            (index) {
              final option = _product.colors[index];
              final isSelected =
                  index == _selectedColorIndex;

              return Semantics(
                button: true,
                selected: isSelected,
                label: option.name,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedColorIndex = index;
                    });
                  },
                  customBorder: const CircleBorder(),
                  child: AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 180),
                    width: 38,
                    height: 38,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? _primaryColor
                            : theme.colorScheme.outline,
                        width: isSelected ? 2.5 : 1,
                      ),
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: option.value,
                        border: option.value ==
                                const Color(0xFFFFFFFF)
                            ? Border.all(
                                color: Colors.grey.shade300,
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryInformation(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final items = const [
      _DeliveryItem(
        icon: Icons.local_shipping_outlined,
        title: 'Free Delivery',
        subtitle: 'Inside Valley\n2–3 days',
      ),
      _DeliveryItem(
        icon: Icons.verified_outlined,
        title: '100% Original',
        subtitle: 'Authentic\nproducts',
      ),
      _DeliveryItem(
        icon: Icons.cached_rounded,
        title: 'Easy Returns',
        subtitle: 'Within 7 days\nof delivery',
      ),
    ];

    if (width < 650) {
      return Column(
        children: [
          for (int index = 0;
              index < items.length;
              index++) ...[
            _buildDeliveryItem(
              context,
              items[index],
            ),
            if (index != items.length - 1)
              const SizedBox(height: 12),
          ],
        ],
      );
    }

    return Row(
      children: List.generate(
        items.length,
        (index) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right:
                    index == items.length - 1 ? 0 : 14,
              ),
              child: _buildDeliveryItem(
                context,
                items[index],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDeliveryItem(
    BuildContext context,
    _DeliveryItem item,
  ) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _primaryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              item.icon,
              color: _primaryColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color:
                        theme.colorScheme.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    final theme = Theme.of(context);
    final bottomPadding =
        MediaQuery.paddingOf(context).bottom;

    return SafeArea(
      top: false,
      child: Material(
        color: theme.colorScheme.surface,
        elevation: 12,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            18,
            12,
            18,
            bottomPadding > 0 ? 8 : 16,
          ),
          child: Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  buttonText: _isAddingToCart
                      ? 'Adding...'
                      : 'Add to Cart',
                  backgroundColor:
                      theme.colorScheme.surfaceContainerHighest,
                  color: _primaryColor,
                  icon: Icons.shopping_cart_outlined,
                  iconColor: _primaryColor,
                  onPressed: _isAddingToCart ||
                          _product.stockQuantity <= 0
                      ? null
                      : () async {
                          await _addToCart();
                        },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ButtonWidget(
                  buttonText: _isBuyingNow
                      ? 'Please wait...'
                      : 'Buy Now',
                  backgroundColor: _primaryColor,
                  color: Colors.white,
                  onPressed: _isBuyingNow ||
                          _product.stockQuantity <= 0
                      ? null
                      : () async {
                          await _buyNow();
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatPrice(num value) {
    final stringValue = value.toStringAsFixed(0);
    final reversed =
        stringValue.split('').reversed.toList();

    final parts = <String>[];

    for (int index = 0;
        index < reversed.length;
        index++) {
      if (index > 0 && index % 3 == 0) {
        parts.add(',');
      }

      parts.add(reversed[index]);
    }

    return parts.reversed.join();
  }
}

class _NetworkProductImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  const _NetworkProductImage({
    required this.imageUrl,
    required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Image.network(
      imageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: fit,
      loadingBuilder: (
        context,
        child,
        loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }

        final expectedBytes =
            loadingProgress.expectedTotalBytes;

        final progress = expectedBytes == null
            ? null
            : loadingProgress.cumulativeBytesLoaded /
                expectedBytes;

        return ColoredBox(
          color: theme.colorScheme.surfaceContainerHighest,
          child: Center(
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 2.5,
            ),
          ),
        );
      },
      errorBuilder: (
        context,
        error,
        stackTrace,
      ) {
        return ColoredBox(
          color: theme.colorScheme.surfaceContainerHighest,
          child: Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: 60,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        );
      },
    );
  }
}

class _ProductDetailsData {
  final int id;
  final String name;
  final String subtitle;
  final String description;

  final num price;
  final num? originalPrice;

  final double rating;
  final int reviewCount;
  final int stockQuantity;

  final List<String> images;
  final List<String> sizes;
  final List<_ProductColor> colors;

  const _ProductDetailsData({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.stockQuantity,
    required this.images,
    required this.sizes,
    required this.colors,
  });
}

class _ProductColor {
  final String name;
  final Color value;

  const _ProductColor({
    required this.name,
    required this.value,
  });
}

class _DeliveryItem {
  final IconData icon;
  final String title;
  final String subtitle;

  const _DeliveryItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}