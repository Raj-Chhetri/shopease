import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/models/product_detail_model.dart';
import 'package:shopease/services/product_detail_service.dart';
import 'package:shopease/views/main_navigation_screen.dart';
import 'package:shopease/views/payment_screen.dart';
import 'package:shopease/controller/wishlist_controller.dart';
import 'package:shopease/controller/cart_controller.dart';

class ProductDetailController extends GetxController {
  final int productId;

  ProductDetailController({required this.productId});

  final ProductDetailService service = ProductDetailService();

  // late final WishlistController wishlistController;

  WishlistController? get wishlistController {
  if (Get.isRegistered<WishlistController>()) {
    return Get.find<WishlistController>();
  }

  return null;
}

  CartController? get cartController {
  if (Get.isRegistered<CartController>()) {
    return Get.find<CartController>();
  }

  return null;
}

  final PageController pageController = PageController();

  ProductDetailModel? product;

  bool isLoading = false;
  bool isWishlistLoading = false;
  bool isAddingToCart = false;
  bool isBuyingNow = false;

  bool isFavorite = false;
  bool isDescriptionExpanded = false;

  int currentImageIndex = 0;
  int selectedSizeIndex = 0;
  int selectedColorIndex = 0;

  String errorMessage = '';

  static const Color primaryColor = Color(0xFF6D28FF);

  @override
  void onInit() {
    super.onInit();
    loadProduct();
  }

  Future<void> loadProduct() async {
    isLoading = true;
    errorMessage = '';
    update();

    try {
      product = await service.getProductDetails(productId);

      final wishlist = wishlistController;

      if (wishlist != null) {
        await wishlist.loadWishlist();

        isFavorite = wishlist.wishlist.any(
          (item) => item.productId == productId,
        );
      } else {
        isFavorite = product?.isFavorite ?? false;
      }

      currentImageIndex = 0;
      selectedSizeIndex = 0;
      selectedColorIndex = 0;
    } catch (error) {
      errorMessage = error.toString().replaceAll('Exception: ', '');
    }

    isLoading = false;
    update();
  }

  void changeImage(int index) {
    currentImageIndex = index;
    update();
  }

  void selectImage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void selectSize(int index) {
    selectedSizeIndex = index;
    update();
  }

  void selectColor(int index) {
    selectedColorIndex = index;
    update();
  }

  void toggleDescription() {
    isDescriptionExpanded = !isDescriptionExpanded;

    update();
  }

  Future<void> toggleFavorite() async {
    if (product == null || isWishlistLoading) {
      return;
    }

    bool oldValue = isFavorite;

    isFavorite = !isFavorite;
    isWishlistLoading = true;
    update();

    try {
      String message;

      if (isFavorite) {
        message = await service.addToWishlist(
          product!.id,
        );
      } else {
        message = await service.removeFromWishlist(
          product!.id,
        );
      }

      final wishlist = wishlistController;

      if (wishlist != null) {
        await wishlist.loadWishlist();

        isFavorite = wishlist.wishlist.any(
          (item) => item.productId == product!.id,
        );
      }

      Get.snackbar(
        'Wishlist',
        message,
        snackPosition: SnackPosition.TOP,
      );
    } catch (error) {
      isFavorite = oldValue;

      Get.snackbar(
        'Wishlist error',
        error.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.TOP,
      );
    }

    isWishlistLoading = false;
    update();
  }

  Future<void> addToCart() async {
    if (product == null || isAddingToCart ) {
      return;
    }

    if(product!.stockQuantity <= 0) {
      Get.snackbar(
        'Out of Stock',
        'This product is currently out of stock.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isAddingToCart = true;
    update();

    try {
      String message = await service.addToCart(
        productId: product!.id,
        quantity: 1,
      );



      await cartController?.loadCart();

      Get.snackbar(
        'Added to cart',
        message,
        snackPosition: SnackPosition.TOP,
      );
    } catch (error) {
      Get.snackbar(
        'Cart error',
        error.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.TOP,
      );
    }

    isAddingToCart = false;
    update();
  }

  Future<void> buyNow() async {
    if (product == null || isBuyingNow || product!.stockQuantity <= 0) {
      return;
    }

    isBuyingNow = true;
    update();

    await Get.to(() => PaymentScreen(amount: product!.price));

    isBuyingNow = false;
    update();
  }

  Future<void> openCart() async {
    if (Get.isRegistered<CartController>()) {
      await Get.find<CartController>().loadCart();
    }

    Get.offAll(
      () => const MainNavigationScreen(
        initialIndex: 3,
      ),
    );
  }

  double get discountPercentage {
    if (product == null) {
      return 0;
    }

    final originalPrice = product!.originalPrice;
    final price = product!.price;
    if (originalPrice == null) {
      return 0;
    }

    if (originalPrice <= price) {
      return 0;
    }

    return ((originalPrice - price) / originalPrice) * 100;
  }

  String formatPrice(double price) {
    return price.toStringAsFixed(0);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
