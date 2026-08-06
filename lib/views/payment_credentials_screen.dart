// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:shopease/controller/payment_credentials_controller.dart';
// import 'package:shopease/models/payment_credentials_arguments.dart';
// import 'package:shopease/services/payment_service.dart';

// class PaymentCredentialsScreen extends StatelessWidget {
//   static const Color _primaryColor = Color(0xFF6D28FF);

//   final PaymentCredentialsArguments arguments;

//   const PaymentCredentialsScreen({
//     super.key,
//     required this.arguments,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(
//       PaymentCredentialsController(
//         arguments: arguments,
//         paymentService: Get.find<PaymentService>(),
//       ),
//       tag:
//           'credentials-${arguments.orderId}-${arguments.paymentMethodId}',
//     );

//     final theme = Theme.of(context);

//     return Obx(
//       () => PopScope(
//         canPop: !controller.isProcessing.value,
//         child: Scaffold(
//           backgroundColor: theme.scaffoldBackgroundColor,
//           appBar: AppBar(
//             backgroundColor:
//                 theme.scaffoldBackgroundColor,
//             surfaceTintColor: Colors.transparent,
//             elevation: 0,
//             leading: IconButton(
//               onPressed: controller.isProcessing.value
//                   ? null
//                   : controller.goBack,
//               tooltip: 'Back',
//               icon: const Icon(
//                 Icons.arrow_back_rounded,
//               ),
//             ),
//             title: Text(
//               arguments.paymentMethod,
//               style: theme.textTheme.titleLarge?.copyWith(
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//           ),
//           body: SafeArea(
//             top: false,
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 final isCompact =
//                     constraints.maxWidth < 380;

