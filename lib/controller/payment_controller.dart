import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/models/payment_credentials_arguments.dart';
import 'package:shopease/models/payment_method.dart';
import 'package:shopease/views/paymen_credentials_screen.dart';

class PaymentController extends GetxController {
  final double amount;
  final int? orderId;

  PaymentController({
    required this.amount,
    required this.orderId,
  });

  final RxInt selectedMethodIndex = 0.obs;

  final List<PaymentMethod> paymentMethods = const [
    PaymentMethod(
      id: 'esewa',
      name: 'eSewa',
      asset: 'assets/images/esewa.png',
      color: Colors.green,
      enabled: true,
      isCashOnDelivery: false,
    ),
    PaymentMethod(
      id: 'khalti',
      name: 'Khalti',
      asset: 'assets/images/khalti.png',
      color: Colors.purple,
      enabled: true,
      isCashOnDelivery: false,
    ),
    PaymentMethod(
      id: 'fonepay',
      name: 'FonePay',
      asset: 'assets/images/fonepay.png',
      color: Colors.red,
      enabled: true,
      isCashOnDelivery: false,
    ),
    PaymentMethod(
      id: 'cod',
      name: 'Cash on Delivery',
      asset: 'assets/images/cod.png',
      color: Colors.orange,
      enabled: true,
      isCashOnDelivery: true,
    ),
  ];

  PaymentMethod get selectedPaymentMethod {
    return paymentMethods[selectedMethodIndex.value];
  }

  void selectPaymentMethod(int index) {
    if (index < 0 || index >= paymentMethods.length) {
      return;
    }

    final method = paymentMethods[index];

    if (!method.enabled) {
      return;
    }

    selectedMethodIndex.value = index;
  }

  void continueToPayment() {
    final method = selectedPaymentMethod;

    if (!method.enabled) {
      Get.snackbar(
        'Payment unavailable',
        'This payment method is currently unavailable.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );

      return;
    }

    final arguments = PaymentCredentialsArguments(
      paymentMethodId: method.id,
      paymentMethod: method.name,
      amount: amount,
      orderId: orderId,
      isCashOnDelivery: method.isCashOnDelivery,
      paymentColor: method.color,
      paymentAsset: method.asset,
    );

    Get.to(
      () => PaymentCredentialsScreen(
        arguments: arguments,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  String formatAmount(double value) {
    final hasDecimal = value % 1 != 0;

    return hasDecimal
        ? value.toStringAsFixed(2)
        : value.toStringAsFixed(0);
  }
}