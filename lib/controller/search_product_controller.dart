import 'package:get/get.dart';
import '../models/search_product_model.dart';
import '../services/search_product_service.dart';

class SearchProductController extends GetxController {
  final SearchProductService service;

  SearchProductController(this.service);

  final products = <SearchProductModel>[].obs;

  final isLoading = false.obs;

  final error = RxnString();

  Future<void> searchProducts({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      isLoading.value = true;

      error.value = null;

      final response = await service.searchProducts(
        queryParameters: queryParameters,
      );

      final List<dynamic> items = response.data["data"];

      products.assignAll(
        items.map((e) => SearchProductModel.fromJson(e)).toList(),
      );

    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    products.clear();
  }
}
