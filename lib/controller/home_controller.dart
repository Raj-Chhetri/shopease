import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/app_controller.dart';
import 'package:shopease/models/featured_item.dart';
import 'package:shopease/models/home_category.dart';
import 'package:shopease/models/home_product.dart';
import 'package:shopease/services/home_service.dart';
import 'package:shopease/views/product_detail.dart';
import 'package:shopease/views/search_screen.dart';

class HomeController extends GetxController {
  HomeController({required HomeService homeService})
      : _homeService = homeService;

  final HomeService _homeService;

  final searchController = TextEditingController();
  final featuredPageController = PageController(viewportFraction: 0.9);
  final scrollController = ScrollController();

  final currentFeaturedPage = 0.obs;
  final selectedCategoryIndex = 0.obs;
  final favoriteProductIds = <int>{}.obs;
  final forYouProducts = <HomeProduct>[].obs;
  final isLoadingMoreForYou = false.obs;
  final hasMoreForYou = true.obs;

  final List<HomeCategory> categories = HomeService.categories;
  final List<FeaturedItem> featuredItems = HomeService.featuredItems;
  final List<HomeProduct> topPicks = HomeService.topPicks;

  static const int _forYouPageSize = 6;
  int _forYouPage = 1;
  Timer? _carouselTimer;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    loadMoreForYouProducts();

    _carouselTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => moveToNextFeaturedPage(),
    );
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    final nearBottom = scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 300;

    if (nearBottom &&
        !isLoadingMoreForYou.value &&
        hasMoreForYou.value) {
      loadMoreForYouProducts();
    }
  }

  Future<void> loadMoreForYouProducts() async {
    if (isLoadingMoreForYou.value || !hasMoreForYou.value) return;

    isLoadingMoreForYou.value = true;

    try {
      final newProducts = await _homeService.fetchForYouProducts(
        page: _forYouPage,
        pageSize: _forYouPageSize,
      );

      forYouProducts.addAll(newProducts);
      _forYouPage++;
      hasMoreForYou.value = newProducts.length == _forYouPageSize;
    } finally {
      isLoadingMoreForYou.value = false;
    }
  }

  Future<void> refreshForYouProducts() async {
    forYouProducts.clear();
    _forYouPage = 1;
    hasMoreForYou.value = true;
    await loadMoreForYouProducts();
  }

  void moveToNextFeaturedPage() {
    if (!featuredPageController.hasClients || featuredItems.length < 2) {
      return;
    }

    final nextPage =
        (currentFeaturedPage.value + 1) % featuredItems.length;

    featuredPageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  void setFeaturedPage(int index) {
    currentFeaturedPage.value = index;
  }

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void openSearch() {
    Get.to(
      () => const SearchScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  void toggleTheme() {
    if (Get.isRegistered<AppController>()) {
      Get.find<AppController>().toggleTheme();
      return;
    }

    Get.changeThemeMode(
      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
    );
  }

  void openProductDetails(int productId) {
    Get.to(
      () => ProductDetail(productId: productId),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  void toggleFavorite(int productId) {
    if (!favoriteProductIds.add(productId)) {
      favoriteProductIds.remove(productId);
    }
  }

  @override
  void onClose() {
    _carouselTimer?.cancel();
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    featuredPageController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
