// views/cartscreenview.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/cart_controller.dart';
import '../models/cart_item_model.dart';
import 'payment_screen.dart';
import 'product_detail.dart';

class Cartscreenview extends StatelessWidget {
  const Cartscreenview({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<CartController>()
        ? Get.find<CartController>()
        : Get.put(CartController(), permanent: true);

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          Obx(
            () => controller.selectedItemIds.isNotEmpty
                ? IconButton(
                    onPressed: () =>
                        controller.removeItems(controller.selectedItemIds),
                    icon: const Icon(Icons.delete_outline_rounded),
                  )
                : const SizedBox(),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.items.isEmpty) {
            return _EmptyCartState(onRefresh: controller.loadCart);
          }

          return RefreshIndicator(
            onRefresh: controller.loadCart,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final horizontalPadding = constraints.maxWidth < 700
                    ? 14.0
                    : 32.0;

                return ListView(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    10,
                    horizontalPadding,
                    150,
                  ),
                  children: [
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 850),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Obx(
                                  () => Checkbox(
                                    value: controller.areAllSelected,
                                    onChanged: controller.toggleSelectAll,
                                    activeColor: const Color(0xFF6D28FF),
                                    checkColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                    controller.areAllSelected
                                        ? 'Deselect all'
                                        : 'Select all',
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Obx(
                                  () => Text(
                                    '${controller.items.length} items',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ...controller.items.map(
                              (item) => _CartItemCard(
                                key: ValueKey(item.id),
                                controller: controller,
                                item: item,
                                onDecrease: () => controller.updateQuantity(
                                  item,
                                  item.quantity - 1,
                                ),
                                onIncrease: () => controller.updateQuantity(
                                  item,
                                  item.quantity + 1,
                                ),
                                onOpen: () => Get.to(
                                  () =>
                                      ProductDetail(productId: item.productId),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }),
      ),
      bottomNavigationBar: Obx(
        () => controller.items.isEmpty
            ? const SizedBox()
            : _CartSummary(
                subtotal: controller.selectedSubtotal,
                shippingFee: controller.selectedItemIds.isEmpty
                    ? 0
                    : CartController.shippingFee,
                total: controller.total,
                selectedCount: controller.selectedItemIds.length,
                isLoading: controller.isCheckingOut.value,
                onCheckout: controller.checkout,
              ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartController controller;
  final CartItemModel item;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final VoidCallback onOpen;

  const _CartItemCard({
    super.key,
    required this.controller,
    required this.item,
    required this.onDecrease,
    required this.onIncrease,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      final isSelected = controller.selectedItemIds.contains(item.id);
      final isRemoving = controller.removingItemIds.contains(item.id);

      return Opacity(
        opacity: isRemoving ? 0.5 : 1,
        child: Card(
          margin: const EdgeInsets.only(bottom: 10),
          elevation: 0,
          color: theme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outlineVariant,
              width: isSelected ? 1.4 : 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: isRemoving
                      ? null
                      : (value) => controller.toggleItemSelection(
                          item.id,
                          value ?? false,
                        ),
                  activeColor: theme.colorScheme.primary,
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                InkWell(
                  onTap: onOpen,
                  borderRadius: BorderRadius.circular(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item.imageUrl,
                      width: 70,
                      height: 82,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 70,
                        height: 82,
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          isRemoving
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () =>
                                      controller.removeFromCart(item),
                                  iconSize: 20,
                                  visualDensity: VisualDensity.compact,
                                  icon: const Icon(Icons.close_rounded),
                                ),
                        ],
                      ),
                      Text(
                        item.shopName,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (item.color != null || item.size != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          [
                            if (item.color != null) 'Color: ${item.color}',
                            if (item.size != null) 'Size: ${item.size}',
                          ].join(' • '),
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Rs. ${item.price.toStringAsFixed(0)}',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 5),
                          if (item.originalPrice != null)
                            Text(
                              'Rs. ${item.originalPrice!.toStringAsFixed(0)}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          const Spacer(),
                          _QuantitySelector(
                            quantity: item.quantity,
                            canDecrease: item.quantity > 1,
                            canIncrease: item.quantity < item.stockQuantity,
                            onDecrease: onDecrease,
                            onIncrease: onIncrease,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _QuantitySelector extends StatelessWidget {
  final int quantity;
  final bool canDecrease;
  final bool canIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const _QuantitySelector({
    required this.quantity,
    required this.canDecrease,
    required this.canIncrease,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: canDecrease ? onDecrease : null,
            iconSize: 16,
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.remove_rounded),
          ),
          Text(
            quantity.toString(),
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          IconButton(
            onPressed: canIncrease ? onIncrease : null,
            iconSize: 16,
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  final double subtotal;
  final double shippingFee;
  final double total;
  final int selectedCount;
  final bool isLoading;
  final VoidCallback onCheckout;

  const _CartSummary({
    required this.subtotal,
    required this.shippingFee,
    required this.total,
    required this.selectedCount,
    required this.isLoading,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Material(
        elevation: 12,
        color: theme.colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$selectedCount selected',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Rs. ${total.toStringAsFixed(0)}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF6D28FF),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      selectedCount == 0
                          ? 'Select items to checkout'
                          : 'Subtotal Rs. ${subtotal.toStringAsFixed(0)} + shipping Rs. ${shippingFee.toStringAsFixed(0)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: selectedCount == 0 || isLoading ? null : onCheckout,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF6D28FF),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 15,
                  ),
                ),
                child: Text(
                  isLoading ? 'Please wait...' : 'Checkout',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
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

class _EmptyCartState extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const _EmptyCartState({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: const [
          SizedBox(height: 140),
          Icon(Icons.shopping_cart_outlined, size: 72),
          SizedBox(height: 16),
          Text(
            'Your cart is empty',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 8),
          Text(
            'Products you add will appear here.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
