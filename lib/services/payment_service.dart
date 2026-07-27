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

class PaymentService {
  PaymentService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: 'http://192.168.1.68:8000',
            connectTimeout: const Duration(seconds: 15),
            sendTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 30),
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );

  final Dio _dio;

  Future<void> placeCashOnDeliveryOrder({
    required int? orderId,
    required double amount,
  }) async {
    // Keep this temporary simulation until your actual
    // ShopEase order-creation backend is connected.
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );
  }

  Future<Map<String, dynamic>> initiateKhaltiPayment({
    required int? orderId,
    required double amount,
  }) async {
    final purchaseOrderId =
        orderId?.toString() ??
        'ORDER-${DateTime.now().millisecondsSinceEpoch}';

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

    final responseBody = Map<String, dynamic>.from(
      response.data as Map,
    );

    final data = responseBody['data'];

    if (data is! Map) {
      throw const FormatException(
        'Invalid Khalti initiation response',
      );
    }

    return Map<String, dynamic>.from(data);
  }

  Future<Map<String, dynamic>> lookupKhaltiPayment({
    required String pidx,
  }) async {
    final response = await _dio.post(
      '/payment/lookup',
      data: {
        'pidx': pidx,
      },
    );

    final responseBody = Map<String, dynamic>.from(
      response.data as Map,
    );

    final data = responseBody['data'];

    if (data is! Map) {
      throw const FormatException(
        'Invalid Khalti lookup response',
      );
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
      data: {
        'ref_id': refId,
        'product_id': productId,
        'amount': amount,
      },
    );

    return Map<String, dynamic>.from(
      response.data as Map,
    );
  }

  String getDioErrorMessage(
    DioException error,
  ) {
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