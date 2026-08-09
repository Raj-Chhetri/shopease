import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/order_details_controller.dart';
import 'package:shopease/models/order_details_model.dart';
import 'package:shopease/views/order_tracking_view.dart';
import 'package:shopease/views/product_detail.dart';
import 'package:shopease/views/review_submitted_page.dart';
import 'package:shopease/widgets/order_card_widget.dart';
import 'package:shopease/widgets/order_details_card_widget.dart';

class OrderDetailsView extends StatefulWidget {
  final int orderId;
  final int orderItemId;

  const OrderDetailsView({
    super.key,
    required this.orderId,
    required this.orderItemId,
  });

  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  final OrderDetailsController controller =
      Get.put(OrderDetailsController());

  @override
  void initState() {
    super.initState();
    controller.loadOrderDetails(widget.orderId);
  }

  void _openProduct(int productId) {
    Get.to(
      () => ProductDetail(productId: productId),
      transition: Transition.rightToLeft,
    );
  }

  void _openTracking() {
    Get.to(
      () => OrderTrackingView(orderId: widget.orderId),
      transition: Transition.rightToLeft,
    );
  }

  void _showCancelDialog(int orderId) {
    Get.defaultDialog(
      title: "Cancel Order",
      middleText: "Are you sure you want to cancel this order?",
      textCancel: "No",
      textConfirm: "Yes",
      onConfirm: () {
        Get.back();
        controller.cancelOrder(orderId);
      },
    );
  }

  String? _leftActionLabel(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
      case 'processing':
        return 'Cancel Order';

      case 'delivered':
        return 'Return/Refund';

      default:
        return null;
    }
  }

  String? _rightActionLabel(String status) {
    switch (status.toLowerCase()) {
      case 'shipped':
        return 'Track Order';

      case 'delivered':
        return 'Review';

      default:
        return 'View Details';
    }
  }
   Future<void> _showReviewDialog({
    required int orderId,
    required int productId,
    required String productName,
    required String orderNumber,
    required String imageUrl,
  }) async {
    int rating = 5;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        final commentController = TextEditingController();

        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: const Text('Write a Review'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // RATING
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) {
                        return IconButton(
                          onPressed: () {
                            setDialogState(() {
                              rating = index + 1;
                            });
                          },
                          icon: Icon(
                            index < rating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // COMMENT
                  TextField(
                    controller: commentController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Write your review...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('Cancel'),
                ),

                FilledButton(
                  onPressed: () {
                    final reviewText =
                        commentController.text.trim();

                    if (reviewText.isEmpty) {
                      Get.snackbar(
                        'Review',
                        'Please write a comment.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      return;
                    }

                    Navigator.of(dialogContext).pop({
                      'rating': rating,
                      'comment': reviewText,
                    });
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result == null || !mounted) {
      return;
    }

    final int selectedRating = result['rating'] as int;
    final String reviewText = result['comment'] as String;

    // CALL REVIEW API
    final success = await controller.addReview(
      orderId: orderId,
      productId: productId,
      rating: selectedRating,
      comment: reviewText,
    );

    if (!success || !mounted) {
      return;
    }

    // REVIEW SUBMITTED PAGE
    Get.to(
      () => ReviewSubmittedPage(
        productName: productName,
        orderNumber: orderNumber,
        reviewText: reviewText,
        rating: selectedRating,
        imageUrl: imageUrl,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.errorMessage.value),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    controller.loadOrderDetails(widget.orderId);
                  },
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        final OrderDetailsModel? order = controller.order.value;

        if (order == null) {
          return const Center(
            child: Text("Order not found"),
          );
        }

        final selectedProducts = order.products
            .where(
              (product) => product.id == widget.orderItemId,
            )
            .toList();

        if (selectedProducts.isEmpty) {
          return const Center(
            child: Text("Product not found in this order"),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.refreshOrder(widget.orderId);
          },
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              OrderDetailsCardWidget(
                status: order.status,
                paymentMethod: order.paymentMethod,
                message: order.paymentStatus,
                icon: Icons.inventory_2_outlined,
              ),

              const SizedBox(height: 12),

              OrderInfoCard(
                orderId: "#${order.orderNumber}",
                orderPlacedOn:
                    order.createdAt?.toString().split(' ').first ?? '',
                shippedOn: null,
                deliveredOn: null,
                paymentMethod: order.paymentMethod,
              ),              

              const SizedBox(height: 12),

              if (order.address != null)
                DeliveryAddressCard(
                  receiverName: "",
                  phoneNumber: "",
                  address: order.address!.fullAddress,
                ),

              const SizedBox(height: 16),

              const Text(
                "Products",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              ...selectedProducts.map(
                (product) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: OrderCardWidget(
                      orderId: order.id,
                      productId: product.productId,
                      orderNumber: order.orderNumber,
                      shopName: product.shopName,
                      status: order.status,
                      productName: product.name,
                      variant: "",
                      price: product.price,
                      quantity: product.quantity,
                      total: product.total,
                      imageUrl: product.imageUrl,
                      onTap: () => _openProduct(product.productId),

                      leftButtonText:
                          _leftActionLabel(order.status),
                      rightButtonText:
                          _rightActionLabel(order.status),

                      onLeftTap: () {
                        switch (order.status.toLowerCase()) {
                          case "pending":
                          case "processing":
                            _showCancelDialog(order.id);
                            break;

                          case "delivered":
                            Get.snackbar(
                              "Return / Refund",
                              "Return/Refund API goes here",
                            );
                            break;
                        }
                      },

                      onRightTap: () {
                        switch (order.status.toLowerCase()) {
                          case "shipped":
                            _openTracking();
                            break;
                       
                            case "delivered":
                            _showReviewDialog(
                            orderId: order.id,
                            productId: product.productId,
                            productName: product.name,
                            orderNumber: order.orderNumber,
                            imageUrl: product.imageUrl,
                            );
                           break;

                          default:
                            _openProduct(product.productId);
                        }
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 12),

              PriceDetailsCard(
                subtotalLabel:
                    "Subtotal (${selectedProducts.fold<int>(
                  0,
                  (sum, product) => sum + product.quantity,
                )} item${selectedProducts.fold<int>(
                  0,
                  (sum, product) => sum + product.quantity,
                ) == 1 ? '' : 's'})",
                subtotalAmount:
                    "Rs. ${selectedProducts.fold<double>(
                  0,
                  (sum, product) => sum + product.total,
                ).toStringAsFixed(2)}",
                shippingLabel: "Shipping Fee",
                shippingAmount:
                    "Rs. ${order.shippingFee.toStringAsFixed(2)}",
                extraFeeLabel: order.deliveryFee > 0
                    ? "Delivery Fee"
                    : null,
                extraFeeAmount: order.deliveryFee > 0
                    ? "Rs. ${order.deliveryFee.toStringAsFixed(2)}"
                    : null,
                totalAmount:
                    "Rs. ${(selectedProducts.fold<double>(
                          0,
                          (sum, product) => sum + product.total,
                        ) +
                        order.shippingFee +
                        order.deliveryFee -
                        order.discountAmount)
                    .toStringAsFixed(2)}",
              ),

                  if ([
                  'processing',
                  'confirmed',
                  'shipped',
                  'delivered',
                   ].contains(order.status.toLowerCase())) ...[
                   const SizedBox(height: 20),
                 OrderTrackingCard(
                      trackingMessage: "Track your order",
                         onTap: _openTracking,
                        ),
                    ],
            ],
          ),
        );
      }),
    );
  }
}