//                 return Center(
//                   child: ConstrainedBox(
//                     constraints: const BoxConstraints(
//                       maxWidth: 460,
//                     ),
//                     child: SingleChildScrollView(
//                       keyboardDismissBehavior:
//                           ScrollViewKeyboardDismissBehavior
//                               .onDrag,
//                       padding: EdgeInsets.symmetric(
//                         horizontal:
//                             isCompact ? 16 : 24,
//                         vertical: 20,
//                       ),
//                       child: Form(
//                         key: controller.formKey,
//                         child: Column(
//                           crossAxisAlignment:
//                               CrossAxisAlignment.stretch,
//                           children: [
//                             Center(
//                               child: Container(
//                                 width:
//                                     isCompact ? 88 : 108,
//                                 height:
//                                     isCompact ? 88 : 108,
//                                 padding:
//                                     const EdgeInsets.all(20),
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: arguments.paymentColor
//                                       .withValues(
//                                     alpha: 0.12,
//                                   ),
//                                 ),
//                                 child: Image.asset(
//                                   arguments.paymentAsset,
//                                   fit: BoxFit.contain,
//                                   errorBuilder:
//                                       (_, __, ___) {
//                                     return Icon(
//                                       arguments
//                                               .isCashOnDelivery
//                                           ? Icons
//                                               .payments_outlined
//                                           : Icons
//                                               .account_balance_wallet_outlined,
//                                       color: arguments
//                                           .paymentColor,
//                                       size: 48,
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//                             Text(
//                               arguments.isCashOnDelivery
//                                   ? 'Confirm Your Order'
//                                   : '${arguments.paymentMethod} Payment',
//                               textAlign: TextAlign.center,
//                               style: theme
//                                   .textTheme
//                                   .headlineSmall
//                                   ?.copyWith(
//                                 fontWeight:
//                                     FontWeight.w900,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Text(
//                               controller.instruction,
//                               textAlign: TextAlign.center,
//                               style: theme.textTheme.bodyMedium
//                                   ?.copyWith(
//                                 color: theme.colorScheme
//                                     .onSurfaceVariant,
//                                 height: 1.5,
//                               ),
//                             ),
//                             const SizedBox(height: 28),
//                             Container(
//                               padding:
//                                   const EdgeInsets.all(22),
//                               decoration: BoxDecoration(
//                                 color: theme.colorScheme
//                                     .surfaceContainerHighest,
//                                 borderRadius:
//                                     BorderRadius.circular(20),
//                               ),
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     'Payable Amount',
//                                     style: theme
//                                         .textTheme
//                                         .bodyLarge
//                                         ?.copyWith(
//                                       color: theme
//                                           .colorScheme
//                                           .onSurfaceVariant,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   FittedBox(
//                                     fit: BoxFit.scaleDown,
//                                     child: Text(
//                                       'Rs. ${controller.formattedAmount}',
//                                       style: theme.textTheme
//                                           .headlineMedium
//                                           ?.copyWith(
//                                         color: _primaryColor,
//                                         fontWeight:
//                                             FontWeight.w900,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             if (!arguments
//                                 .isCashOnDelivery) ...[
//                               const SizedBox(height: 28),
//                               TextFormField(
//                                 controller: controller
//                                     .mobileController,
//                                 focusNode:
//                                     controller.mobileFocusNode,
//                                 enabled: !controller
//                                     .isProcessing.value,
//                                 keyboardType:
//                                     TextInputType.phone,
//                                 textInputAction:
//                                     TextInputAction.done,
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter
//                                       .digitsOnly,
//                                   LengthLimitingTextInputFormatter(
//                                     10,
//                                   ),
//                                 ],
//                                 validator:
//                                     controller.validateMobile,
//                                 onFieldSubmitted: (_) {
//                                   controller
//                                       .proceedPayment();
//                                 },
//                                 decoration:
//                                     const InputDecoration(
//                                   labelText:
//                                       'Mobile Number',
//                                   hintText:
//                                       'Enter your mobile number',
//                                   prefixIcon: Icon(
//                                     Icons.phone_rounded,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               Text(
//                                 'Do not enter your real wallet password or PIN. '
//                                 'This screen is for UI simulation only.',
//                                 style: theme
//                                     .textTheme.bodySmall
//                                     ?.copyWith(
//                                   color:
//                                       theme.colorScheme.error,
//                                   height: 1.4,
//                                 ),
//                               ),
//                             ],
//                             const SizedBox(height: 30),
//                             SizedBox(
//                               height: 58,
//                               child: FilledButton(
//                                 onPressed: controller
//                                         .isProcessing.value
//                                     ? null
//                                     : controller
//                                         .proceedPayment,
//                                 style:
//                                     FilledButton.styleFrom(
//                                   backgroundColor:
//                                       _primaryColor,
//                                   shape:
//                                       RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.circular(
//                                       17,
//                                     ),
//                                   ),
//                                 ),
//                                 child: controller
//                                         .isProcessing.value
//                                     ? Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment
//                                                 .center,
//                                         children: [
//                                           const SizedBox(
//                                             width: 22,
//                                             height: 22,
//                                             child:
//                                                 CircularProgressIndicator(
//                                               color:
//                                                   Colors.white,
//                                               strokeWidth:
//                                                   2.5,
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             width: 12,
//                                           ),
//                                           Flexible(
//                                             child: Text(
//                                               controller
//                                                   .processingMessage
//                                                   .value,
//                                               overflow:
//                                                   TextOverflow
//                                                       .ellipsis,
//                                               style:
//                                                   const TextStyle(
//                                                 color: Colors
//                                                     .white,
//                                                 fontWeight:
//                                                     FontWeight
//                                                         .w700,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                     : Text(
//                                         arguments
//                                                 .isCashOnDelivery
//                                             ? 'PLACE ORDER'
//                                             : 'CONTINUE TO PAYMENT',
//                                         style:
//                                             const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight:
//                                               FontWeight.w800,
//                                         ),
//                                       ),
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             TextButton(
//                               onPressed: controller
//                                       .isProcessing.value
//                                   ? null
//                                   : controller.goBack,
//                               child: const Text('Cancel'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
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
            backgroundColor: theme.scaffoldBackgroundColor,
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
                      physics:
                          const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            isCompact ? 16 : 24,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                        children: [
                          _PaymentLogo(
                            arguments: arguments,
                            isCompact: isCompact,
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
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            controller.instruction,
                            textAlign: TextAlign.center,
                            style: theme
                                .textTheme.bodyMedium
                                ?.copyWith(
                              color: theme.colorScheme
                                  .onSurfaceVariant,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 28),
                          _AmountCard(
                            formattedAmount:
                                controller.formattedAmount,
                          ),
                          const SizedBox(height: 26),
                          _PaymentInformationCard(
                            arguments: arguments,
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 58,
                            child: FilledButton(
                              onPressed:
                                  controller.isProcessing.value
                                      ? null
                                      : controller
                                          .proceedPayment,
                              style: FilledButton.styleFrom(
                                backgroundColor:
                                    _primaryColor,
                                foregroundColor:
                                    Colors.white,
                                disabledBackgroundColor:
                                    _primaryColor.withValues(
                                  alpha: 0.55,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                    17,
                                  ),
                                ),
                              ),
                              child:
                                  controller.isProcessing.value
                                      ? _ProcessingContent(
                                          message: controller
                                              .processingMessage
                                              .value,
                                        )
                                      : Text(
                                          _buttonLabel(),
                                          style:
                                              const TextStyle(
                                            color:
                                                Colors.white,
                                            fontSize: 16,
                                            fontWeight:
                                                FontWeight.w800,
                                          ),
                                        ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed:
                                controller.isProcessing.value
                                    ? null
                                    : controller.goBack,
                            child: const Text('Cancel'),
                          ),
                        ],
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

  String _buttonLabel() {
    if (arguments.isCashOnDelivery) {
      return 'PLACE ORDER';
    }

    if (arguments.paymentMethodId == 'khalti') {
      return 'CONTINUE TO KHALTI';
    }

    if (arguments.paymentMethodId == 'esewa') {
      return 'CONTINUE TO ESEWA';
    }

    return 'CONTINUE TO PAYMENT';
  }
}

class _PaymentLogo extends StatelessWidget {
  const _PaymentLogo({
    required this.arguments,
    required this.isCompact,
  });

  final PaymentCredentialsArguments arguments;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: isCompact ? 88 : 108,
        height: isCompact ? 88 : 108,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: arguments.paymentColor.withValues(
            alpha: 0.12,
          ),
        ),
        child: Image.asset(
          arguments.paymentAsset,
          fit: BoxFit.contain,
          errorBuilder: (_, _, _) {
            return Icon(
              arguments.isCashOnDelivery
                  ? Icons.local_shipping_outlined
                  : Icons.account_balance_wallet_outlined,
              color: arguments.paymentColor,
              size: 48,
            );
          },
        ),
      ),
    );
  }
}

