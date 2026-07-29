import 'package:dio/dio.dart';
import '../models/cart_item_model.dart';

class CartService {
  final Dio _dio = Dio();

  static const String baseUrl = "https://shopease.sudamhub.com/api";
  static const String token =
      "131|hcWUHJRsUyJ7fMJSmwzgLNVcuBFQkfgFJOJ4ZIRvd1f9203e";

  Map<String, String> get _headers => {
    "Accept": "application/json",
    "Authorization": "Bearer $token",
  };

  Future<List<CartItemModel>> getCart() async {
    try {
      final response = await _dio.get(
        "$baseUrl/cart",
        options: Options(headers: _headers),
      );

      print("Cart Status Code: ${response.statusCode}");
      print("Cart Response: ${response.data}");

      if (response.statusCode == 200 && response.data["success"] == true) {
        // API nests the array under data.items, not data directly
        final List data = response.data["data"]?["items"] ?? [];

        return data.map((e) => CartItemModel.fromJson(e)).toList();
      }

      return [];
    } on DioException catch (e) {
      print("getCart DioException: ${e.type}");
      print("getCart response: ${e.response?.statusCode} ${e.response?.data}");
      return []; // return empty instead of rethrow, so UI shows empty state not a crash
    } catch (e) {
      print("getCart unexpected error: $e");
      return [];
    }
  }

  Future<bool> addToCart(int productId, int quantity) async {
    try {
      final response = await _dio.post(
        "$baseUrl/cart/add",
        data: {"product_id": productId, "quantity": quantity},
        options: Options(headers: _headers),
      );

      print("addToCart Status: ${response.statusCode}");
      print("addToCart Response: ${response.data}");

      return response.statusCode == 200;
    } on DioException catch (e) {
      print("addToCart error: ${e.response?.statusCode} ${e.response?.data}");
      return false;
    } catch (e) {
      print("addToCart error: $e");
      return false;
    }
  }

  Future<bool> updateQuantity(int cartItemId, int quantity) async {
    try {
      final response = await _dio.put(
        "$baseUrl/cart/$cartItemId",
        data: {"quantity": quantity},
        options: Options(headers: _headers),
      );

      return response.statusCode == 200;
    } on DioException {
      return false;
    }
  }

  Future<bool> removeItem(int cartItemId) async {
    try {
      final response = await _dio.delete(
        "$baseUrl/cart/$cartItemId",
        data: {"cart_item_id": cartItemId},
        options: Options(headers: _headers),
      );

      print("removeItem Status: ${response.statusCode}");
      print("removeItem Response: ${response.data}");

      return response.statusCode == 200;
    } on DioException catch (e) {
      print("removeItem error: ${e.response?.statusCode} ${e.response?.data}");
      return false;
    } catch (e) {
      print("removeItem error: $e");
      return false;
    }
  }

  Future<bool> clearCart() async {
    try {
      final response = await _dio.delete(
        "$baseUrl/cart/clear",
        options: Options(headers: _headers),
      );

      print("clearCart Status: ${response.statusCode}");
      print("clearCart Response: ${response.data}");

      return response.statusCode == 200;
    } on DioException catch (e) {
      print("clearCart error: ${e.response?.statusCode} ${e.response?.data}");
      return false;
    } catch (e) {
      print("clearCart error: $e");
      return false;
    }
  }
}
