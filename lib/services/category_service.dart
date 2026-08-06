import 'package:dio/dio.dart';

import '../models/category_model.dart';
import 'api_service.dart';

class CategoryService {
  final Dio dio = ApiService().dio;

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await dio.get("categories");

      final List<dynamic> data = response.data["data"];

      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? e.message ?? "Something went wrong",
      );
    }
  }
}
