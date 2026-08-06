import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/services/api_service.dart';
import '../models/cart_item_model.dart';

class CartService {
  CartService({Dio? dio}) : _dio = dio ?? ApiService().dio;

  final Dio _dio;

  Future<Options> get _options async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token")?.trim();

    if (token == null || token.isEmpty) {
      throw const CartException('Please sign in to use your cart.');
    }

    return Options(headers: {"Authorization": "Bearer $token"});
  }

  Future<List<CartItemModel>> getCart() async {
    try {
      final response = await _dio.get("cart", options: await _options);

      if (response.statusCode == 200 && response.data["success"] == true) {
        final List data = response.data["data"]?["items"] ?? [];
        return data.map((e) => CartItemModel.fromJson(e)).toList();
      }

      throw CartException(
        response.data is Map && response.data['message'] != null
            ? response.data['message'].toString()
            : 'Unable to load your cart.',
      );
    } on DioException catch (e) {
      throw CartException(
        _errorMessage(e, fallback: 'Unable to load your cart.'),
      );
    }
  }

  Future<bool> addToCart(int productId, int quantity) async {
    try {
      final response = await _dio.post(
        "cart/add",
        data: {"product_id": productId, "quantity": quantity},
        options: await _options,
      );

      final success = response.statusCode == 200 || response.statusCode == 201;
      if (!success) {
        throw const CartException('Unable to add this product to your cart.');
      }
      return true;
    } on DioException catch (e) {
      throw CartException(
        _errorMessage(e, fallback: 'Unable to add this product to your cart.'),
      );
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
    } on DioException {
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

      return response.statusCode == 200;
    } on DioException {
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<bool> clearCart() async {
    try {
      final response = await _dio.delete("cart/clear", options: await _options);

      return response.statusCode == 200;
    } on DioException {
      return false;
    } catch (_) {
      return false;
    }
  }

  String _errorMessage(DioException error, {required String fallback}) {
    final data = error.response?.data;
    if (data is Map) {
      final message = data['message'];
      if (message != null && message.toString().trim().isNotEmpty) {
        return message.toString();
      }

      final errors = data['errors'];
      if (errors is Map && errors.isNotEmpty) {
        final first = errors.values.first;
        if (first is List && first.isNotEmpty) return first.first.toString();
        return first.toString();
      }
    }

    if (error.response?.statusCode == 401) {
      return 'Your session has expired. Please sign in again.';
    }
    return fallback;
  }
}

class CartException implements Exception {
  const CartException(this.message);

  final String message;

  @override
  String toString() => message;
}