class _AmountCard extends StatelessWidget {
  static const Color _primaryColor = Color(0xFF6D28FF);

  const _AmountCard({
    required this.formattedAmount,
  });

  final String formattedAmount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color:
            theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Payable Amount',
            style: theme.textTheme.bodyLarge?.copyWith(
              color:
                  theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Rs. $formattedAmount',
              style:
                  theme.textTheme.headlineMedium?.copyWith(
                color: _primaryColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentInformationCard extends StatelessWidget {
  const _PaymentInformationCard({
    required this.arguments,
  });

  final PaymentCredentialsArguments arguments;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final title = arguments.isCashOnDelivery
        ? 'Cash on Delivery'
        : 'Secure sandbox checkout';

    final description =
        arguments.isCashOnDelivery
            ? 'You will pay when your order is delivered.'
            : 'Your wallet details, password, PIN and OTP '
                'will be entered only inside the official '
                '${arguments.paymentMethod} sandbox checkout.';

    final icon = arguments.isCashOnDelivery
        ? Icons.local_shipping_outlined
        : Icons.verified_user_outlined;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: arguments.paymentColor.withValues(
                alpha: 0.12,
              ),
            ),
            child: Icon(
              icon,
              color: arguments.paymentColor,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style:
                      theme.textTheme.bodySmall?.copyWith(
                    color: theme
                        .colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProcessingContent extends StatelessWidget {
  const _ProcessingContent({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.5,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            message.isEmpty
                ? 'Please wait...'
                : message,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}