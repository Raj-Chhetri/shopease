import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/order_success_controller.dart';
import 'package:shopease/models/order_success_arguments.dart';

class OrderSuccessScreen extends StatelessWidget {
  final OrderSuccessArguments arguments;

  const OrderSuccessScreen({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      OrderSuccessController(),
      tag: 'success-${arguments.orderId}',
    );

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;
            final isSmall = screenWidth < 380;
            final isShort = screenHeight < 700;

            return Stack(
              alignment: Alignment.topCenter,
              children: [
                ConfettiWidget(
                  confettiController:
                      controller.confettiController,
                  blastDirectionality:
                      BlastDirectionality.explosive,
                  shouldLoop: false,
                  numberOfParticles: 18,
                  emissionFrequency: 0.035,
                  gravity: 0.12,
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 430,
                    ),
                    child: SingleChildScrollView(
                      physics:
                          const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmall ? 18 : 24,
                        vertical: isShort ? 20 : 30,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: isShort ? 18 : 55,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: isSmall ? 125 : 160,
                                height: isSmall ? 125 : 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(
                                    0xFF4CD137,
                                  ).withValues(alpha: 0.08),
                                ),
                              ),
                              Container(
                                width: isSmall ? 95 : 115,
                                height: isSmall ? 95 : 115,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(
                                    0xFF4CD137,
                                  ).withValues(alpha: 0.14),
                                ),
                              ),
                              Container(
                                width: isSmall ? 68 : 82,
                                height: isSmall ? 68 : 82,
                                decoration:
                                    const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF4CD137),
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: isSmall ? 42 : 50,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: isSmall ? 28 : 40,
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Order Successful',
                              style: TextStyle(
                                fontSize:
                                    isSmall ? 31 : 38,
                                fontWeight:
                                    FontWeight.w900,
                                color: theme
                                    .colorScheme.onSurface,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: isSmall ? 10 : 16,
                          ),
                          Text(
                            'Thank you! Your order has been placed successfully.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isSmall ? 16 : 19,
                              height: 1.5,
                              color: theme.colorScheme
                                  .onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: isSmall ? 30 : 48,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(
                              isSmall ? 16 : 22,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme
                                  .surfaceContainerHighest,
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.receipt_long,
                                  color: Color(0xFF4CD137),
                                  size: 34,
                                ),
                                SizedBox(
                                  width: isSmall ? 14 : 22,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        'Order ID:',
                                        style: theme
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '#${arguments.orderId}',
                                        style: TextStyle(
                                          fontSize:
                                              isSmall
                                                  ? 24
                                                  : 28,
                                          color: const Color(
                                            0xFF4CD137,
                                          ),
                                          fontWeight:
                                              FontWeight
                                                  .w800,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        '${arguments.paymentMethod} • '
                                        'Rs. ${arguments.amount.toStringAsFixed(0)}',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: isShort ? 38 : 90,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: isSmall ? 56 : 64,
                            child: FilledButton.icon(
                              onPressed:
                                  controller.viewOrders,
                              icon: const Icon(
                                Icons
                                    .shopping_basket_outlined,
                              ),
                              label: const Text(
                                'View Orders',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: isSmall ? 16 : 22,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: isSmall ? 56 : 64,
                            child: OutlinedButton.icon(
                              onPressed: controller
                                  .continueShopping,
                              icon: const Icon(
                                Icons
                                    .shopping_bag_outlined,
                              ),
                              label: const Text(
                                'Continue Shopping',
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}