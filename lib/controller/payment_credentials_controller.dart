// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopease/models/order_success_arguments.dart';
// import 'package:shopease/models/payment_credentials_arguments.dart';
// import 'package:shopease/services/payment_service.dart';
// import 'package:shopease/views/order_success.dart';

// class PaymentCredentialsController extends GetxController {
//   final PaymentCredentialsArguments arguments;
//   final PaymentService paymentService;

//   PaymentCredentialsController({
//     required this.arguments,
//     required this.paymentService,
//   });

//   final formKey = GlobalKey<FormState>();
//   final mobileController = TextEditingController();
//   final mobileFocusNode = FocusNode();

//   final RxBool isProcessing = false.obs;
//   final RxString processingMessage = ''.obs;

//   bool get isCashOnDelivery {
//     return arguments.isCashOnDelivery;
//   }

//   String get instruction {
//     if (isCashOnDelivery) {
//       return 'Your order will be placed using Cash on Delivery. '
//           'You can pay when the order arrives.';
//     }

//     return 'This is a payment simulation. In production, you will be '
//         'redirected securely to ${arguments.paymentMethod} '
//         'to authorize payment.';
//   }

//   String get formattedAmount {
//     final amount = arguments.amount;
//     final hasDecimal = amount % 1 != 0;

//     return hasDecimal
//         ? amount.toStringAsFixed(2)
//         : amount.toStringAsFixed(0);
//   }

//   String? validateMobile(String? value) {
//     if (isCashOnDelivery) {
//       return null;
//     }

//     final mobile = value?.trim() ?? '';

//     if (mobile.isEmpty) {
//       return 'Please enter your mobile number';
//     }

//     if (!RegExp(r'^[0-9]{10}$').hasMatch(mobile)) {
//       return 'Enter a valid 10-digit mobile number';
//     }

//     return null;
//   }

//   Future<void> proceedPayment() async {
//     if (isProcessing.value) {
//       return;
//     }

//     FocusManager.instance.primaryFocus?.unfocus();

//     if (!isCashOnDelivery &&
//         !(formKey.currentState?.validate() ?? false)) {
//       return;
//     }

//     isProcessing.value = true;

//     try {
//       if (isCashOnDelivery) {
//         processingMessage.value = 'Placing your order...';

//         await paymentService.placeCashOnDeliveryOrder(
//           orderId: arguments.orderId,
//           amount: arguments.amount,
//         );
//       } else {
//         processingMessage.value = 'Initiating payment...';

//         await paymentService.initiateOnlinePayment(
//           orderId: arguments.orderId,
//           paymentMethodId: arguments.paymentMethodId,
//           amount: arguments.amount,
//           mobileNumber: mobileController.text.trim(),
//         );

//         processingMessage.value =
//             'Connecting to ${arguments.paymentMethod}...';

//         await paymentService.connectToPaymentProvider(
//           paymentMethodId: arguments.paymentMethodId,
//         );

//         processingMessage.value = 'Verifying payment...';

//         await paymentService.verifyPayment(
//           orderId: arguments.orderId,
//           paymentMethodId: arguments.paymentMethodId,
//         );
//       }

//       final successArguments = OrderSuccessArguments(
//         orderId: arguments.orderId?.toString() ?? 'TEMP-12345',
//         paymentMethod: arguments.paymentMethod,
//         amount: arguments.amount,
//       );

//       Get.off(
//         () => OrderSuccessScreen(
//           arguments: successArguments,
//         ),
//         transition: Transition.fadeIn,
//         duration: const Duration(milliseconds: 250),
//       );
//     } catch (error) {
//       Get.snackbar(
//         isCashOnDelivery ? 'Order failed' : 'Payment failed',
//         'Something went wrong. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//         margin: const EdgeInsets.all(16),
//       );
//     } finally {
//       isProcessing.value = false;
//       processingMessage.value = '';
//     }
//   }

//   void goBack() {
//     if (!isProcessing.value) {
//       Get.back();
//     }
//   }

//   @override
//   void onClose() {
//     mobileController.dispose();
//     mobileFocusNode.dispose();
//     super.onClose();
//   }
// }

import 'dart:async';
import 'package:dio/dio.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart' as esewa_sdk;
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart'
    as esewa_sdk;
import 'package:esewa_flutter_sdk/esewa_payment.dart' as esewa_sdk;
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart' as esewa_sdk;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_checkout_flutter/khalti_checkout_flutter.dart'
    as khalti_sdk;
