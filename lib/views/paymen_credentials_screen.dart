import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/payment_credentials_controller.dart';
import 'package:shopease/models/payment_credentials_arguments.dart';
import 'package:shopease/services/payment_service.dart';

class PaymentCredentialsScreen extends StatelessWidget {
  static const Color _primaryColor = Color(0xFF6D28FF);

  final PaymentCredentialsArguments arguments;

  const PaymentCredentialsScreen({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      PaymentCredentialsController(
        arguments: arguments,
        paymentService: Get.find<PaymentService>(),
      ),
      tag:
          'credentials-${arguments.orderId}-${arguments.paymentMethodId}',
    );

    final theme = Theme.of(context);

    return Obx(
      () => PopScope(
        canPop: !controller.isProcessing.value,
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor:
                theme.scaffoldBackgroundColor,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: controller.isProcessing.value
                  ? null
                  : controller.goBack,
              tooltip: 'Back',
              icon: const Icon(
                Icons.arrow_back_rounded,
              ),
            ),
            title: Text(
              arguments.paymentMethod,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          body: SafeArea(
            top: false,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact =
                    constraints.maxWidth < 380;

                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 460,
                    ),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior
                              .onDrag,
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            isCompact ? 16 : 24,
                        vertical: 20,
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Container(
                                width:
                                    isCompact ? 88 : 108,
                                height:
                                    isCompact ? 88 : 108,
                                padding:
                                    const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: arguments.paymentColor
                                      .withValues(
                                    alpha: 0.12,
                                  ),
                                ),
                                child: Image.asset(
                                  arguments.paymentAsset,
                                  fit: BoxFit.contain,
                                  errorBuilder:
                                      (_, __, ___) {
                                    return Icon(
                                      arguments
                                              .isCashOnDelivery
                                          ? Icons
                                              .payments_outlined
                                          : Icons
                                              .account_balance_wallet_outlined,
                                      color: arguments
                                          .paymentColor,
                                      size: 48,
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              arguments.isCashOnDelivery
                                  ? 'Confirm Your Order'
                                  : '${arguments.paymentMethod} Payment',
                              textAlign: TextAlign.center,
                              style: theme
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                fontWeight:
                                    FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              controller.instruction,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: theme.colorScheme
                                    .onSurfaceVariant,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 28),
                            Container(
                              padding:
                                  const EdgeInsets.all(22),
                              decoration: BoxDecoration(
                                color: theme.colorScheme
                                    .surfaceContainerHighest,
                                borderRadius:
                                    BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Payable Amount',
                                    style: theme
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                      color: theme
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Rs. ${controller.formattedAmount}',
                                      style: theme.textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                        color: _primaryColor,
                                        fontWeight:
                                            FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!arguments
                                .isCashOnDelivery) ...[
                              const SizedBox(height: 28),
                              TextFormField(
                                controller: controller
                                    .mobileController,
                                focusNode:
                                    controller.mobileFocusNode,
                                enabled: !controller
                                    .isProcessing.value,
                                keyboardType:
                                    TextInputType.phone,
                                textInputAction:
                                    TextInputAction.done,
                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .digitsOnly,
                                  LengthLimitingTextInputFormatter(
                                    10,
                                  ),
                                ],
                                validator:
                                    controller.validateMobile,
                                onFieldSubmitted: (_) {
                                  controller
                                      .proceedPayment();
                                },
                                decoration:
                                    const InputDecoration(
                                  labelText:
                                      'Mobile Number',
                                  hintText:
                                      'Enter your mobile number',
                                  prefixIcon: Icon(
                                    Icons.phone_rounded,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Do not enter your real wallet password or PIN. '
                                'This screen is for UI simulation only.',
                                style: theme
                                    .textTheme.bodySmall
                                    ?.copyWith(
                                  color:
                                      theme.colorScheme.error,
                                  height: 1.4,
                                ),
                              ),
                            ],
                            const SizedBox(height: 30),
                            SizedBox(
                              height: 58,
                              child: FilledButton(
                                onPressed: controller
                                        .isProcessing.value
                                    ? null
                                    : controller
                                        .proceedPayment,
                                style:
                                    FilledButton.styleFrom(
                                  backgroundColor:
                                      _primaryColor,
                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                      17,
                                    ),
                                  ),
                                ),
                                child: controller
                                        .isProcessing.value
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                        children: [
                                          const SizedBox(
                                            width: 22,
                                            height: 22,
                                            child:
                                                CircularProgressIndicator(
                                              color:
                                                  Colors.white,
                                              strokeWidth:
                                                  2.5,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Flexible(
                                            child: Text(
                                              controller
                                                  .processingMessage
                                                  .value,
                                              overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                              style:
                                                  const TextStyle(
                                                color: Colors
                                                    .white,
                                                fontWeight:
                                                    FontWeight
                                                        .w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        arguments
                                                .isCashOnDelivery
                                            ? 'PLACE ORDER'
                                            : 'CONTINUE TO PAYMENT',
                                        style:
                                            const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight:
                                              FontWeight.w800,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: controller
                                      .isProcessing.value
                                  ? null
                                  : controller.goBack,
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}