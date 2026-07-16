class PaymentService {
  Future<void> placeCashOnDeliveryOrder({
    required int? orderId,
    required double amount,
  }) async {
    // Future backend implementation:
    //
    // POST /api/orders
    // {
    //   "order_id": orderId,
    //   "amount": amount,
    //   "payment_method": "cod"
    // }

    await Future<void>.delayed(
      const Duration(milliseconds: 900),
    );
  }

  Future<void> initiateOnlinePayment({
    required int? orderId,
    required String paymentMethodId,
    required double amount,
    required String mobileNumber,
  }) async {
    // Future backend implementation:
    //
    // POST /api/payment/initiate
    // {
    //   "order_id": orderId,
    //   "payment_method": paymentMethodId,
    //   "amount": amount,
    //   "mobile_number": mobileNumber
    // }

    await Future<void>.delayed(
      const Duration(milliseconds: 800),
    );
  }

  Future<void> connectToPaymentProvider({
    required String paymentMethodId,
  }) async {
    // Future implementation:
    // Open the payment URL returned by the backend.

    await Future<void>.delayed(
      const Duration(milliseconds: 900),
    );
  }

  Future<void> verifyPayment({
    required int? orderId,
    required String paymentMethodId,
  }) async {
    // Future backend implementation:
    //
    // POST /api/payment/verify

    await Future<void>.delayed(
      const Duration(milliseconds: 900),
    );
  }
}