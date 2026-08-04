import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/models/product_detail_model.dart';

class ProductDetailService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://shopease.sudamhub.com/api',
      headers: {'Accept': 'application/json'},
    ),
  );

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Options> getAuthOptions() async {
    final token = await getToken();
    return Options(
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
  }

  Future<ProductDetailModel> getProductDetails(int productId) async {
    final response = await dio.get('/products/$productId');

    return ProductDetailModel.fromJson(
      Map<String, dynamic>.from(response.data),
    );
  }

  Future<String> addToCart({required int productId, int quantity = 1}) async {
    final response = await dio.post(
      '/cart/add',
      data: {'product_id': productId, 'quantity': quantity},
      options: await getAuthOptions(),
    );
    return response.data['message'] ?? 'Product added to cart successfully.';
  }

  Future<String> addToWishlist(int productId) async {
    final response = await dio.post(
      '/wishlist/add/$productId',
      options: await getAuthOptions(),
    );
    return response.data['message'] ??
        'Product added to wishlist successfully.';
  }

  Future<String> removeFromWishlist(int productId) async {
    final response = await dio.delete(
      '/wishlist/$productId',
      options: await getAuthOptions(),
    );
    return response.data['message'] ??
        'Product removed from wishlist successfully.';
  }
}
