import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/models/product_detail_model.dart';

class ProductDetailService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://shopease.sudamhub.com/api',
      headers: {
        'Accept': 'application/json',
      },
    ),
  );

  Future<String?> getToken() async { 
    final prefs = await SharedPreferences.getInstance(); 
    return prefs.getString('token'); 
  } 
  Future<Options> getAuthOptions() async { 
    final token = await getToken(); 
    return Options( 
      headers: { 
        'Authorization': 'Bearer $token', 
        'Accept': 'application/json', 
      }, 
    ); 
  }

  Future<ProductDetailModel> getProductDetails(int productId) async {
    final response = await dio.get('/products/$productId');

    return ProductDetailModel.fromJson(response.data['data']);
  }

  Future<String> addToCart({
    required int productId, 
    int quantity = 1
  }) async {
    try{
    final response = await dio.post(
      '/cart/add',
      data: {
        'product_id': productId, 
        'quantity': quantity
      },
      options: await getAuthOptions(),
    );

    return response.data['message'] ?? 'Product added to cart successfully.';
    } on DioException catch (error) {
      print('ADD TO CART STATUS: ${error.response?.statusCode}');
      print('ADD TO CART RESPONSE: ${error.response?.data}');
      print('ADD TO CART REQUEST: ${error.requestOptions.data}');

      final responseData = error.response?.data;

      if (responseData is Map) {
        final message = responseData['message'];

        if (message != null) {
          throw Exception(message.toString());
        }

        final errors = responseData['errors'];

        if (errors is Map && errors.isNotEmpty) {
          final firstError = errors.values.first;

          if (firstError is List && firstError.isNotEmpty) {
            throw Exception(firstError.first.toString());
          }

          throw Exception(firstError.toString());
        }
      }

      throw Exception('Unable to add product to cart');
    }
  }

  Future<String> addToWishlist(int productId) async {
    final response = await dio.post(
      '/wishlist/add/$productId',
      options: await getAuthOptions(),
    );

    return response.data['message'] ?? 'Product added to wishlist successfully.';
  }

  Future<String> removeFromWishlist(int productId) async {
    final response = await dio.delete(
      '/wishlist/$productId',
      options: await getAuthOptions(),
    );

    return response.data['message'] ?? 'Product removed from wishlist successfully.';
  }
}
