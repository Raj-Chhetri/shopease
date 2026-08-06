import 'package:dio/dio.dart';
import 'package:shopease/models/home_product.dart';
import 'package:shopease/services/api_service.dart';

class HomeProductApiService {
  final Dio dio = ApiService().dio;

  Future<
    List<
      HomeProduct
    >
  >
  fetchProducts({
    int page = 1,
    int perPage = 6,
    int? categoryId,
  }) async {
    try {
      final response = await dio.get(
        '/products',
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (categoryId !=
              null)
            'category_id': categoryId,
        },
      );

      final data =
          response.data['data'] ??
          response.data;
      if (data
              is Map<
                String,
                dynamic
              > &&
          data['data']
              is List) {
        return (data['data']
                as List)
            .map(
              (
                json,
              ) => HomeProduct.fromApiJson(
                json,
              ),
            )
            .toList();
      }

      if (data
          is List) {
        return data
            .map(
              (
                json,
              ) => HomeProduct.fromApiJson(
                json,
              ),
            )
            .toList();
      }

      return const <
        HomeProduct
      >[];
    } on DioException catch (
      e
    ) {
      throw Exception(
        e.response?.data['message'] ??
            e.message ??
            'Unable to load products',
      );
    }
  }
}
