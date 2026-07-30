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
  final HomeService _homeService = Get.find<HomeService>();

  final TextEditingController searchController = TextEditingController();
  final PageController featuredPageController = PageController(
    viewportFraction: 0.9,
  );
  final ScrollController scrollController = ScrollController();

  final RxInt currentFeaturedPage = 0.obs;
  final RxInt selectedCategoryIndex = 0.obs;
  final RxSet<int> favoriteProductIds = <int>{}.obs;

  final RxList<HomeProduct> forYouProducts = <HomeProduct>[].obs;
  final RxBool isLoadingMoreForYou = false.obs;
  final RxBool hasMoreForYou = true.obs;
  final RxnString paginationError = RxnString();

  late final List<HomeCategory> categories = _homeService.categories;
  late final List<FeaturedItem> featuredItems = _homeService.featuredItems;
  late final List<HomeProduct> topPicks = _homeService.topPicks;

  static const int _forYouPageSize = 6;
  int _forYouPage = 1;
  int _paginationGeneration = 0;
  Timer? _carouselTimer;

  bool get isInitialForYouLoading =>
      isLoadingMoreForYou.value && forYouProducts.isEmpty;

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
    if (paginationError.value != null) return;

    final position = scrollController.position;
    final nearBottom = position.pixels >= position.maxScrollExtent - 300;

    if (nearBottom) {
      loadMoreForYouProducts();
    }
  }

  Future<void> loadMoreForYouProducts() async {
    if (isLoadingMoreForYou.value || !hasMoreForYou.value) return;

    final requestGeneration = _paginationGeneration;

    isLoadingMoreForYou.value = true;
    paginationError.value = null;

    try {
      final result = await _homeService.fetchForYouProducts(
        page: _forYouPage,
        pageSize: _forYouPageSize,
      );

      // A refresh may have started while this request was running.
      if (requestGeneration != _paginationGeneration) return;

      final existingIds = forYouProducts.map((product) => product.id).toSet();
      final uniqueProducts = result.products
          .where((product) => existingIds.add(product.id))
          .toList(growable: false);

      if (uniqueProducts.isNotEmpty) {
        forYouProducts.addAll(uniqueProducts);
      }

      hasMoreForYou.value = result.hasMore;
      _forYouPage++;
    } catch (error) {
      if (requestGeneration != _paginationGeneration) return;

      paginationError.value =
          'Products could not be loaded. Please try again.';
      debugPrint('Home pagination error: $error');
    } finally {
      if (requestGeneration == _paginationGeneration) {
        isLoadingMoreForYou.value = false;
      }
    }
  }

  Future<void> refreshForYouProducts() async {
    _paginationGeneration++;
    _forYouPage = 1;

    forYouProducts.clear();
    hasMoreForYou.value = true;
    paginationError.value = null;
    isLoadingMoreForYou.value = false;

    await loadMoreForYouProducts();
  }

  Future<void> retryPagination() async {
    paginationError.value = null;
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
    if (index < 0 || index >= categories.length) return;
    selectedCategoryIndex.value = index;
  }

  void clearSearch() {
    searchController.clear();
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
    if (favoriteProductIds.contains(productId)) {
      favoriteProductIds.remove(productId);
    } else {
      favoriteProductIds.add(productId);
    }
  }

  @override
  void onClose() {
    _paginationGeneration++;
    _carouselTimer?.cancel();

    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    featuredPageController.dispose();
    searchController.dispose();

    super.onClose();
  }
}
