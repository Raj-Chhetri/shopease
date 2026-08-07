import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/app_controller.dart';
import 'package:shopease/controller/wishlist_controller.dart';
import 'package:shopease/models/category_model.dart';
import 'package:shopease/models/featured_item.dart';
import 'package:shopease/models/home_category.dart';
import 'package:shopease/models/home_product.dart';
import 'package:shopease/services/home_service.dart';
import 'package:shopease/services/wishlist_service.dart';
import 'package:shopease/views/category_products_page.dart';
import 'package:shopease/views/product_detail.dart';
import 'package:shopease/views/search_screen.dart';

class HomeController
    extends
        GetxController {
  final HomeService _homeService =
      Get.find<
        HomeService
      >();

  final TextEditingController searchController = TextEditingController();
  final PageController featuredPageController = PageController(
    viewportFraction: 0.9,
  );
  final ScrollController scrollController = ScrollController();

  final RxInt currentFeaturedPage = 0.obs;
  final RxInt selectedCategoryIndex = 0.obs;
  final RxSet<
    int
  >
  favoriteProductIds =
      <
            int
          >{}
          .obs;

  final RxList<
    FeaturedItem
  >
  featuredItems =
      <
            FeaturedItem
          >[]
          .obs;
  final RxList<
    HomeProduct
  >
  topPicks =
      <
            HomeProduct
          >[]
          .obs;
  final RxList<
    HomeProduct
  >
  forYouProducts =
      <
            HomeProduct
          >[]
          .obs;
  final RxList<
    CategoryModel
  >
  apiCategories =
      <
            CategoryModel
          >[]
          .obs;
  final RxBool isLoadingMoreForYou = false.obs;
  final RxBool hasMoreForYou = true.obs;
  final RxnString paginationError = RxnString();

  late final List<
    HomeCategory
  >
  categories = _homeService.categories;
  late final RxList<
    HomeCategory
  >
  displayedCategories =
      <
            HomeCategory
          >[]
          .obs;

  static const int _forYouPageSize = 6;
  int _forYouPage = 1;
  int _paginationGeneration = 0;
  Timer? _carouselTimer;

  bool get isInitialForYouLoading =>
      isLoadingMoreForYou.value &&
      forYouProducts.isEmpty;

  WishlistController get _wishlistController {
    if (!Get.isRegistered<
      WishlistController
    >()) {
      Get.put(
        WishlistController(),
        permanent: false,
      );
    }
    return Get.find<
      WishlistController
    >();
  }

  Future<
    void
  >
  _syncFavoriteStateWithWishlist() async {
    final wishlistController = _wishlistController;
    await wishlistController.loadWishlist();

    final syncedFavorites = wishlistController.wishlist
        .map(
          (
            item,
          ) => item.productId,
        )
        .toSet();

    favoriteProductIds.assignAll(
      syncedFavorites,
    );
  }

  @override
  void onInit() {
    super.onInit();

    scrollController.addListener(
      _onScroll,
    );
    displayedCategories.assignAll(
      categories,
    );
    _loadInitialHomeContent();
    _loadCategories();
    loadMoreForYouProducts();
    unawaited(
      _syncFavoriteStateWithWishlist(),
    );

    _carouselTimer = Timer.periodic(
      const Duration(
        seconds: 5,
      ),
      (
        _,
      ) => moveToNextFeaturedPage(),
    );
  }

  Future<
    void
  >
  _loadCategories() async {
    try {
      final categoriesFromApi = await _homeService.fetchCategories();
      if (categoriesFromApi.isNotEmpty) {
        apiCategories.assignAll(
          categoriesFromApi,
        );
        displayedCategories.assignAll(
          [
            const HomeCategory(
              id: null,
              label: 'All',
              icon: Icons.travel_explore_rounded,
            ),
            ...categoriesFromApi.map(
              (
                category,
              ) => HomeCategory(
                id: category.id,
                label: category.name,
                icon: Icons.category_rounded,
              ),
            ),
          ],
        );
      }
    } catch (
      error
    ) {
      debugPrint(
        'Home categories load failed: $error',
      );
    }
  }

  Future<
    void
  >
  _loadInitialHomeContent() async {
    try {
      final fetchedFeaturedItems = await _homeService.fetchFeaturedItems();
      if (fetchedFeaturedItems.isNotEmpty) {
        featuredItems.assignAll(
          fetchedFeaturedItems,
        );
      } else {
        featuredItems.assignAll(
          _homeService.featuredItems,
        );
      }

      final fetchedTopPicks = await _homeService.fetchTopPicks();
      if (fetchedTopPicks.isNotEmpty) {
        topPicks.assignAll(
          fetchedTopPicks,
        );
      } else {
        topPicks.assignAll(
          _homeService.topPicks,
        );
      }
    } catch (
      error
    ) {
      debugPrint(
        'Home initial content load failed: $error',
      );
      featuredItems.assignAll(
        _homeService.featuredItems,
      );
      topPicks.assignAll(
        _homeService.topPicks,
      );
    }
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    if (paginationError.value !=
        null)
      return;

    final position = scrollController.position;
    final nearBottom =
        position.pixels >=
        position.maxScrollExtent -
            300;

    if (nearBottom) {
      loadMoreForYouProducts();
    }
  }

  Future<
    void
  >
  loadMoreForYouProducts() async {
    if (isLoadingMoreForYou.value ||
        !hasMoreForYou.value)
      return;

    final requestGeneration = _paginationGeneration;

    isLoadingMoreForYou.value = true;
    paginationError.value = null;

    try {
      final result = await _homeService.fetchForYouProducts(
        page: _forYouPage,
        pageSize: _forYouPageSize,
      );

      // A refresh may have started while this request was running.
      if (requestGeneration !=
          _paginationGeneration)
        return;

      final existingIds = forYouProducts
          .map(
            (
              product,
            ) => product.id,
          )
          .toSet();
      final uniqueProducts = result.products
          .where(
            (
              product,
            ) => existingIds.add(
              product.id,
            ),
          )
          .toList(
            growable: false,
          );

      if (uniqueProducts.isNotEmpty) {
        forYouProducts.addAll(
          uniqueProducts,
        );
      }

      hasMoreForYou.value = result.hasMore;
      _forYouPage++;
    } catch (
      error
    ) {
      if (requestGeneration !=
          _paginationGeneration)
        return;

      paginationError.value = 'Products could not be loaded. Please try again.';
      debugPrint(
        'Home pagination error: $error',
      );
    } finally {
      if (requestGeneration ==
          _paginationGeneration) {
        isLoadingMoreForYou.value = false;
      }
    }
  }

  Future<
    void
  >
  refreshForYouProducts() async {
    _paginationGeneration++;
    _forYouPage = 1;

    forYouProducts.clear();
    hasMoreForYou.value = true;
    paginationError.value = null;
    isLoadingMoreForYou.value = false;

    await loadMoreForYouProducts();
  }

  Future<
    void
  >
  retryPagination() async {
    paginationError.value = null;
    await loadMoreForYouProducts();
  }

  void moveToNextFeaturedPage() {
    if (!featuredPageController.hasClients ||
        featuredItems.length <
            2) {
      return;
    }

    final nextPage =
        (currentFeaturedPage.value +
            1) %
        featuredItems.length;

    featuredPageController.animateToPage(
      nextPage,
      duration: const Duration(
        milliseconds: 400,
      ),
      curve: Curves.easeInOutCubic,
    );
  }

  void setFeaturedPage(
    int index,
  ) {
    currentFeaturedPage.value = index;
  }

  void selectCategory(
    int index,
  ) {
    final categoryList = displayedCategories.isNotEmpty
        ? displayedCategories
        : categories;

    if (index <
            0 ||
        index >=
            categoryList.length) {
      return;
    }

    selectedCategoryIndex.value = index;

    final selectedCategory = categoryList[index];

    if (selectedCategory.id ==
        null) {
      Get.to(
        () => const CategoryProductsPage(
          categoryId: 0,
          categoryName: 'All Products',
        ),
        transition: Transition.rightToLeft,
        duration: const Duration(
          milliseconds: 250,
        ),
      );
      return;
    }

    Get.to(
      () => CategoryProductsPage(
        categoryId: selectedCategory.id!,
        categoryName: selectedCategory.label,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(
        milliseconds: 250,
      ),
    );
  }

  void clearSearch() {
    searchController.clear();
  }

  void openSearch() {
    Get.to(
      () => const SearchScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(
        milliseconds: 250,
      ),
    );
  }

  void toggleTheme() {
    if (Get.isRegistered<
      AppController
    >()) {
      Get.find<
            AppController
          >()
          .toggleTheme();
      return;
    }

    Get.changeThemeMode(
      Get.isDarkMode
          ? ThemeMode.light
          : ThemeMode.dark,
    );
  }

  void openProductDetails(
    int productId,
  ) {
    Get.to(
      () => ProductDetail(
        productId: productId,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(
        milliseconds: 250,
      ),
    );
  }

  void toggleFavorite(
    int productId,
  ) {
    unawaited(
      _toggleFavorite(
        productId,
      ),
    );
  }

  Future<
    void
  >
  _toggleFavorite(
    int productId,
  ) async {
    final isCurrentlyFavorite = favoriteProductIds.contains(
      productId,
    );

    if (isCurrentlyFavorite) {
      favoriteProductIds.remove(
        productId,
      );

      final success = await WishlistService().removeFromWishlist(
        productId,
      );
      if (!success) {
        favoriteProductIds.add(
          productId,
        );
        Get.snackbar(
          'Error',
          'Unable to remove from wishlist',
        );
      }
      return;
    }

    favoriteProductIds.add(
      productId,
    );

    final success = await WishlistService().addToWishlist(
      productId,
    );
    if (!success) {
      favoriteProductIds.remove(
        productId,
      );
      Get.snackbar(
        'Error',
        'Unable to add to wishlist',
      );
      return;
    }

    await _syncFavoriteStateWithWishlist();
    Get.snackbar(
      'Success',
      'Added to wishlist',
    );
  }

  @override
  void onClose() {
    _paginationGeneration++;
    _carouselTimer?.cancel();

    scrollController.removeListener(
      _onScroll,
    );
    scrollController.dispose();
    featuredPageController.dispose();
    searchController.dispose();

    super.onClose();
  }
}
