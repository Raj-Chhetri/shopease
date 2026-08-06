// class PaymentService {
//   Future<void> placeCashOnDeliveryOrder({
//     required int? orderId,
//     required double amount,
//   }) async {
//     // Future backend implementation:
//     //
//     // POST /api/orders
//     // {
//     //   "order_id": orderId,
//     //   "amount": amount,
//     //   "payment_method": "cod"
//     // }

//     await Future<void>.delayed(
//       const Duration(milliseconds: 900),
//     );
//   }

//   Future<void> initiateOnlinePayment({
//     required int? orderId,
//     required String paymentMethodId,
//     required double amount,
//     required String mobileNumber,
//   }) async {
//     // Future backend implementation:
//     //
//     // POST /api/payment/initiate
//     // {
//     //   "order_id": orderId,
//     //   "payment_method": paymentMethodId,
//     //   "amount": amount,
//     //   "mobile_number": mobileNumber
//     // }

//     await Future<void>.delayed(
//       const Duration(milliseconds: 800),
//     );
//   }

//   Future<void> connectToPaymentProvider({
//     required String paymentMethodId,
//   }) async {
//     // Future implementation:
//     // Open the payment URL returned by the backend.

//     await Future<void>.delayed(
//       const Duration(milliseconds: 900),
//     );
//   }

//   Future<void> verifyPayment({
//     required int? orderId,
//     required String paymentMethodId,
//   }) async {
//     // Future backend implementation:
//     //
//     // POST /api/payment/verify

//     await Future<void>.delayed(
//       const Duration(milliseconds: 900),
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/models/get_address_model.dart';
import 'package:shopease/services/api_service.dart';
import 'package:shopease/services/profile_service.dart';

class CheckoutResult {
  const CheckoutResult({
    required this.orderId,
    required this.orderNumber,
    required this.payableAmount,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
  });

  final int orderId;
  final String orderNumber;
  final double payableAmount;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;

  factory CheckoutResult.fromJson(
    Map<String, dynamic> json, {
    required double fallbackAmount,
  }) {
    final orderId = _toInt(json['order_id'] ?? json['id']);

    if (orderId <= 0) {
      throw const FormatException(
        'The checkout response did not contain a valid order ID.',
      );
    }

    return CheckoutResult(
      orderId: orderId,
      orderNumber: json['order_number']?.toString().trim().isNotEmpty == true
          ? json['order_number'].toString().trim()
          : orderId.toString(),
      payableAmount: _toDouble(
        json['payable_amount'] ?? json['grand_total'] ?? json['total_amount'],
        fallback: fallbackAmount,
      ),
      paymentMethod: json['payment_method']?.toString() ?? 'cod',
      paymentStatus: json['payment_status']?.toString() ?? 'unpaid',
      orderStatus: json['order_status']?.toString() ?? 'confirmed',
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double _toDouble(dynamic value, {required double fallback}) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? fallback;
  }
}

class CheckoutException implements Exception {
  const CheckoutException(this.message);

  final String message;

  @override
  String toString() => message;
}

class PaymentService {
  PaymentService({
    Dio? paymentDio,
    Dio? shopEaseDio,
    ProfileService? profileService,
  }) : _dio =
           paymentDio ??
           Dio(
             BaseOptions(
               baseUrl: 'https://sandbox-payment-api.onrender.com',
               connectTimeout: const Duration(seconds: 90),
               sendTimeout: const Duration(seconds: 30),
               receiveTimeout: const Duration(seconds: 90),
               headers: const {
                 'Content-Type': 'application/json',
                 'Accept': 'application/json',
               },
             ),
           ),
       _shopEaseDio = shopEaseDio ?? ApiService().dio,
       _profileService = profileService ?? ProfileService();

  final Dio _dio;
  final Dio _shopEaseDio;
  final ProfileService _profileService;

  Future<CheckoutResult> placeCashOnDeliveryOrder({
    required double amount,
  }) async {
    final options = await _authenticatedOptions();
    final addressId = await _resolveCheckoutAddressId();

    final response = await _shopEaseDio.post(
      'checkout',
      data: {
        'address_id': addressId,
        'payment_method': 'cod',
        'notes': 'Cash on Delivery order placed from ShopEase app',
      },
      options: options,
    );

    if (response.data is! Map) {
      throw const CheckoutException(
        'The ShopEase backend returned an invalid checkout response.',
      );
    }

    final responseBody = Map<String, dynamic>.from(response.data as Map);

    if (responseBody['success'] != true) {
      throw CheckoutException(
        responseBody['message']?.toString() ??
            'The ShopEase backend could not place this order.',
      );
    }

    final data = responseBody['data'];

    if (data is! Map) {
      throw const CheckoutException(
        'The ShopEase backend did not return the created order.',
      );
    }

    return CheckoutResult.fromJson(
      Map<String, dynamic>.from(data),
      fallbackAmount: amount,
    );
  }

