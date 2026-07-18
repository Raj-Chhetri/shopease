import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/payment_controller.dart';
import 'package:shopease/models/payment_method.dart';

class PaymentScreen extends StatelessWidget {
  static const Color _primaryColor = Color(0xFF6D28FF);

  final double amount;
  final int? orderId;

  const PaymentScreen({
    super.key,
    required this.amount,
    this.orderId,
  });

  Widget _paymentOption({
    required BuildContext context,
    required PaymentController controller,
    required int index,
    required PaymentMethod method,
    required bool isSmall,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Obx(() {
      final isSelected =
          controller.selectedMethodIndex.value == index;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: isSelected
              ? _primaryColor.withValues(
                  alpha: isDark ? 0.22 : 0.10,
                )
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: InkWell(
          onTap: method.enabled
              ? () => controller.selectPaymentMethod(index)
              : null,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 4 : 8,
              vertical: isSmall ? 9 : 12,
            ),
            child: Row(
              children: [
                Transform.scale(
                  scale: isSmall ? 0.9 : 1,
                  child: Radio<int>(
                    value: index,
                    groupValue:
                        controller.selectedMethodIndex.value,
                    activeColor: _primaryColor,
                    onChanged: method.enabled
                        ? (value) {
                            if (value != null) {
                              controller.selectPaymentMethod(
                                value,
                              );
                            }
                          }
                        : null,
                  ),
                ),
                SizedBox(width: isSmall ? 4 : 8),
                Container(
                  width: isSmall ? 42 : 52,
                  height: isSmall ? 42 : 52,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: isDark
                        ? theme
                            .colorScheme
                            .surfaceContainerHighest
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.colorScheme.outlineVariant,
                    ),
                  ),
                  child: Image.asset(
                    method.asset,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      return Icon(
                        method.isCashOnDelivery
                            ? Icons.local_shipping_outlined
                            : Icons
                                .account_balance_wallet_outlined,
                        color: method.color,
                        size: isSmall ? 24 : 30,
                      );
                    },
                  ),
                ),
                SizedBox(width: isSmall ? 12 : 18),
                Expanded(
                  child: Text(
                    method.name,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: isSmall ? 15 : 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (!method.enabled)
                  Text(
                    'Unavailable',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      PaymentController(
        amount: amount,
        orderId: orderId,
      ),
      tag: 'payment-$orderId-$amount',
    );

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'Payment',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth < 380;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                isSmall ? 14 : 20,
                8,
                isSmall ? 14 : 20,
                28,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 520,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: theme.colorScheme.outlineVariant,
                      ),
                      SizedBox(height: isSmall ? 14 : 22),
                      Text(
                        'Select Payment Method',
                        style:
                            theme.textTheme.titleLarge?.copyWith(
                          fontSize: isSmall ? 17 : 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Choose how you would like to complete your order.',
                        style:
                            theme.textTheme.bodyMedium?.copyWith(
                          color: theme
                              .colorScheme
                              .onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: isSmall ? 14 : 20),
                      Container(
                        padding: EdgeInsets.all(
                          isSmall ? 8 : 12,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius:
                              BorderRadius.circular(22),
                          border: Border.all(
                            color: theme
                                .colorScheme
                                .outlineVariant,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: isDark ? 0.22 : 0.08,
                              ),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: List.generate(
                            controller.paymentMethods.length,
                            (index) {
                              final method =
                                  controller.paymentMethods[index];

                              return Column(
                                children: [
                                  _paymentOption(
                                    context: context,
                                    controller: controller,
                                    index: index,
                                    method: method,
                                    isSmall: isSmall,
                                  ),
                                  if (index <
                                      controller.paymentMethods
                                              .length -
                                          1)
                                    Divider(
                                      height: 1,
                                      indent: 12,
                                      endIndent: 12,
                                      color: theme
                                          .colorScheme
                                          .outlineVariant,
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: isSmall ? 22 : 30),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmall ? 18 : 24,
                          vertical: isSmall ? 20 : 26,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? theme.colorScheme
                                  .surfaceContainerHighest
                              : const Color(0xFFF7F3FF),
                          borderRadius:
                              BorderRadius.circular(22),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Amount',
                                    style: theme
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                      color: theme.colorScheme
                                          .onSurfaceVariant,
                                      fontWeight:
                                          FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: isSmall ? 8 : 12,
                                  ),
                                  FittedBox(
                                    alignment:
                                        Alignment.centerLeft,
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Rs. ${controller.formatAmount(amount)}',
                                      style: TextStyle(
                                        fontSize:
                                            isSmall ? 32 : 40,
                                        fontWeight:
                                            FontWeight.w900,
                                        color: _primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: isSmall ? 62 : 78,
                              height: isSmall ? 62 : 78,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _primaryColor.withValues(
                                  alpha: 0.12,
                                ),
                              ),
                              child: Icon(
                                Icons
                                    .account_balance_wallet_rounded,
                                color: _primaryColor,
                                size: isSmall ? 32 : 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: isSmall ? 24 : 32),
                      SizedBox(
                        width: double.infinity,
                        height: isSmall ? 54 : 62,
                        child: FilledButton(
                          onPressed:
                              controller.continueToPayment,
                          style: FilledButton.styleFrom(
                            backgroundColor: _primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(18),
                            ),
                          ),
                          child: Text(
                            'PAY NOW',
                            style: TextStyle(
                              fontSize: isSmall ? 18 : 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}