// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopease/views/order_tracking_view.dart';
// import 'package:shopease/views/product_detail.dart';
// import 'package:shopease/widgets/order_card_widget.dart';
// import 'package:shopease/widgets/order_details_card_widget.dart';

// class OrderDetailsView extends StatelessWidget {
//   const OrderDetailsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
       
//      backgroundColor: Colors.white,
//      appBar: AppBar(
//      backgroundColor: Colors.white,
//      surfaceTintColor: Colors.white,
//      elevation: 0,
//      centerTitle: true,

//     leading: IconButton(
//       onPressed: () {
//         Get.back();
//       },
//       icon: const Icon(
//         Icons.arrow_back,
//         color: Colors.black,
//         size: 28,
//       ),
//     ),
//     title: const Text(
//       "Order Details",
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 28,
//         fontWeight: FontWeight.bold,
//       ),
//     ), 
//   ),
      
//        body: SingleChildScrollView(          //completed mss
//         child: Column(
//           children: [
//             OrderDetailsCardWidget(
//             status: "Completed",
//             paymentMethod: "Paid by Cash on Delivery.",
//               message:"Your Order has been delivered and received successfully.",
//             ),
//             OrderInfoCard(
//              orderId: "213732676987",
//              orderPlacedOn: "25 Oct 2025",
//              deliveredOn: "27 Oct 2025",
//             paymentMethod: "Cash on Delivery",
//            ),
//             DeliveryAddressCard(
//             receiverName: "Snopiee",
//             phoneNumber: "9856045832",
//             address:
//           "Khaltemasina Buspark Area, near Nepal Tourism Hotel Management College, PKR",
//            onTap: () {},
//     ),
//     // Product Card Here
//         OrderCardWidget(
//          shopName: "Kathmandu Shop",
//          productName: "Nike Sneakers",
//          color: "White Orange",
//          price: "Rs. 3000",
//          total: "1",
//          qty: "1",
//          status: "Completed",
//          image: "https://www.bing.com/th/id/OIP.tJQjxbLRRaEt9B4OB546kAHaHw?w=193&h=202&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
       
//          leftButtonText: "Return/Refund",
//          rightButtonText: "Review",

//           onLeftTap: () {},
//           onRightTap: () {},

//         onTap: () {
//           Get.to(() => ProductDetail(productId: null,));
//         },
//       ),
//       //Product Details
//       PriceDetailsCard(
//       subtotalLabel: "Subtotal(1 item)",
//        subtotalAmount: "Rs. 3000",
//        shippingLabel: "Shipping Fee",
//        shippingAmount: "Rs. 120",
//         extraFeeLabel: "COD Handling Fee",
//         extraFeeAmount: "Rs. 8",
//         totalAmount: "Rs. 3128",
//         ),
//        OrderTrackingCard(
//        trackingMessage:
//       "27 Oct - Package delivered!",
//       onTap: () {
//        Get.to(
//        () => const OrderTrackingView(),
//      );
//    },
//  ),
//           ],
//         ),
//       ),
      
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/views/order_tracking_view.dart';
import 'package:shopease/views/product_detail.dart';
import 'package:shopease/widgets/order_card_widget.dart';
import 'package:shopease/widgets/order_details_card_widget.dart';

class OrderDetailsView extends StatefulWidget {
  final int orderId;

