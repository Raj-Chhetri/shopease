import 'package:dio/dio.dart';
import '../models/wishlist_item_model.dart';

class WishlistService {
  final Dio _dio = Dio();

  // Hardcoded Base URL
  static const String baseUrl = "https://shopease.sudamhub.com/api";
  static const String token =
      "131|hcWUHJRsUyJ7fMJSmwzgLNVcuBFQkfgFJOJ4ZIRvd1f9203e";

  Future<List<WishlistItemModel>> getWishlist() async {
    try {
      final response = await _dio.get(
        "$baseUrl/wishlist",
        options: Options(
          headers: {
            "Accept": "application/json",
            'Authorization': "Bearer $token",
          },
        ),
      );

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
        "$baseUrl/wishlist/add/$productId",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
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
        "$baseUrl/wishlist/remove/$productId",
        options: Options(
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Remove Wishlist Error: $e");
      return false;
    }
  }
}
