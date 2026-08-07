import 'dart:ui';

class PaymentCredentialsArguments {
  final String paymentMethodId;
  final String paymentMethod;
  final double amount;
  final int? orderId;
  final int? buyNowProductId;
  final bool isCashOnDelivery;
  final Color paymentColor;
  final String paymentAsset;

  const PaymentCredentialsArguments({
    required this.paymentMethodId,
    required this.paymentMethod,
    required this.amount,
    required this.orderId,
    this.buyNowProductId,
    required this.isCashOnDelivery,
    required this.paymentColor,
    required this.paymentAsset,
  });
}
