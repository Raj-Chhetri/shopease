import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/services/api_service.dart';
import '../models/cart_item_model.dart';

class CartService {
  final Dio _dio = ApiService().dio;

  Future<Options> get _options async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    return Options(headers: {"Authorization": "Bearer $token"});
  }

  Future<List<CartItemModel>> getCart() async {
    try {
      final response = await _dio.get("cart", options: await _options);

      print("Cart Status Code: ${response.statusCode}");
      print("Cart Response: ${response.data}");

      if (response.statusCode == 200 && response.data["success"] == true) {
        final List data = response.data["data"]?["items"] ?? [];
        return data.map((e) => CartItemModel.fromJson(e)).toList();
      }

      return [];
    } on DioException catch (e) {
      print("getCart DioException: ${e.type}");
      print("getCart response: ${e.response?.statusCode} ${e.response?.data}");
      return [];
    } catch (e) {
      print("getCart unexpected error: $e");
      return [];
    }
  }

  Future<bool> addToCart(int productId, int quantity) async {
    try {
      final response = await _dio.post(
        "cart/add",
        data: {"product_id": productId, "quantity": quantity},
        options: await _options,
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
        "cart/$cartItemId",
        data: {"quantity": quantity},
        options: await _options,
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      print(
        "updateQuantity error: ${e.response?.statusCode} ${e.response?.data}",
      );
      return false;
    }
  }

  Future<bool> removeItem(int cartItemId) async {
    try {
      final response = await _dio.delete(
        "cart/$cartItemId",
        data: {"cart_item_id": cartItemId},
        options: await _options,
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
      final response = await _dio.delete("cart/clear", options: await _options);

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
