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
      price: 100,
      originalPrice: 150,
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
        separatorBuilder: (_, _) {
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