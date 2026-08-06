import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/models/product_detail_model.dart';
import 'package:shopease/widgets/button_widget.dart';
import '../controller/product_detail_controller.dart';

class ProductDetail extends StatefulWidget {
  final int productId;

  const ProductDetail({super.key, required this.productId});

  @override
  State<ProductDetail> createState() {
    return _ProductDetailState();
  }
}

class _ProductDetailState extends State<ProductDetail> {
  static const Color _primaryColor = Color(0xFF6D28FF);

  late final ProductDetailController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(ProductDetailController(productId: widget.productId));
  }

  @override
  void dispose() {
    Get.delete<ProductDetailController>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailController>(
      builder: (controller) {
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
              icon: const Icon(Icons.arrow_back_rounded),
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
                onPressed: controller.isWishlistLoading
                    ? null
                    : controller.toggleFavorite,
                tooltip: controller.isFavorite
                    ? 'Remove from wishlist'
                    : 'Add to wishlist',
                icon: controller.isWishlistLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : AnimatedSwitcher(
                        duration: const Duration(milliseconds: 180),
                        child: Icon(
                          controller.isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          key: ValueKey(controller.isFavorite),
                          color: controller.isFavorite
                              ? Colors.red
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
              ),
              IconButton(
                onPressed: controller.openCart,
                tooltip: 'Cart',
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              const SizedBox(width: 6),
            ],
          ),
          body: _buildBody(context, controller),
          bottomNavigationBar: controller.product == null
              ? null
              : _buildBottomActions(context, controller),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ProductDetailController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.errorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 65,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(controller.errorMessage, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.loadProduct,
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    if (controller.product == null) {
      return const Center(child: Text('Product details are unavailable.'));
    }

    final Data product = controller.product!;
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      bottom: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizontalPadding = constraints.maxWidth < 360 ? 16.0 : 22.0;

          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              12,
              horizontalPadding,
              32,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 850),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageSlider(context, controller, product),

                    if (product.images.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      _buildThumbnails(context, controller, product),
                    ],

                    const SizedBox(height: 22),

                    _buildProductHeading(context, product),

                    const SizedBox(height: 12),

                    _buildPrice(context, controller, product),

                    const SizedBox(height: 18),

                    Divider(color: theme.colorScheme.outlineVariant),

                    const SizedBox(height: 14),

                    _buildDescription(context, controller, product),

                    if (product.sizes.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      _buildSizeSelector(context, controller, product),
                    ],

                    if (product.colors.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      _buildColorSelector(context, controller, product),
                    ],

                    const SizedBox(height: 22),

                    Divider(color: theme.colorScheme.outlineVariant),

                    const SizedBox(height: 18),

                    _buildDeliveryInformation(context),

                    const SizedBox(height: 18),

                    Divider(color: theme.colorScheme.outlineVariant),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageSlider(
    BuildContext context,
    ProductDetailController controller,
    Data product,
  ) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;

    final sliderHeight = screenWidth < 360
        ? 260.0
        : screenWidth < 700
        ? 330.0
        : 430.0;

    if (product.images.isEmpty) {
      return Container(
        height: sliderHeight,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 70,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      );
    }

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
            controller: controller.pageController,
            itemCount: product.images.length,
            onPageChanged: controller.changeImage,
            itemBuilder: (context, index) {
              return _NetworkProductImage(
                imageUrl: product.images[index],
                fit: BoxFit.cover,
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 14,
            child: _buildPageIndicator(controller, product),
          ),
          if (product.isOutOfStock)
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

  Widget _buildPageIndicator(ProductDetailController controller, Data product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(product.images.length, (index) {
        final isActive = index == controller.currentImageIndex;

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
      }),
    );
  }

  Widget _buildThumbnails(
    BuildContext context,
    ProductDetailController controller,
    Data product,
  ) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 78,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: product.images.length,
        separatorBuilder: (_, _) {
          return const SizedBox(width: 10);
        },
        itemBuilder: (context, index) {
          final isSelected = index == controller.currentImageIndex;

          return Semantics(
            button: true,
            selected: isSelected,
            label: 'View product image ${index + 1}',
            child: InkWell(
              onTap: () {
                controller.selectImage(index);
              },
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
                  imageUrl: product.images[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductHeading(BuildContext context, Data product) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ?? '',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.2,
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
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  product.rating.toStringAsFixed(1),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              '(${product.ratingCount ?? 0} reviews)',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPrice(
    BuildContext context,
    ProductDetailController controller,
    Data product,
  ) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 10,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'Rs. ${controller.formatPrice(product.discountedPrice)}',
          style: theme.textTheme.titleLarge?.copyWith(
            color: _primaryColor,
            fontWeight: FontWeight.w800,
          ),
        ),

        if (product.hasDiscount)
          Text(
            'Rs. ${controller.formatPrice(product.originalPrice)}',
            style: theme.textTheme.bodyLarge?.copyWith(
              decoration: TextDecoration.lineThrough,
            ),
          ),

        if (product.hasDiscount)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE3E3),
              borderRadius: BorderRadius.circular(8),
            ),

            child: Text(
              '${product.discountPercentage.toStringAsFixed(0)}% OFF',
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

  Widget _buildDescription(
    BuildContext context,
    ProductDetailController controller,
    Data product,
  ) {
    final theme = Theme.of(context);
    final description = (product.description ?? '').isEmpty
        ? 'No description available.'
        : product.description!;

    final shouldTruncate = description.length > 130;

    final displayedDescription =
        !controller.isDescriptionExpanded && shouldTruncate
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
            onPressed: controller.toggleDescription,
            style: TextButton.styleFrom(
              foregroundColor: _primaryColor,
              padding: const EdgeInsets.only(top: 5, right: 8),
              minimumSize: const Size(0, 38),
            ),
            child: Text(
              controller.isDescriptionExpanded ? 'Read less' : 'Read more',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
      ],
    );
  }

  Widget _buildSizeSelector(
    BuildContext context,
    ProductDetailController controller,
    Data product,
  ) {
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
          children: List.generate(product.sizes.length, (index) {
            final isSelected = index == controller.selectedSizeIndex;

            return Semantics(
              button: true,
              selected: isSelected,
              label: 'Size ${product.sizes[index]}',
              child: InkWell(
                onTap: () {
                  controller.selectSize(index);
                },
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 50,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _primaryColor
                        : theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    product.sizes[index],
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
          }),
        ),
      ],
    );
  }

  Widget _buildColorSelector(
    BuildContext context,
    ProductDetailController controller,
    Data product,
  ) {
    final theme = Theme.of(context);

    final selectedColor = product.colors[controller.selectedColorIndex];

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
          children: List.generate(product.colors.length, (index) {
            final option = product.colors[index];

            final isSelected = index == controller.selectedColorIndex;

            return Semantics(
              button: true,
              selected: isSelected,
              label: option.name,
              child: InkWell(
                onTap: () {
                  controller.selectColor(index);
                },
                customBorder: const CircleBorder(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
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
                      color: Color(option.colorValue),
                      border:
                          Color(option.colorValue) == const Color(0xFFFFFFFF)
                          ? Border.all(color: Colors.grey.shade300)
                          : null,
                    ),
                  ),
                ),
              ),
            );
          }),
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
          for (int index = 0; index < items.length; index++) ...[
            _buildDeliveryItem(context, items[index]),
            if (index != items.length - 1) const SizedBox(height: 12),
          ],
        ],
      );
    }

    return Row(
      children: List.generate(items.length, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == items.length - 1 ? 0 : 14),
            child: _buildDeliveryItem(context, items[index]),
          ),
        );
      }),
    );
  }

  Widget _buildDeliveryItem(BuildContext context, _DeliveryItem item) {
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
            child: Icon(item.icon, color: _primaryColor, size: 22),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    color: theme.colorScheme.onSurfaceVariant,
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

  Widget _buildBottomActions(
    BuildContext context,
    ProductDetailController controller,
  ) {
    final theme = Theme.of(context);
    final product = controller.product!;

    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return SafeArea(
      top: false,
      child: Material(
        color: theme.colorScheme.surface,
        elevation: 12,
        child: Padding(
          padding: EdgeInsets.fromLTRB(18, 12, 18, bottomPadding > 0 ? 8 : 16),
          child: Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  buttonText: controller.isAddingToCart
                      ? 'Adding...'
                      : 'Add to Cart',
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  color: _primaryColor,
                  icon: Icons.shopping_cart_outlined,
                  iconColor: _primaryColor,
                  onPressed: controller.isAddingToCart || product.isOutOfStock
                      ? null
                      : controller.addToCart,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ButtonWidget(
                  buttonText: controller.isBuyingNow
                      ? 'Please wait...'
                      : 'Buy Now',
                  backgroundColor: _primaryColor,
                  color: Colors.white,
                  onPressed: controller.isBuyingNow || product.isOutOfStock
                      ? null
                      : controller.buyNow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NetworkProductImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  const _NetworkProductImage({required this.imageUrl, required this.fit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Image.network(
      imageUrl,
      width: double.infinity,
      height: double.infinity,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        final expectedBytes = loadingProgress.expectedTotalBytes;

        final progress = expectedBytes == null
            ? null
            : loadingProgress.cumulativeBytesLoaded / expectedBytes;

        return ColoredBox(
          color: theme.colorScheme.surfaceContainerHighest,
          child: Center(
            child: CircularProgressIndicator(value: progress, strokeWidth: 2.5),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
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
