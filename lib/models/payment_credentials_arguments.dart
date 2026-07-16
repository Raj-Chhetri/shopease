import 'dart:ui';

class PaymentCredentialsArguments {
  final String paymentMethodId;
  final String paymentMethod;
  final double amount;
  final int? orderId;
  final bool isCashOnDelivery;
  final Color paymentColor;
  final String paymentAsset;

  const PaymentCredentialsArguments({
    required this.paymentMethodId,
    required this.paymentMethod,
    required this.amount,
    required this.orderId,
    required this.isCashOnDelivery,
    required this.paymentColor,
    required this.paymentAsset,
  });
}