  const OrderDetailsView({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderDetailsView> createState() =>
      _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  static const Color _primaryColor = Color(0xFF6D28FF);

  bool _isLoading = true;
  bool _isPerformingAction = false;
  String? _errorMessage;

  _OrderDetailsData? _order;

  @override
  void initState() {
    super.initState();
    _loadOrderDetails();
  }

  Future<void> _loadOrderDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Backend integration:
      // GET /api/orders/${widget.orderId}
      //
      // final response = await orderService.getOrderDetails(
      //   widget.orderId,
      // );
      //
      // final orderJson =
      //     response.data['data'] as Map<String, dynamic>;
      //
      // final parsedOrder =
      //     _OrderDetailsData.fromJson(orderJson);

      await Future<void>.delayed(
        const Duration(milliseconds: 500),
      );

      if (!mounted) return;

      setState(() {
        _order = _OrderDetailsData.mock(
          orderId: widget.orderId,
        );
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            'Unable to load order details. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _openProduct(int productId) {
    Get.to(
      () => ProductDetail(
        productId: productId,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  void _openTracking() {
    Get.to(
      () => OrderTrackingView(
        orderId: widget.orderId,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  Future<bool> _showConfirmationDialog({
    required String title,
    required String message,
    required String confirmText,
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final theme = Theme.of(dialogContext);

        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: FilledButton.styleFrom(
                backgroundColor: isDestructive
                    ? theme.colorScheme.error
                    : theme.colorScheme.primary,
              ),
              child: Text(confirmText),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  Future<void> _cancelOrder() async {
    final order = _order;

    if (order == null || _isPerformingAction) {
      return;
    }

    final confirmed = await _showConfirmationDialog(
      title: 'Cancel order?',
      message:
          'Are you sure you want to cancel order '
          '#${order.orderNumber}?',
      confirmText: 'Cancel Order',
      isDestructive: true,
    );

    if (!confirmed || !mounted) return;

    setState(() {
      _isPerformingAction = true;
    });

    try {
      // Backend:
      // PUT /api/orders/${widget.orderId}/cancel

      await Future<void>.delayed(
        const Duration(milliseconds: 700),
      );

      if (!mounted) return;

      setState(() {
        _order = order.copyWith(
          status: 'cancelled',
          statusMessage:
              'This order has been cancelled.',
        );
      });

      Get.snackbar(
        'Order cancelled',
        'Your order was cancelled successfully.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } catch (_) {
      if (!mounted) return;

      Get.snackbar(
        'Unable to cancel order',
        'Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isPerformingAction = false;
        });
      }
    }
  }

  Future<void> _requestReturn() async {
    final order = _order;

    if (order == null || _isPerformingAction) {
      return;
    }

    final reasonController = TextEditingController();

    final reason = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        final keyboardHeight =
            MediaQuery.viewInsetsOf(sheetContext).bottom;

        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            keyboardHeight + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              Text(
                'Return or refund request',
                style: Theme.of(sheetContext)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Tell us why you want to return this order.',
                style: Theme.of(sheetContext)
                    .textTheme
                    .bodyMedium,
              ),
              const SizedBox(height: 18),
              TextField(
                controller: reasonController,
                autofocus: true,
                minLines: 3,
                maxLines: 5,
                textCapitalization:
                    TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Return reason',
                  hintText:
                      'Describe the issue with the order',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 18),
              FilledButton(
                onPressed: () {
                  final value =
                      reasonController.text.trim();

                  if (value.length < 5) {
                    ScaffoldMessenger.of(
                      sheetContext,
                    ).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please provide a return reason.',
                        ),
                      ),
                    );

                    return;
                  }

                  Navigator.pop(
                    sheetContext,
                    value,
                  );
                },
                child: const Text(
                  'Submit Request',
                ),
              ),
            ],
          ),
        );
      },
    );

    reasonController.dispose();

    if (reason == null || !mounted) return;

    setState(() {
      _isPerformingAction = true;
    });

    try {
      // Backend:
      // POST /api/orders/${widget.orderId}/return
      //
      // The exact request body is not documented.
      // Possible payload:
      // {
      //   'reason': reason,
      // }

      debugPrint(
        'Return reason: $reason',
      );

      await Future<void>.delayed(
        const Duration(milliseconds: 700),
      );

      if (!mounted) return;

      setState(() {
        _order = order.copyWith(
          status: 'return_requested',
          statusMessage:
              'Your return request has been submitted.',
        );
      });

      Get.snackbar(
        'Request submitted',
        'Your return request is being reviewed.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } catch (_) {
      if (!mounted) return;

      Get.snackbar(
        'Unable to submit request',
        'Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isPerformingAction = false;
        });
      }
    }
  }

  Future<void> _addReview(
    _OrderProductData product,
  ) async {
    int selectedRating = 5;
    final reviewController =
        TextEditingController();

    final review = await showModalBottomSheet<
        _ReviewSubmission>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        final keyboardHeight =
            MediaQuery.viewInsetsOf(sheetContext).bottom;

        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                8,
                20,
                keyboardHeight + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Review product',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          fontWeight:
                              FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) {
                        final rating = index + 1;

                        return IconButton(
                          onPressed: () {
                            setSheetState(() {
                              selectedRating =
                                  rating;
                            });
                          },
                          icon: Icon(
                            rating <=
                                    selectedRating
                                ? Icons.star_rounded
                                : Icons
                                    .star_border_rounded,
                            color: Colors.amber,
                            size: 34,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller:
                        reviewController,
                    minLines: 3,
                    maxLines: 5,
                    textCapitalization:
                        TextCapitalization
                            .sentences,
                    decoration:
                        const InputDecoration(
                      labelText:
                          'Your review',
                      hintText:
                          'Share your experience',
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 18),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        _ReviewSubmission(
                          rating:
                              selectedRating,
                          comment:
                              reviewController
                                  .text
                                  .trim(),
                        ),
                      );
                    },
                    child: const Text(
                      'Submit Review',
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    reviewController.dispose();

    if (review == null || !mounted) return;

    setState(() {
      _isPerformingAction = true;
    });

    try {
      // Backend:
      // POST /api/orders/${widget.orderId}/review
      //
      // The exact payload is not documented.
      // Possible payload:
      // {
      //   'product_id': product.productId,
      //   'rating': review.rating,
      //   'comment': review.comment,
      // }

      debugPrint(
        'Review: product=${product.productId}, '
        'rating=${review.rating}, '
        'comment=${review.comment}',
      );

      await Future<void>.delayed(
        const Duration(milliseconds: 650),
      );

      if (!mounted) return;

      Get.snackbar(
        'Review submitted',
        'Thank you for reviewing this product.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } catch (_) {
      if (!mounted) return;

      Get.snackbar(
        'Unable to submit review',
        'Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isPerformingAction = false;
        });
      }
    }
  }

  void _buyAgain(
    _OrderProductData product,
  ) {
    Get.to(
      () => ProductDetail(
        productId: product.productId,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  String? _leftActionLabel(
    String status,
  ) {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'confirmed':
      case 'processing':
        return 'Cancel Order';

      case 'delivered':
      case 'completed':
        return 'Return/Refund';

      default:
        return null;
    }
  }

  String? _rightActionLabel(
    String status,
  ) {
    switch (status.toLowerCase()) {
      case 'delivered':
      case 'completed':
        return 'Review';

      case 'shipped':
      case 'in_transit':
      case 'out_for_delivery':
        return 'Track Order';

      default:
        return null;
    }
  }

  VoidCallback? _leftAction(
    _OrderDetailsData order,
  ) {
    switch (order.status.toLowerCase()) {
      case 'pending':
      case 'confirmed':
      case 'processing':
        return _cancelOrder;

      case 'delivered':
      case 'completed':
        return _requestReturn;

      default:
        return null;
    }
  }

  VoidCallback? _rightAction(
    _OrderDetailsData order,
    _OrderProductData product,
  ) {
    switch (order.status.toLowerCase()) {
      case 'delivered':
      case 'completed':
        return () {
          _addReview(product);
        };

      case 'shipped':
      case 'in_transit':
      case 'out_for_delivery':
        return _openTracking;

      default:
        return null;
    }
  }

  IconData _statusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
      case 'completed':
        return Icons.check_circle_outline_rounded;

      case 'cancelled':
        return Icons.cancel_outlined;

      case 'return_requested':
      case 'returned':
        return Icons.assignment_return_outlined;

      case 'shipped':
      case 'in_transit':
      case 'out_for_delivery':
        return Icons.local_shipping_outlined;

      case 'processing':
      case 'confirmed':
        return Icons.inventory_2_outlined;

      default:
        return Icons.receipt_long_outlined;
    }
  }

  String _statusTitle(String status) {
    return status
        .replaceAll('_', ' ')
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map(
          (word) =>
              '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: !_isPerformingAction,
      child: Scaffold(
        backgroundColor:
            theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor:
              theme.scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed:
                _isPerformingAction ? null : Get.back,
            tooltip: 'Back',
            icon: const Icon(
              Icons.arrow_back_rounded,
            ),
          ),
          title: Text(
            'Order Details',
            style: theme
                .textTheme
                .headlineSmall
                ?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return _OrderDetailsErrorState(
        message: _errorMessage!,
        onRetry: _loadOrderDetails,
      );
    }

    final order = _order;

    if (order == null) {
      return const _OrderNotFoundState();
    }

    return RefreshIndicator(
      onRefresh: _loadOrderDetails,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizontalPadding =
              constraints.maxWidth < 700
                  ? 0.0
                  : 24.0;

          return ListView(
            physics:
                const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              8,
              horizontalPadding,
              36,
            ),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(
                    maxWidth: 850,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                    children: [
                      if (_isPerformingAction)
                        const LinearProgressIndicator(
                          minHeight: 3,
                        ),

                      OrderDetailsCardWidget(
                        status:
                            _statusTitle(order.status),
                        paymentMethod:
                            order.paymentDescription,
                        message:
                            order.statusMessage,
                        icon:
                            _statusIcon(order.status),
                      ),

                      OrderInfoCard(
                        orderId:
                            '#${order.orderNumber}',
                        orderPlacedOn:
                            order.orderPlacedOn,
                        shippedOn:
                            order.shippedOn,
                        deliveredOn:
                            order.deliveredOn,
                        paymentMethod:
                            order.paymentMethod,
                      ),

                      const SizedBox(height: 8),

                      DeliveryAddressCard(
                        receiverName:
                            order.receiverName,
                        phoneNumber:
                            order.phoneNumber,
                        address: order.address,
                      ),

                      const SizedBox(height: 8),

                      Padding(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: Text(
                          'Products',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight:
                                    FontWeight.w800,
                              ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      ...order.products.map(
                        (product) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: OrderCardWidget(
                              orderId: order.id,
                              productId:
                                  product.productId,
                              orderNumber:
                                  order.orderNumber,
                              shopName:
                                  product.shopName,
                              status:
                                  order.status,
                              productName:
                                  product.name,
                              variant: [
                                if (product.color !=
                                    null)
                                  'Color: ${product.color}',
                                if (product.size !=
                                    null)
                                  'Size: ${product.size}',
                              ].join(' • '),
                              price:
                                  product.unitPrice,
                              quantity:
                                  product.quantity,
                              total:
                                  product.total,
                              imageUrl:
                                  product.imageUrl,
                              onTap: () {
                                _openProduct(
                                  product.productId,
                                );
                              },
                              leftButtonText:
                                  _leftActionLabel(
                                order.status,
                              ),
                              rightButtonText:
                                  _rightActionLabel(
                                order.status,
                              ),
                              onLeftTap:
                                  _leftAction(order),
                              onRightTap:
                                  _rightAction(
                                order,
                                product,
                              ),
                            ),
                          );
                        },
                      ),

                      PriceDetailsCard(
                        subtotalLabel:
                            'Subtotal '
                            '(${order.totalQuantity} '
                            '${order.totalQuantity == 1 ? 'item' : 'items'})',
                        subtotalAmount:
                            'Rs. ${_formatPrice(order.subtotal)}',
                        shippingLabel:
                            'Shipping Fee',
                        shippingAmount:
                            'Rs. ${_formatPrice(order.shippingFee)}',
                        extraFeeLabel:
                            order.extraFee > 0
                                ? order.extraFeeLabel
                                : null,
                        extraFeeAmount:
                            order.extraFee > 0
                                ? 'Rs. ${_formatPrice(order.extraFee)}'
                                : null,
                        totalAmount:
                            'Rs. ${_formatPrice(order.total)}',
                      ),

                      if (order.canTrack) ...[
                        OrderTrackingCard(
                          trackingMessage:
                              order.trackingMessage ??
                                  'View order tracking',
                          onTap: _openTracking,
                        ),
                      ],

                      if (order.status ==
                              'delivered' ||
                          order.status ==
                              'completed') ...[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(
                            16,
                            4,
                            16,
                            8,
                          ),
                          child: OutlinedButton.icon(
                            onPressed:
                                _isPerformingAction
                                    ? null
                                    : () {
                                        _buyAgain(
                                          order
                                              .products
                                              .first,
                                        );
                                      },
                            icon: const Icon(
                              Icons
                                  .shopping_bag_outlined,
                            ),
                            label: const Text(
                              'Buy Again',
                            ),
                            style:
                                OutlinedButton.styleFrom(
                              minimumSize:
                                  const Size.fromHeight(
                                52,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatPrice(num value) {
    final fixedValue = value.toStringAsFixed(
      value % 1 == 0 ? 0 : 2,
    );

    final parts = fixedValue.split('.');
    final whole = parts.first;
    final decimal =
        parts.length > 1 ? '.${parts[1]}' : '';

    final buffer = StringBuffer();

    for (int index = 0;
        index < whole.length;
        index++) {
      final positionFromEnd =
          whole.length - index;

      buffer.write(whole[index]);

      if (positionFromEnd > 1 &&
          positionFromEnd % 3 == 1) {
        buffer.write(',');
      }
    }

    return '${buffer.toString()}$decimal';
  }
}

class _OrderDetailsErrorState
    extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const _OrderDetailsErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRetry,
      child: ListView(
        physics:
            const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 130),
          Icon(
            Icons.cloud_off_rounded,
            size: 64,
            color: Theme.of(context)
                .colorScheme
                .onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge,
          ),
          const SizedBox(height: 18),
          Center(
            child: FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(
                Icons.refresh_rounded,
              ),
              label: const Text('Try Again'),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderNotFoundState
    extends StatelessWidget {
  const _OrderNotFoundState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 68,
            ),
            SizedBox(height: 16),
            Text(
              'Order not found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderDetailsData {
  final int id;
  final String orderNumber;
  final String status;
  final String statusMessage;

  final String paymentMethod;
  final String paymentDescription;

  final String orderPlacedOn;
  final String? shippedOn;
  final String? deliveredOn;

  final String receiverName;
  final String phoneNumber;
  final String address;

  final double subtotal;
  final double shippingFee;
  final double extraFee;
  final String extraFeeLabel;
  final double total;

  final String? trackingMessage;

  final List<_OrderProductData> products;

  const _OrderDetailsData({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.statusMessage,
    required this.paymentMethod,
    required this.paymentDescription,
    required this.orderPlacedOn,
    required this.receiverName,
    required this.phoneNumber,
    required this.address,
    required this.subtotal,
    required this.shippingFee,
    required this.extraFee,
    required this.extraFeeLabel,
    required this.total,
    required this.products,
    this.shippedOn,
    this.deliveredOn,
    this.trackingMessage,
  });

  int get totalQuantity {
    return products.fold(
      0,
      (total, product) =>
          total + product.quantity,
    );
  }

  bool get canTrack {
    const trackableStatuses = {
      'confirmed',
      'processing',
      'shipped',
      'in_transit',
      'out_for_delivery',
      'delivered',
      'completed',
    };

    return trackableStatuses.contains(
      status.toLowerCase(),
    );
  }

  _OrderDetailsData copyWith({
    String? status,
    String? statusMessage,
  }) {
    return _OrderDetailsData(
      id: id,
      orderNumber: orderNumber,
      status: status ?? this.status,
      statusMessage:
          statusMessage ?? this.statusMessage,
      paymentMethod: paymentMethod,
      paymentDescription:
          paymentDescription,
      orderPlacedOn: orderPlacedOn,
      shippedOn: shippedOn,
      deliveredOn: deliveredOn,
      receiverName: receiverName,
      phoneNumber: phoneNumber,
      address: address,
      subtotal: subtotal,
      shippingFee: shippingFee,
      extraFee: extraFee,
      extraFeeLabel: extraFeeLabel,
      total: total,
      trackingMessage: trackingMessage,
      products: products,
    );
  }

  factory _OrderDetailsData.mock({
    required int orderId,
  }) {
    return _OrderDetailsData(
      id: orderId,
      orderNumber: '213732676987',
      status: 'delivered',
      statusMessage:
          'Your order has been delivered and received successfully.',
      paymentMethod: 'Cash on Delivery',
      paymentDescription:
          'Paid by Cash on Delivery.',
      orderPlacedOn: '25 Oct 2025',
      shippedOn: '26 Oct 2025',
      deliveredOn: '27 Oct 2025',
      receiverName: 'Snopiee',
      phoneNumber: '9856045832',
      address:
          'Khaltemasina Buspark Area, near Nepal Tourism '
          'Hotel Management College, Pokhara',
      subtotal: 3000,
      shippingFee: 120,
      extraFee: 8,
      extraFeeLabel: 'COD Handling Fee',
      total: 3128,
      trackingMessage:
          '27 Oct – Package delivered',
      products: const [
        _OrderProductData(
          id: 1,
          productId: 1,
          shopName: 'Kathmandu Shop',
          name: 'Nike Sneakers',
          imageUrl:
              'https://images.unsplash.com/photo-1542291026-7eec264c27ff'
              '?auto=format&fit=crop&w=600&q=80',
          unitPrice: 3000,
          quantity: 1,
          color: 'White Orange',
          size: '9',
        ),
      ],
    );
  }

  factory _OrderDetailsData.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawProducts =
        json['items'] ??
            json['order_items'] ??
            <dynamic>[];

    final rawAddress =
        json['address'] is Map<String, dynamic>
            ? json['address']
                as Map<String, dynamic>
            : <String, dynamic>{};

    return _OrderDetailsData(
      id: _toInt(json['id']),
      orderNumber:
          json['order_number']?.toString() ??
              json['order_id']?.toString() ??
              json['id']?.toString() ??
              '',
      status:
          json['status']?.toString() ??
              'pending',
      statusMessage:
          json['status_message']?.toString() ??
              'Your order is being processed.',
      paymentMethod:
          json['payment_method']?.toString() ??
              '',
      paymentDescription:
          json['payment_description']
                  ?.toString() ??
              json['payment_status']
                  ?.toString() ??
              '',
      orderPlacedOn:
          json['created_at']?.toString() ??
              '',
      shippedOn:
          json['shipped_at']?.toString(),
      deliveredOn:
          json['delivered_at']?.toString(),
      receiverName:
          rawAddress['receiver_name']
                  ?.toString() ??
              rawAddress['name']?.toString() ??
              '',
      phoneNumber:
          rawAddress['phone']?.toString() ??
              '',
      address:
          rawAddress['full_address']
                  ?.toString() ??
              rawAddress['address']
                  ?.toString() ??
              '',
      subtotal: _toDouble(
        json['subtotal'],
      ),
      shippingFee: _toDouble(
        json['shipping_fee'],
      ),
      extraFee: _toDouble(
        json['extra_fee'] ??
            json['handling_fee'],
      ),
      extraFeeLabel:
          json['extra_fee_label']
                  ?.toString() ??
              'Additional Fee',
      total: _toDouble(
        json['total'] ??
            json['total_amount'] ??
            json['grand_total'],
      ),
      trackingMessage:
          json['tracking_message']?.toString(),
      products: rawProducts is List
          ? rawProducts
              .whereType<
                  Map<String, dynamic>>()
              .map(
                _OrderProductData.fromJson,
              )
              .toList()
          : const [],
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;

    return int.tryParse(
          value?.toString() ?? '',
        ) ??
        0;
  }

  static double _toDouble(
    dynamic value,
  ) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(
          value?.toString() ?? '',
        ) ??
        0;
  }
}

class _OrderProductData {
  final int id;
  final int productId;
  final String shopName;
  final String name;
  final String imageUrl;
  final double unitPrice;
  final int quantity;
  final String? color;
  final String? size;

  const _OrderProductData({
    required this.id,
    required this.productId,
    required this.shopName,
    required this.name,
    required this.imageUrl,
    required this.unitPrice,
    required this.quantity,
    this.color,
    this.size,
  });

  double get total {
    return unitPrice * quantity;
  }

  factory _OrderProductData.fromJson(
    Map<String, dynamic> json,
  ) {
    final product =
        json['product']
                is Map<String, dynamic>
            ? json['product']
                as Map<String, dynamic>
            : json;

    return _OrderProductData(
      id: _toInt(json['id']),
      productId: _toInt(
        json['product_id'] ??
            product['id'],
      ),
      shopName:
          product['shop_name']?.toString() ??
              product['store_name']
                  ?.toString() ??
              'ShopEase',
      name:
          product['name']?.toString() ??
              product['title']?.toString() ??
              'Product',
      imageUrl:
          product['image_url']?.toString() ??
              product['image']?.toString() ??
              '',
      unitPrice: _toDouble(
        json['price'] ??
            product['price'],
      ),
      quantity: _toInt(
        json['quantity'] ?? 1,
      ),
      color: json['color']?.toString(),
      size: json['size']?.toString(),
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;

    return int.tryParse(
          value?.toString() ?? '',
        ) ??
        0;
  }

  static double _toDouble(
    dynamic value,
  ) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(
          value?.toString() ?? '',
        ) ??
        0;
  }
}

class _ReviewSubmission {
  final int rating;
  final String comment;

  const _ReviewSubmission({
    required this.rating,
    required this.comment,
  });
}