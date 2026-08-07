import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/models/order_model.dart';
import 'package:shopease/services/dio_service.dart';

class OrderService {
  final Dio _dio = DioService().dio;

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<OrderModel>> getOrders() async {
    final token = await _getToken();

    if (token == null || token.isEmpty) {
      throw Exception('User is not logged in.');
    }

    final response = await _dio.get(
      '/orders',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final responseData = response.data;

    final List<dynamic> orderList =
        responseData is Map<String, dynamic>
            ? (responseData['data'] ?? [])
            : [];

    return orderList
        .whereType<Map<String, dynamic>>()
        .map((e) => OrderModel.fromJson(e))
        .toList();
  }

  Future<void> cancelOrder(int orderId) async {
    final token = await _getToken();

    if (token == null || token.isEmpty) {
      throw Exception('User is not logged in.');
    }

    await _dio.put(
      '/orders/$orderId/cancel',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<void> returnOrder(
    int orderId, {
    String note = 'I want to return this order',
  }) async {
    final token = await _getToken();

    if (token == null || token.isEmpty) {
      throw Exception('User is not logged in.');
    }

    await _dio.post(
      '/orders/$orderId/return',
      data: {
        'note': note,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}








// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shopease/models/order_model.dart';
// import 'package:shopease/services/dio_service.dart';

// class OrderService {
//   final Dio _dio = DioService().dio;

//   Future<String?> _getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('token');
//   }

//   // GET ALL ORDERS
//   Future<List<OrderModel>> getOrders() async {
//     final token = await _getToken();

//     if (token == null || token.isEmpty) {
//       throw Exception('User is not logged in.');
//     }

//     final response = await _dio.get(
//       '/orders',
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       ),
//     );

//     final responseData = response.data;

//     final List<dynamic> orderList =
//         responseData is Map<String, dynamic>
//             ? (responseData['data'] ?? [])
//             : [];

//     return orderList
//         .whereType<Map<String, dynamic>>()
//         .map((e) => OrderModel.fromJson(e))
//         .toList();
//   }

//   // CANCEL ORDER
//   Future<void> cancelOrder(int orderId) async {
//     final token = await _getToken();

//     if (token == null || token.isEmpty) {
//       throw Exception('User is not logged in.');
//     }

//     await _dio.put(
//       '/orders/$orderId/cancel',
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       ),
//     );
//   }

//   // RETURN / REFUND ORDER
//   Future<void> returnOrder(
//     int orderId, {
//     String note = 'I want to return this order',
//   }) async {
//     final token = await _getToken();

//     if (token == null || token.isEmpty) {
//       throw Exception('User is not logged in.');
//     }

//     try {
//       final response = await _dio.post(
//         '/orders/$orderId/return',
//         data: {
//           'note': note,
//         },
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       final responseData = e.response?.data;

//       String message = 'Return request failed.';

//       if (responseData is Map<String, dynamic>) {
//         message =
//             responseData['message']?.toString() ??
//             responseData['error']?.toString() ??
//             responseData['detail']?.toString() ??
//             message;
//       }

//       throw Exception(message);
//     } catch (e) {
//       print('RETURN ORDER UNKNOWN ERROR: $e');

//       throw Exception(
//         'Something went wrong while requesting return.',
//       );
//     }
//   }
// }















// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shopease/models/order_model.dart';
// import 'package:shopease/services/dio_service.dart';

// class OrderService {
//   final Dio _dio = DioService().dio;

//   Future<String?> _getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('token');
//   }

//   Future<List<OrderModel>> getOrders() async {
//     final token = await _getToken();

//     if (token == null || token.isEmpty) {
//       throw Exception('User is not logged in.');
//     }

//     final response = await _dio.get(
//       '/orders',
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       ),
//     );

//     final responseData = response.data;

//     final List<dynamic> orderList =
//         responseData is Map<String, dynamic>
//             ? (responseData['data'] ?? [])
//             : [];

//     return orderList
//         .whereType<Map<String, dynamic>>()
//         .map((e) => OrderModel.fromJson(e))
//         .toList();
//   }

//   Future<void> cancelOrder(int orderId) async {
//     final token = await _getToken();

//     if (token == null || token.isEmpty) {
//       throw Exception('User is not logged in.');
//     }

//     await _dio.put(
//       '/orders/$orderId/cancel',
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       ),
//     );
//   }
// }




