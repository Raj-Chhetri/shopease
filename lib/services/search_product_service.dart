import 'package:dio/dio.dart';
import 'package:shopease/services/api_service.dart';

class SearchProductService {
  final Dio dio = ApiService().dio;

  Future<Response> searchProducts({
    required Map<String, dynamic> queryParameters,
  }) async {
    return await dio.get("products/search", queryParameters: queryParameters);
  }
}
