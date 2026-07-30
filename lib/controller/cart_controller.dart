import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/models/cart_item_model.dart';
import 'package:shopease/services/cart_service.dart';
import 'package:shopease/views/payment_screen.dart';

class CartController extends GetxController {
  static const double shippingFee = 150;

  final CartService _service = CartService();

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

  Future<void> loadCart() async {
    isLoading.value = true;

    try {
      final cartItems = await _service.getCart();
      items.assignAll(cartItems);
    } catch (e) {
      print("loadCart error: $e");
      Get.snackbar("Error", "Failed to load cart");
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
          itemIds.length == 1 ? "Remove item?" : "Remove selected items?",
        ),
        content: const Text(
          "The selected products will be removed from your cart.",
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () => Get.back(result: true),
            child: const Text("Remove"),
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
      Get.snackbar("Success", "Cart cleared");
    } else {
      Get.snackbar("Error", "Unable to clear cart");
    }
  }

  Future<void> checkout() async {
    if (selectedItemIds.isEmpty) {
      Get.snackbar("Select Products", "Please select at least one product.");
      return;
    }

    isCheckingOut.value = true;

    try {
      Get.to(() => PaymentScreen(amount: total));
    } finally {
      isCheckingOut.value = false;
    }
  }

  Future<void> refreshCart() async {
    await loadCart();
  }
}