  Future<Options> _authenticatedOptions() async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token')?.trim();

    if (token == null || token.isEmpty) {
      throw const CheckoutException(
        'Your session has expired. Please sign in again before checking out.',
      );
    }

    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<int> _resolveCheckoutAddressId() async {
    try {
      final response = await _profileService.getAddresses();
      final address = selectCurrentDeliveryAddress(response.data);

      if (address?.id == null) {
        throw const CheckoutException(
          'Add a delivery address in your profile before placing an order.',
        );
      }

      return address!.id!;
    } on CheckoutException {
      rethrow;
    } catch (error) {
      throw CheckoutException(error.toString().replaceFirst('Exception: ', ''));
    }
  }

  String getCheckoutErrorMessage(Object error) {
    if (error is CheckoutException) {
      return error.message;
    }

    if (error is DioException) {
      final responseData = error.response?.data;

      if (responseData is Map) {
        final message = responseData['message'];

        if (message != null && message.toString().trim().isNotEmpty) {
          return message.toString();
        }

        final errors = responseData['errors'];

        if (errors is Map && errors.isNotEmpty) {
          final firstError = errors.values.first;

          if (firstError is List && firstError.isNotEmpty) {
            return firstError.first.toString();
          }

          return firstError.toString();
        }
      }

      if (error.response?.statusCode == 401) {
        return 'Your session has expired. Please sign in again.';
      }

      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        return 'Could not reach the ShopEase backend. Check your connection and try again.';
      }
    }

    return 'Could not place your order. Please try again.';
  }

  Future<Map<String, dynamic>> initiateKhaltiPayment({
    required int? orderId,
    required double amount,
  }) async {
    final purchaseOrderId =
        orderId?.toString() ?? 'ORDER-${DateTime.now().millisecondsSinceEpoch}';

    final response = await _dio.post(
      '/payment/initiate',
      data: {
        // Our practice FastAPI endpoint accepts rupees
        // and converts them to paisa before calling Khalti.
        'amount': amount.round(),
        'purchase_order_id': purchaseOrderId,
        'purchase_order_name': 'ShopEase Order',
      },
    );

    final responseBody = Map<String, dynamic>.from(response.data as Map);

    final data = responseBody['data'];

    if (data is! Map) {
      throw const FormatException('Invalid Khalti initiation response');
    }

    return Map<String, dynamic>.from(data);
  }

  Future<Map<String, dynamic>> lookupKhaltiPayment({
    required String pidx,
  }) async {
    final response = await _dio.post('/payment/lookup', data: {'pidx': pidx});

    final responseBody = Map<String, dynamic>.from(response.data as Map);

    final data = responseBody['data'];

    if (data is! Map) {
      throw const FormatException('Invalid Khalti lookup response');
    }

    return Map<String, dynamic>.from(data);
  }

  Future<Map<String, dynamic>> verifyEsewaPayment({
    required String refId,
    required String productId,
    required String amount,
  }) async {
    final response = await _dio.post(
      '/payment/esewa/verify',
      data: {'ref_id': refId, 'product_id': productId, 'amount': amount},
    );

    return Map<String, dynamic>.from(response.data as Map);
  }

  String getDioErrorMessage(DioException error) {
    final responseData = error.response?.data;

    if (responseData is Map) {
      final detail = responseData['detail'];

      if (detail is Map) {
        final message = detail['message'];

        if (message != null) {
          return message.toString();
        }
      }

      if (detail != null) {
        return detail.toString();
      }
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Check whether the FastAPI backend is running.';

      case DioExceptionType.sendTimeout:
        return 'The request took too long to send.';

      case DioExceptionType.receiveTimeout:
        return 'The backend took too long to respond.';

      case DioExceptionType.connectionError:
        return 'Could not connect to the payment backend. Make sure the laptop and phone are on the same Wi-Fi.';

      case DioExceptionType.badResponse:
        return 'The payment backend returned status code ${error.response?.statusCode}.';

      case DioExceptionType.cancel:
        return 'The payment request was cancelled.';

      case DioExceptionType.badCertificate:
        return 'The server certificate was rejected.';

      case DioExceptionType.unknown:
        return error.message ?? 'An unknown network error occurred.';
      case DioExceptionType.transformTimeout:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
