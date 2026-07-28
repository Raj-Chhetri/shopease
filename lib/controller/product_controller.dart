import 'package:get/get.dart';

import 'package:shopease/models/product_model.dart';
import 'package:shopease/services/product_service.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();

  final RxList<ProductModel> products = <ProductModel>[].obs;

  final RxBool isLoading = false.obs;

  final RxString errorMessage = ''.obs;

  Future<void> fetchProductsByCategory(int categoryId) async {
    try {
      isLoading.value = true;

      errorMessage.value = "";

      final result = await _productService.fetchProductsByCategory(categoryId);

      products.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
