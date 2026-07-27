import 'package:dio/dio.dart';

import 'package:shopease/models/product_model.dart';
import 'api_service.dart';

class ProductService {
  final Dio dio = ApiService().dio;

  Future<List<ProductModel>> fetchProductsByCategory(int categoryId) async {
    try {
      final response = await dio.get("categories/$categoryId/products");
      final List<dynamic> products = response.data["data"]["data"];
      return products.map((json) => ProductModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? e.message ?? "Unable to fetch products",
      );
    }
  }
}
