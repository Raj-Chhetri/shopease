import 'package:dio/dio.dart';
import 'package:shopease/models/product_model.dart';
import 'package:shopease/services/api_service.dart';
import '../models/wishlist_item_model.dart';

class WishlistService {
  final Dio _dio = ApiService().dio;

  static const String token =
      "131|hcWUHJRsUyJ7fMJSmwzgLNVcuBFQkfgFJOJ4ZIRvd1f9203e";

  Options get _options => Options(headers: {"Authorization": "Bearer $token"});

  Future<List<WishlistItemModel>> getWishlist() async {
    try {
      final response = await _dio.get("wishlist", options: _options);

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> dataList = response.data['data'] ?? [];

        return dataList
            .map((json) => WishlistItemModel.fromJson(json))
            .toList();
      }

      return [];
    } catch (e) {
      print("Wishlist Service Error: $e");
      rethrow;
    }
  }

  Future<bool> addToWishlist(int productId) async {
    try {
      final response = await _dio.post(
        "wishlist/add/$productId",
        options: _options,
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Add Wishlist Error: $e");
      return false;
    }
  }

  Future<bool> removeFromWishlist(int productId) async {
    try {
      final response = await _dio.delete(
        "wishlist/remove/$productId",
        options: _options,
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Remove Wishlist Error: $e");
      return false;
    }
  }
}
