import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/models/cart_item_model.dart';
import 'package:shopease/services/cart_service.dart';
import 'package:shopease/views/payment_screen.dart';

class CartController extends GetxController {
  CartController({CartService? service}) : _service = service ?? CartService();

  // Matches the fixed delivery amount documented by the main backend checkout.
  static const double shippingFee = 100;

  final CartService _service;

  final RxBool isLoading = false.obs;
  final RxBool isCheckingOut = false.obs;

  final RxList<CartItemModel> items = <CartItemModel>[].obs;
  final RxSet<int> selectedItemIds = <int>{}.obs;
  final RxSet<int> removingItemIds = <int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  Future<void> loadCart({bool selectAll = false, bool showError = true}) async {
    isLoading.value = true;

    try {
      final cartItems = await _service.getCart();
      items.assignAll(cartItems);
      final availableItemIds = cartItems.map((item) => item.id).toSet();
      selectedItemIds.removeWhere(
        (itemId) => !availableItemIds.contains(itemId),
      );
      if (selectAll) {
        selectedItemIds.assignAll(availableItemIds);
      }
    } catch (e) {
      if (showError) {
        Get.snackbar('Cart error', e.toString());
      } else {
        rethrow;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void toggleSelectAll(bool? value) {
    if (value == true) {
      selectedItemIds.assignAll(items.map((e) => e.id));
    } else {
      selectedItemIds.clear();
    }
  }

  void toggleItemSelection(int itemId, bool selected) {
    if (selected) {
      selectedItemIds.add(itemId);
    } else {
      selectedItemIds.remove(itemId);
    }
  }

  bool get areAllSelected =>
      items.isNotEmpty && selectedItemIds.length == items.length;

  int get totalItemCount =>
      items.fold(0, (count, item) => count + item.quantity);

  double get selectedSubtotal {
    return items
        .where((item) => selectedItemIds.contains(item.id))
        .fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get total {
    if (selectedItemIds.isEmpty) return 0;
    return selectedSubtotal + shippingFee;
  }

  Future<void> updateQuantity(CartItemModel item, int quantity) async {
    if (quantity < 1 || quantity > item.stockQuantity) return;

    final index = items.indexWhere((e) => e.id == item.id);
    if (index == -1) return;

    final previousItem = items[index];

    items[index] = item.copyWith(quantity: quantity);

    final success = await _service.updateQuantity(item.id, quantity);

    if (!success) {
      items[index] = previousItem;
      Get.snackbar("Error", "Unable to update quantity");
    }
  }

  Future<void> removeFromCart(CartItemModel item) async {
    if (removingItemIds.contains(item.id)) return;
    removingItemIds.add(item.id);

    try {
      final success = await _service.removeItem(item.id);

      if (success) {
        items.removeWhere((e) => e.id == item.id);
        selectedItemIds.remove(item.id);
        Get.snackbar("Success", "Item removed from cart");
      } else {
        Get.snackbar("Error", "Unable to remove item");
      }
    } finally {
      removingItemIds.remove(item.id);
    }
  }

  Future<void> removeItems(Set<int> itemIds) async {
    if (itemIds.isEmpty) return;

    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: Text(
          itemIds.length == 1 ? 'remove_item'.tr : 'remove_selected_items'.tr,
        ),
        content: Text('remove_cart_description'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('cancel'.tr),
          ),
          FilledButton(
            onPressed: () => Get.back(result: true),
            child: Text('remove'.tr),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    for (final id in itemIds.toList()) {
      final matches = items.where((e) => e.id == id);
      if (matches.isNotEmpty) {
        await removeFromCart(matches.first);
      }
    }
  }

  Future<void> clearCart() async {
    final success = await _service.clearCart();

    if (success) {
      items.clear();
      selectedItemIds.clear();
      Get.snackbar('success'.tr, 'cart_cleared'.tr);
    } else {
      Get.snackbar('error'.tr, 'unable_clear_cart'.tr);
    }
  }

  Future<void> checkout() async {
    if (selectedItemIds.isEmpty) {
      Get.snackbar("Select Products", "Please select at least one product.");
      return;
    }

    if (selectedItemIds.length != items.length) {
      Get.snackbar(
        'Select all products',
        'The ShopEase checkout currently places every item in your cart. Select all products to continue.',
      );
      return;
    }

    isCheckingOut.value = true;

    try {
      Get.to(() => PaymentScreen(amount: total));
    } finally {
      isCheckingOut.value = false;
    }
  }

  /// Prepares the authenticated main-backend cart for a Buy Now checkout.
  /// The main API's /checkout endpoint always checks out the entire cart.
  Future<BuyNowPreparation> prepareBuyNow(int productId) async {
    await loadCart(showError: false);
    final existingProductIds = items.map((item) => item.productId).toSet();
    final hadOtherProducts = existingProductIds.any((id) => id != productId);

    if (!existingProductIds.contains(productId)) {
      await _service.addToCart(productId, 1);
    }

    await loadCart(selectAll: true, showError: false);

    if (!items.any((item) => item.productId == productId)) {
      throw const CartException(
        'The product could not be added to your backend cart.',
      );
    }

    if (items.isEmpty || total <= 0) {
      throw const CartException('Your cart is empty. Please try again.');
    }

    return BuyNowPreparation(
      amount: total,
      itemCount: items.length,
      hasOtherProducts: hadOtherProducts,
    );
  }

  Future<void> refreshCart() async {
    await loadCart();
  }
}

class BuyNowPreparation {
  const BuyNowPreparation({
    required this.amount,
    required this.itemCount,
    required this.hasOtherProducts,
  });

  final double amount;
  final int itemCount;
  final bool hasOtherProducts;
}