import 'package:shopease/models/order_success_arguments.dart';
import 'package:shopease/models/payment_credentials_arguments.dart';
import 'package:shopease/services/payment_service.dart';
import 'package:shopease/views/order_success.dart';

class PaymentCredentialsController extends GetxController
    with WidgetsBindingObserver {
  PaymentCredentialsController({
    required this.arguments,
    required this.paymentService,
  });

  final PaymentCredentialsArguments arguments;
  final PaymentService paymentService;

  // Replace this with your Khalti sandbox public key.
  static const String _khaltiPublicKey =
      'd2563a66edab4dd49afbbad8c9f64e4d';

  // Official eSewa sandbox SDK credentials.
  static const String _esewaClientId =
      'JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R';

  static const String _esewaSecretKey =
      'BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==';

  // These are kept temporarily because the existing
  // PaymentCredentialsScreen still references them.
  final formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  final mobileFocusNode = FocusNode();

  final RxBool isProcessing = false.obs;
  final RxString processingMessage = ''.obs;

  String? _activeKhaltiPidx;
  khalti_sdk.Khalti? _activeKhalti;
  BuildContext? _khaltiCheckoutContext;

  Timer? _khaltiPollingTimer;

  bool _isKhaltiLookupRunning = false;
  bool _isKhaltiCheckoutOpen = false;
  bool _isFinishingKhaltiPayment = false;

  int _khaltiPollingAttempts = 0;

  static const int _maximumKhaltiPollingAttempts = 90;

  //-------------------------------------

  String? _pendingEsewaRefId;
  String? _pendingEsewaProductId;
  String? _pendingEsewaAmount;
  String? _pendingEsewaSdkStatus;

  bool _isEsewaVerificationRunning = false;

  bool get isCashOnDelivery {
    return arguments.isCashOnDelivery;
  }

  bool get isKhalti {
    return arguments.paymentMethodId == 'khalti';
  }

  bool get isEsewa {
    return arguments.paymentMethodId == 'esewa';
  }

  String get instruction {
    if (isCashOnDelivery) {
      return 'Your order will be placed using Cash on Delivery. '
          'You can pay when the order arrives.';
    }

    if (isKhalti) {
      return 'You will be redirected securely to Khalti Sandbox '
          'to complete your payment.';
    }

    if (isEsewa) {
      return 'You will be redirected securely to eSewa Sandbox '
          'to complete your payment.';
    }

    return 'This payment method is currently unavailable.';
  }

  String get formattedAmount {
    final amount = arguments.amount;
    final hasDecimal = amount % 1 != 0;

    return hasDecimal
        ? amount.toStringAsFixed(2)
        : amount.toStringAsFixed(0);
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(
    AppLifecycleState state,
  ) {
    if (state == AppLifecycleState.resumed &&
        _activeKhaltiPidx != null &&
        !_isFinishingKhaltiPayment) {
      _checkKhaltiPaymentStatus();

      if (_khaltiPollingTimer == null) {
        _startKhaltiStatusPolling();
      }
    }
  }

  String? validateMobile(String? value) {
    // Khalti and eSewa collect account details securely
    // inside their own checkout interfaces.
    return null;
  }

  Future<void> proceedPayment() async {
    if (isProcessing.value) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    if (isCashOnDelivery) {
      await _placeCashOnDeliveryOrder();
      return;
    }

    if (isKhalti) {
      await _startKhaltiPayment();
      return;
    }

    if (isEsewa) {
      await _startEsewaPayment();
      return;
    }

    Get.snackbar(
      'Payment unavailable',
      'This payment method is not supported.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  Future<void> _placeCashOnDeliveryOrder() async {
    isProcessing.value = true;
    processingMessage.value = 'Placing your order...';

    try {
      await paymentService.placeCashOnDeliveryOrder(
        orderId: arguments.orderId,
        amount: arguments.amount,
      );

      _openOrderSuccess(
        paymentMethod: arguments.paymentMethod,
      );
    } catch (error) {
      _showFailure(
        title: 'Order failed',
        message: 'Could not place your order. Please try again.',
      );
    } finally {
      isProcessing.value = false;
      processingMessage.value = '';
    }
  }

  Future<void> _startKhaltiPayment() async {
    isProcessing.value = true;
    processingMessage.value = 'Initiating Khalti payment...';

    try {
      final initiation =
          await paymentService.initiateKhaltiPayment(
        orderId: arguments.orderId,
        amount: arguments.amount,
      );

      final pidx = initiation['pidx']?.toString();
      final paymentUrl =
          initiation['payment_url']?.toString();

      if (pidx == null ||
          pidx.isEmpty ||
          paymentUrl == null ||
          paymentUrl.isEmpty) {
        throw const FormatException(
          'Khalti did not return valid payment information.',
        );
      }

      _activeKhaltiPidx = pidx;

      processingMessage.value =
          'Opening Khalti Sandbox...';

      await _openKhaltiCheckout(
        pidx: pidx,
        paymentUrl: paymentUrl,
      );
    } on DioException catch (error) {
      _showFailure(
        title: 'Khalti payment failed',
        message: paymentService.getDioErrorMessage(error),
      );

      isProcessing.value = false;
      processingMessage.value = '';
    } catch (error) {
      _showFailure(
        title: 'Khalti payment failed',
        message: error.toString(),
      );

      isProcessing.value = false;
      processingMessage.value = '';
    }
  }

  Future<void> _openKhaltiCheckout({
    required String pidx,
    required String paymentUrl,
  }) async {
    final context = Get.context;

    if (context == null) {
      throw StateError(
        'Unable to open Khalti checkout.',
      );
    }

    _khaltiCheckoutContext = context;
    _isKhaltiCheckoutOpen = true;
    _khaltiPollingAttempts = 0;

    final payConfig = khalti_sdk.KhaltiPayConfig(
      publicKey: _khaltiPublicKey,
      pidx: pidx,
      paymentUrl: paymentUrl,
      environment: khalti_sdk.Environment.test,
    );

    final khalti = await khalti_sdk.Khalti.init(
      enableDebugging: true,
      payConfig: payConfig,

      onPaymentResult: (
        paymentResult,
        khaltiInstance,
      ) async {
        _activeKhalti = khaltiInstance;

        debugPrint(
          'Khalti payment result: $paymentResult',
        );

        await _checkKhaltiPaymentStatus();
      },

      onMessage: (
        khaltiInstance, {
        description,
        statusCode,
        event,
        needsPaymentConfirmation,
      }) async {
        _activeKhalti = khaltiInstance;

        debugPrint(
          'Khalti message: '
          'description=$description, '
          'statusCode=$statusCode, '
          'event=$event, '
          'needsPaymentConfirmation='
          '$needsPaymentConfirmation',
        );

        if (needsPaymentConfirmation == true) {
          try {
            processingMessage.value =
                'Confirming Khalti payment...';

            await khaltiInstance.verify();
          } catch (error) {
            debugPrint(
              'Khalti SDK verification error: $error',
            );
          }

          await _checkKhaltiPaymentStatus();
          return;
        }

        if (event ==
            khalti_sdk.KhaltiEvent.kpgDisposed) {
          _isKhaltiCheckoutOpen = false;

          await _checkKhaltiPaymentStatus();
        }
      },

      onReturn: () async {
        debugPrint(
          'Khalti return URL loaded.',
        );

        await _checkKhaltiPaymentStatus();
      },
    );

    _activeKhalti = khalti;

    khalti.open(context);

    _startKhaltiStatusPolling();
  }

  void _startKhaltiStatusPolling() {
    _stopKhaltiStatusPolling();

    _khaltiPollingTimer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) async {
        if (isClosed ||
            _activeKhaltiPidx == null ||
            _isFinishingKhaltiPayment) {
          timer.cancel();
          return;
        }

        _khaltiPollingAttempts++;

        if (_khaltiPollingAttempts >
            _maximumKhaltiPollingAttempts) {
          _stopKhaltiStatusPolling();

          if (!_isKhaltiCheckoutOpen) {
            isProcessing.value = false;
            processingMessage.value = '';

            _showKhaltiPendingDialog();
          }

          return;
        }

        await _checkKhaltiPaymentStatus();
      },
    );
  }

  void _stopKhaltiStatusPolling() {
    _khaltiPollingTimer?.cancel();
    _khaltiPollingTimer = null;
  }


  Future<void> _checkKhaltiPaymentStatus() async {
    final pidx = _activeKhaltiPidx;

    if (pidx == null ||
        pidx.isEmpty ||
        _isKhaltiLookupRunning ||
        _isFinishingKhaltiPayment) {
      return;
    }

    _isKhaltiLookupRunning = true;

    try {
      final result =
          await paymentService.lookupKhaltiPayment(
        pidx: pidx,
      );

      final rawStatus =
          result['status']?.toString().trim();

      final status = rawStatus?.toLowerCase();

      final transactionId =
          result['transaction_id']?.toString();

      debugPrint(
        'Khalti backend lookup: '
        'pidx=$pidx, '
        'status=$rawStatus, '
        'transactionId=$transactionId',
      );

      if (status == 'completed') {
        await _completeKhaltiPayment(
          transactionId: transactionId,
        );

        return;
      }

      if (status == 'pending' ||
          status == 'initiated') {
        processingMessage.value =
            'Waiting for Khalti confirmation...';

        return;
      }

      if (status == 'user canceled' ||
          status == 'cancelled' ||
          status == 'canceled' ||
          status == 'expired' ||
          status == 'failed' ||
          status == 'refunded') {
        await _finishKhaltiWithFailure(
          status: rawStatus ?? 'Unknown',
        );
      }
    } on DioException catch (error) {
      debugPrint(
        'Khalti lookup network error: '
        '${paymentService.getDioErrorMessage(error)}',
      );

      // Do not stop polling for a temporary network error.
      // The next timer iteration will retry.
    } catch (error, stackTrace) {
      debugPrint(
        'Khalti lookup error: $error\n$stackTrace',
      );
    } finally {
      _isKhaltiLookupRunning = false;
    }
  }

  Future<void> _completeKhaltiPayment({
    String? transactionId,
  }) async {
    if (_isFinishingKhaltiPayment) {
      return;
    }

    _isFinishingKhaltiPayment = true;
    _stopKhaltiStatusPolling();

    processingMessage.value =
        'Payment completed. Finishing...';

    final khalti = _activeKhalti;
    final checkoutContext = _khaltiCheckoutContext;

    _isKhaltiCheckoutOpen = false;

    if (khalti != null &&
        checkoutContext != null) {
      try {
        khalti.close(checkoutContext);
      } catch (error) {
        debugPrint(
          'Could not close Khalti checkout: $error',
        );
      }
    }

    await Future<void>.delayed(
      const Duration(milliseconds: 400),
    );

    if (isClosed) {
      return;
    }

    _clearKhaltiPaymentState();

    isProcessing.value = false;
    processingMessage.value = '';

    _openOrderSuccess(
      paymentMethod: arguments.paymentMethod,
      transactionId: transactionId,
    );
  }

  Future<void> _finishKhaltiWithFailure({
    required String status,
  }) async {
    if (_isFinishingKhaltiPayment) {
      return;
    }

    _isFinishingKhaltiPayment = true;
    _stopKhaltiStatusPolling();

    final khalti = _activeKhalti;
    final checkoutContext = _khaltiCheckoutContext;

    _isKhaltiCheckoutOpen = false;

    if (khalti != null &&
        checkoutContext != null) {
      try {
        khalti.close(checkoutContext);
      } catch (error) {
        debugPrint(
          'Could not close Khalti checkout: $error',
        );
      }
    }

    await Future<void>.delayed(
      const Duration(milliseconds: 300),
    );

    _clearKhaltiPaymentState();

    isProcessing.value = false;
    processingMessage.value = '';

    _showFailure(
      title: 'Payment not completed',
      message: 'Khalti payment status: $status',
    );
  }

  void _showKhaltiPendingDialog() {
    if (Get.isDialogOpen == true) {
      return;
    }

    Get.dialog<void>(
      AlertDialog(
        title: const Text(
          'Payment verification pending',
        ),
        content: const Text(
          'Khalti received the payment, but the '
          'final status is still pending.\n\n'
          'You can retry verification without '
          'making another payment.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back<void>();
            },
            child: const Text('CLOSE'),
          ),
          FilledButton(
            onPressed: () {
              Get.back<void>();

              isProcessing.value = true;
              processingMessage.value =
                  'Verifying Khalti payment...';

              _khaltiPollingAttempts = 0;

              _startKhaltiStatusPolling();
              _checkKhaltiPaymentStatus();
            },
            child: const Text('RETRY'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _clearKhaltiPaymentState() {
    _stopKhaltiStatusPolling();

    _activeKhalti = null;
    _activeKhaltiPidx = null;
    _khaltiCheckoutContext = null;

    _isKhaltiCheckoutOpen = false;
    _isKhaltiLookupRunning = false;
    _isFinishingKhaltiPayment = false;

    _khaltiPollingAttempts = 0;
  }

  Future<void> _startEsewaPayment() async {
    if (isProcessing.value) {
      return;
    }

    if (_pendingEsewaRefId != null) {
      _showEsewaVerificationDialog(
        title: 'Payment already completed',
        message:
            'An eSewa payment is waiting for backend '
            'verification.\n\n'
            'Reference ID: $_pendingEsewaRefId\n\n'
            'Retry verification instead of making '
            'another payment.',
      );

      return;
    }

    isProcessing.value = true;
    processingMessage.value = 'Opening eSewa Sandbox...';

    final timestamp =
        DateTime.now().millisecondsSinceEpoch;

    final productId = arguments.orderId != null
        ? 'ORDER-${arguments.orderId}-$timestamp'
        : 'ORDER-$timestamp';

    final amount = arguments.amount.toStringAsFixed(2);

    debugPrint(
      'Opening eSewa: '
      'productId=$productId, '
      'amount=$amount',
    );

    try {
      esewa_sdk.EsewaFlutterSdk.initPayment(
        esewaConfig: esewa_sdk.EsewaConfig(
          environment: esewa_sdk.Environment.test,
          clientId: _esewaClientId,
          secretId: _esewaSecretKey,
        ),
        esewaPayment: esewa_sdk.EsewaPayment(
          productId: productId,
          productName: 'ShopEase Order',
          productPrice: amount,
          callbackUrl:
              'https://sandbox-payment-api.onrender.com/payment/esewa/callback',
        ),
        onPaymentSuccess: (
          esewa_sdk.EsewaPaymentSuccessResult result,
        ) async {
          debugPrint(
            'eSewa success: '
            'refId=${result.refId}, '
            'productId=${result.productId}, '
            'amount=${result.totalAmount}, '
            'status=${result.status}',
          );

          processingMessage.value =
              'Verifying eSewa payment...';

          await _verifyEsewaPayment(
            refId: result.refId,
            productId: result.productId,
            amount: result.totalAmount,
            sdkStatus: result.status,
          );
        },
        onPaymentFailure: (data) {
          debugPrint('eSewa failure: $data');

          _clearPendingEsewaVerification();

          isProcessing.value = false;
          processingMessage.value = '';

          _showFailure(
            title: 'eSewa payment failed',
            message: data.toString(),
          );
        },
        onPaymentCancellation: (data) {
          debugPrint('eSewa cancellation: $data');

          _clearPendingEsewaVerification();

          isProcessing.value = false;
          processingMessage.value = '';

          Get.snackbar(
            'Payment cancelled',
            'The eSewa payment was cancelled.',
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(16),
          );
        },
      );

      await Future<void>.delayed(
        const Duration(seconds: 5),
      );

      if (!isClosed &&
          isProcessing.value &&
          processingMessage.value ==
              'Opening eSewa Sandbox...') {
        isProcessing.value = false;
        processingMessage.value = '';

        _showFailure(
          title: 'Could not open eSewa',
          message:
              'The eSewa checkout did not open. '
              'Check the Android configuration and '
              'the Flutter terminal logs.',
        );
      }
    } catch (error, stackTrace) {
      debugPrint(
        'eSewa initialization error: '
        '$error\n$stackTrace',
      );

      isProcessing.value = false;
      processingMessage.value = '';

      _showFailure(
        title: 'Could not open eSewa',
        message: error.toString(),
      );
    }
  }

  Future<void> _verifyEsewaPayment({
    required String refId,
    required String productId,
    required String amount,
    required String sdkStatus,
  }) async {
    if (_isEsewaVerificationRunning) {
      return;
    }

    _pendingEsewaRefId = refId;
    _pendingEsewaProductId = productId;
    _pendingEsewaAmount = amount;
    _pendingEsewaSdkStatus = sdkStatus;

    _isEsewaVerificationRunning = true;
    isProcessing.value = true;
    processingMessage.value =
        'Verifying eSewa payment...';

    try {
      final response =
          await paymentService.verifyEsewaPayment(
        refId: refId,
        productId: productId,
        amount: amount,
      );

      final success = response['success'] == true;

      final data = response['data'] is Map
          ? Map<String, dynamic>.from(
              response['data'] as Map,
            )
          : <String, dynamic>{};

      final verified = data['verified'] == true;

      final status = data['status']
          ?.toString()
          .trim()
          .toUpperCase();

      if (success &&
          verified &&
          status == 'COMPLETE') {
        final transactionId =
            data['reference_id']?.toString() ??
                refId;

        _clearPendingEsewaVerification();

        isProcessing.value = false;
        processingMessage.value = '';

        _openOrderSuccess(
          paymentMethod: arguments.paymentMethod,
          transactionId: transactionId,
        );

        return;
      }

      isProcessing.value = false;
      processingMessage.value = '';

      _showEsewaVerificationDialog(
        title: 'Payment not verified',
        message:
            'The eSewa payment has not been verified yet.\n\n'
            'SDK status: $sdkStatus\n'
            'Backend status: ${status ?? 'Unknown'}',
      );
    } on DioException catch (error) {
      isProcessing.value = false;
      processingMessage.value = '';

      final responseData = error.response?.data;

      String? backendCode;
      String? backendMessage;

      if (responseData is Map) {
        final detail = responseData['detail'];

        if (detail is Map) {
          backendCode = detail['code']?.toString();
          backendMessage =
              detail['message']?.toString();
        } else if (detail != null) {
          backendMessage = detail.toString();
        }
      }

      if (error.response?.statusCode == 502 &&
          backendCode ==
              'ESEWA_SANDBOX_UNAVAILABLE') {
        _showEsewaVerificationDialog(
          title: 'Verification pending',
          message:
              'The eSewa sandbox payment completed, '
              'but its verification service is temporarily '
              'unavailable.\n\n'
              'Reference ID: $refId\n\n'
              'You can retry verification without making '
              'another payment.',
        );

        return;
      }

      if (error.response?.statusCode == 404) {
        _showEsewaVerificationDialog(
          title: 'Transaction not found',
          message:
              backendMessage ??
              'The eSewa verification service could not '
                  'find this transaction yet.\n\n'
                  'Reference ID: $refId\n\n'
                  'Wait briefly and retry verification.',
        );

        return;
      }

      _showEsewaVerificationDialog(
        title: 'eSewa verification failed',
        message:
            backendMessage ??
            paymentService.getDioErrorMessage(error),
      );
    } catch (error) {
      isProcessing.value = false;
      processingMessage.value = '';

      _showEsewaVerificationDialog(
        title: 'eSewa verification failed',
        message: error.toString(),
      );
    } finally {
      _isEsewaVerificationRunning = false;
    }
  }

  Future<void> retryEsewaVerification() async {
    if (_isEsewaVerificationRunning ||
        isProcessing.value) {
      return;
    }

    final refId = _pendingEsewaRefId;
    final productId = _pendingEsewaProductId;
    final amount = _pendingEsewaAmount;
    final sdkStatus = _pendingEsewaSdkStatus;

    if (refId == null ||
        productId == null ||
        amount == null ||
        sdkStatus == null) {
      _showFailure(
        title: 'Unable to retry',
        message:
            'The eSewa transaction information is no longer available.',
      );

      return;
    }

    await _verifyEsewaPayment(
      refId: refId,
      productId: productId,
      amount: amount,
      sdkStatus: sdkStatus,
    );
  }

  void _showEsewaVerificationDialog({
    required String title,
    required String message,
  }) {
    if (Get.isDialogOpen == true) {
      Get.back<void>();
    }

    Get.dialog<void>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back<void>();
            },
            child: const Text('CLOSE'),
          ),
          FilledButton(
            onPressed: () async {
              Get.back<void>();

              await Future<void>.delayed(
                const Duration(milliseconds: 250),
              );

              await retryEsewaVerification();
            },
            child: const Text(
              'RETRY VERIFICATION',
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _clearPendingEsewaVerification() {
    _pendingEsewaRefId = null;
    _pendingEsewaProductId = null;
    _pendingEsewaAmount = null;
    _pendingEsewaSdkStatus = null;
  }

  void _openOrderSuccess({
    required String paymentMethod,
    String? transactionId,
  }) {
    final fallbackOrderId =
        'TEMP-${DateTime.now().millisecondsSinceEpoch}';

    final orderId = arguments.orderId?.toString() ??
        transactionId ??
        fallbackOrderId;

    final successArguments = OrderSuccessArguments(
      orderId: orderId,
      paymentMethod: paymentMethod,
      amount: arguments.amount,
    );

    Get.off(
      () => OrderSuccessScreen(
        arguments: successArguments,
      ),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 250),
    );
  }

  void _showFailure({
    required String title,
    required String message,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 5),
    );
  }

  void goBack() {
    if (!isProcessing.value) {
      Get.back();
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);

    _stopKhaltiStatusPolling();
    _clearKhaltiPaymentState();
    _clearPendingEsewaVerification();

    mobileController.dispose();
    mobileFocusNode.dispose();

    super.onClose();
  }
}