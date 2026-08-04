import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/models/product_detail_model.dart';
import 'package:shopease/services/product_detail_service.dart';
import 'package:shopease/views/main_navigation_screen.dart';
import 'package:shopease/views/payment_screen.dart';
import 'package:shopease/controller/wishlist_controller.dart';
import 'package:shopease/controller/cart_controller.dart';

class ProductDetailController extends GetxController {
  ProductDetailController({required this.productId});

  final int productId;

  final ProductDetailService service = ProductDetailService();

  final PageController pageController = PageController();

  ProductDetailModel? productResponse;

  Data? get product => productResponse?.data;

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
      productResponse = await service.getProductDetails(productId);

      if (product == null) {
        throw Exception('Product data was not found.');
      }

      final wishlist = wishlistController;

      if (wishlist != null) {
        await wishlist.loadWishlist();

        isFavorite = wishlist.wishlist.any(
          (item) => item.productId == productId,
        );
      } else {
        isFavorite = false;
      }

      currentImageIndex = 0;
      selectedSizeIndex = 0;
      selectedColorIndex = 0;
    } catch (error) {
      errorMessage = error.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading = false;
      update();
    }
  }

  void changeImage(int index) {
    final currentProduct = product;
    if (currentProduct == null ||
        index < 0 ||
        index >= currentProduct.images.length) {
      return;
    }

    currentImageIndex = index;
    update();
  }

  void selectImage(int index) {
    final currentProduct = product;
    if (currentProduct == null ||
        index < 0 ||
        index >= currentProduct.images.length) {
      return;
    }
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void selectSize(int index) {
    final currentProduct = product;

    if (currentProduct == null ||
        index < 0 ||
        index >= currentProduct.sizes.length) {
      return;
    }
    selectedSizeIndex = index;
    update();
  }

  void selectColor(int index) {
    final currentProduct = product;

    if (currentProduct == null ||
        index < 0 ||
        index >= currentProduct.colors.length) {
      return;
    }
    selectedColorIndex = index;
    update();
  }

  void toggleDescription() {
    isDescriptionExpanded = !isDescriptionExpanded;

    update();
  }

  Future<void> toggleFavorite() async {
    final currentProduct = product;
    final currentProductId = currentProduct?.id;

    if (currentProduct == null ||
        currentProductId == null ||
        isWishlistLoading) {
      return;
    }

    bool oldValue = isFavorite;

    isFavorite = !isFavorite;
    isWishlistLoading = true;
    update();

    try {
      late final String message;

      if (isFavorite) {
        message = await service.addToWishlist(currentProductId);
      } else {
        message = await service.removeFromWishlist(currentProductId);
      }

      final wishlist = wishlistController;

      if (wishlist != null) {
        await wishlist.loadWishlist();

        isFavorite = wishlist.wishlist.any(
          (item) => item.productId == currentProduct.id,
        );
      }

      Get.snackbar('Wishlist', message, snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      isFavorite = oldValue;

      Get.snackbar(
        'Wishlist error',
        error.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    isWishlistLoading = false;
    update();
  }

  Future<void> addToCart() async {
    final currentProduct = product;
    final currentProductId = currentProduct?.id;

    if (currentProduct == null || currentProductId == null || isAddingToCart) {
      return;
    }
    if (currentProduct.isOutOfStock) {
      Get.snackbar(
        'Out of stock',
        'This product is currently out of stock.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isAddingToCart = true;
    update();

    try {
      final String message = await service.addToCart(
        productId: currentProductId,
        quantity: 1,
      );

      await cartController?.loadCart();

      Get.snackbar(
        'Added to cart',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      Get.snackbar(
        'Cart error',
        error.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    isAddingToCart = false;
    update();
  }

  Future<void> buyNow() async {
    final currentProduct = product;
    if (currentProduct == null || isBuyingNow || currentProduct.isOutOfStock) {
      return;
    }

    isBuyingNow = true;
    update();

    await Get.to(() => PaymentScreen(amount: currentProduct.discountedPrice));

    isBuyingNow = false;
    update();
  }

  Future<void> openCart() async {
    final cart = cartController;
    if (cart != null) {
      await cart.loadCart();
    }

    Get.offAll(() => const MainNavigationScreen(initialIndex: 3));
  }

  String formatPrice(double price) {
    return price.toStringAsFixed(2);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
