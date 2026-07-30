import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/services/api_service.dart';
import '../models/wishlist_item_model.dart';

class WishlistService {
  final Dio _dio = ApiService().dio;

  Future<Options> get _options async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    return Options(headers: {"Authorization": "Bearer $token"});
  }

  Future<List<WishlistItemModel>> getWishlist() async {
    try {
      final response = await _dio.get("wishlist", options: await _options);

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
        options: await _options,
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
        options: await _options,
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Remove Wishlist Error: $e");
      return false;
    }
  }
}
