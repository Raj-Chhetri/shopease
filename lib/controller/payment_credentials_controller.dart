import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/models/order_success_arguments.dart';
import 'package:shopease/models/payment_credentials_arguments.dart';
import 'package:shopease/services/payment_service.dart';
import 'package:shopease/views/order_success.dart';

class PaymentCredentialsController extends GetxController {
  final PaymentCredentialsArguments arguments;
  final PaymentService paymentService;

  PaymentCredentialsController({
    required this.arguments,
    required this.paymentService,
  });

  final formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  final mobileFocusNode = FocusNode();

  final RxBool isProcessing = false.obs;
  final RxString processingMessage = ''.obs;

  bool get isCashOnDelivery {
    return arguments.isCashOnDelivery;
  }

  String get instruction {
    if (isCashOnDelivery) {
      return 'Your order will be placed using Cash on Delivery. '
          'You can pay when the order arrives.';
    }

    return 'This is a payment simulation. In production, you will be '
        'redirected securely to ${arguments.paymentMethod} '
        'to authorize payment.';
  }

  String get formattedAmount {
    final amount = arguments.amount;
    final hasDecimal = amount % 1 != 0;

    return hasDecimal
        ? amount.toStringAsFixed(2)
        : amount.toStringAsFixed(0);
  }

  String? validateMobile(String? value) {
    if (isCashOnDelivery) {
      return null;
    }

    final mobile = value?.trim() ?? '';

    if (mobile.isEmpty) {
      return 'Please enter your mobile number';
    }

    if (!RegExp(r'^[0-9]{10}$').hasMatch(mobile)) {
      return 'Enter a valid 10-digit mobile number';
    }

    return null;
  }

  Future<void> proceedPayment() async {
    if (isProcessing.value) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    if (!isCashOnDelivery &&
        !(formKey.currentState?.validate() ?? false)) {
      return;
    }

    isProcessing.value = true;

    try {
      if (isCashOnDelivery) {
        processingMessage.value = 'Placing your order...';

        await paymentService.placeCashOnDeliveryOrder(
          orderId: arguments.orderId,
          amount: arguments.amount,
        );
      } else {
        processingMessage.value = 'Initiating payment...';

        await paymentService.initiateOnlinePayment(
          orderId: arguments.orderId,
          paymentMethodId: arguments.paymentMethodId,
          amount: arguments.amount,
          mobileNumber: mobileController.text.trim(),
        );

        processingMessage.value =
            'Connecting to ${arguments.paymentMethod}...';

        await paymentService.connectToPaymentProvider(
          paymentMethodId: arguments.paymentMethodId,
        );

        processingMessage.value = 'Verifying payment...';

        await paymentService.verifyPayment(
          orderId: arguments.orderId,
          paymentMethodId: arguments.paymentMethodId,
        );
      }

      final successArguments = OrderSuccessArguments(
        orderId: arguments.orderId?.toString() ?? 'TEMP-12345',
        paymentMethod: arguments.paymentMethod,
        amount: arguments.amount,
      );

      Get.off(
        () => OrderSuccessScreen(
          arguments: successArguments,
        ),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 250),
      );
    } catch (error) {
      Get.snackbar(
        isCashOnDelivery ? 'Order failed' : 'Payment failed',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      isProcessing.value = false;
      processingMessage.value = '';
    }
  }

  void goBack() {
    if (!isProcessing.value) {
      Get.back();
    }
  }

  @override
  void onClose() {
    mobileController.dispose();
    mobileFocusNode.dispose();
    super.onClose();
  }
}