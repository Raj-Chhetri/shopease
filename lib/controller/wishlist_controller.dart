import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/services/api_service.dart';
import 'package:shopease/views/product_detail.dart';
import '../models/wishlist_item_model.dart';

class WishlistController extends GetxController {
  final Dio _dio = ApiService().dio;

  static const String baseUrl = "https://shopease.sudamhub.com/api";

  Future<Options> get _options async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    return Options(
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );
  }

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedCategory = 'All'.obs;

  final RxList<WishlistItemModel> wishlist = <WishlistItemModel>[].obs;
  final RxSet<int> removingProductIds = <int>{}.obs;
  bool _hasLoadedWishlist = false;

  // Maps category_id -> category name
  final RxMap<int, String> categoryMap = <int, String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    loadWishlist();
  }

  Future<void> loadCategories() async {
    try {
      final response = await _dio.get(
        "$baseUrl/categories",
        options: await _options,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        final map = <int, String>{};

        for (final cat in data) {
          final id = cat['id'];
          final name = cat['name']?.toString();

          if (id is int && name != null && name.trim().isNotEmpty) {
            map[id] = name;
          }
        }

        categoryMap.value = map;
      }
    } on DioException {
      // The wishlist still works without category filter metadata.
    } catch (_) {
      // The wishlist still works without category filter metadata.
    }
  }

  Future<void> ensureWishlistLoaded() async {
    if (_hasLoadedWishlist || isLoading.value) return;
    await loadWishlist();
  }

  Future<void> loadWishlist() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _dio.get(
        "$baseUrl/wishlist",
        options: await _options,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> dataList = response.data['data'] ?? [];

        wishlist.value = dataList
            .map((json) => WishlistItemModel.fromJson(json))
            .toList();
        _hasLoadedWishlist = true;
      }
    } on DioException {
      errorMessage.value = 'unable_load_wishlist'.tr;
    } catch (_) {
      errorMessage.value = 'something_went_wrong'.tr;
    } finally {
      isLoading.value = false;
    }
  }

  List<String> get categories {
    final categoryNames =
        wishlist
            .map((item) => categoryMap[item.categoryId])
            .whereType<String>()
            .toSet()
            .toList()
          ..sort();

    return ['All', ...categoryNames];
  }

  List<WishlistItemModel> get visibleWishlist {
    if (selectedCategory.value == 'All') {
      return wishlist;
    }

    return wishlist
        .where((item) => categoryMap[item.categoryId] == selectedCategory.value)
        .toList();
  }

  void openProduct(WishlistItemModel item) {
    Get.to(() => ProductDetail(productId: item.productId));
  }

  Future<void> removeFromWishlist(WishlistItemModel item) async {
    if (removingProductIds.contains(item.productId)) return;

    removingProductIds.add(item.productId);

    try {
      final response = await _dio.delete(
        "$baseUrl/wishlist/${item.productId}",
        options: await _options,
      );

      if (response.statusCode == 200) {
        wishlist.removeWhere((w) => w.productId == item.productId);

        Get.snackbar('success'.tr, 'item_removed_wishlist'.tr);
      } else {
        Get.snackbar('error'.tr, 'failed_remove_item'.tr);
      }
    } on DioException {
      Get.snackbar('error'.tr, 'failed_remove_item'.tr);
    } finally {
      removingProductIds.remove(item.productId);
    }
  }
}
