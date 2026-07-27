// category_controller

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/models/category_model.dart';
import 'package:shopease/services/category_service.dart';
import 'package:shopease/views/category_products_page.dart';

import 'package:shopease/views/search_screen.dart';

class CategoryController extends GetxController {
  final CategoryService _categoryService = CategoryService();

  // Reactive observable states
  final RxBool isLoading = false.obs;
  final RxnString errorMessage = RxnString();
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  // Fallback assets config moved out of the UI View
  final List<String> fallbackAssets = const [
    'assets/images/electronics.png',
    'assets/images/fashion.png',
    'assets/images/books.png',
    'assets/images/home.png',
    'assets/images/sports.png',
  ];

  final List<Color> lightCardColors = const [
    Color(0xFFEAF4FF),
    Color(0xFFF1F8F0),
    Color(0xFFEFF7F0),
    Color(0xFFFFF6E7),
    Color(0xFFF8EFFA),
  ];

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<void> loadCategories() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      final result = await _categoryService.fetchCategories();
      categories.assignAll(result);
    } catch (_) {
      errorMessage.value = 'Unable to load categories. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void openSearch() {
    Get.to(
      () => const SearchScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  void openCategory(CategoryModel category) {
    Get.to(
      () => CategoryProductsPage(
        categoryId: category.id,
        categoryName: category.name,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }
}
