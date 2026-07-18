import 'package:flutter/material.dart';

class OrderDetailsCardWidget extends StatelessWidget {
  //Completed, process, ship....... ko lagi (top)
  final String status;
  final String paymentMethod;
  final String message;
  final IconData icon;

  const OrderDetailsCardWidget({
    super.key,
    required this.status,
    required this.paymentMethod,
    required this.message,
    this.icon = Icons.check_circle_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7B2CF5),
            Color(0xFF9D4DFF),
          ],
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  paymentMethod,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  message,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Icon(
            icon,
            color: Theme.of(context).colorScheme.surface,
            size: 24,
          ),
        ],
      ),
    );
  }
}
//orderInfo
class OrderInfoCard extends StatelessWidget {
  final String orderId;
  final String orderPlacedOn;
  final String? shippedOn;
  final String? deliveredOn;
  final String? paymentMethod;

  const OrderInfoCard({
    super.key,
    required this.orderId,
    required this.orderPlacedOn,
    this.shippedOn,
    this.deliveredOn,
    this.paymentMethod,
  });

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildRow("Order ID", orderId),
            _buildRow("Order Placed On", orderPlacedOn),

            if (shippedOn != null)
              _buildRow("Shipped On", shippedOn!),

            if (deliveredOn != null)
              _buildRow("Delivered On", deliveredOn!),

            if (paymentMethod != null)
              _buildRow(
                "Payment Method",
                paymentMethod!,
              ),
          ],
        ),
      ),
    );
  }
}
//address
class DeliveryAddressCard extends StatelessWidget {
  final String receiverName;
  final String phoneNumber;
  final String address;
  final VoidCallback? onTap;

  const DeliveryAddressCard({
    super.key,
    required this.receiverName,
    required this.phoneNumber,
    required this.address,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD6C4FF),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 24,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          receiverName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),

                      Text(
                        phoneNumber,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    address,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Price details
class PriceDetailsCard extends StatelessWidget {
  final String title;

  final String subtotalLabel;
  final String subtotalAmount;

  final String shippingLabel;
  final String shippingAmount;

  final String? extraFeeLabel;
  final String? extraFeeAmount;

  final String totalAmount;

  const PriceDetailsCard({
    super.key,
    this.title = "Price Details",
    required this.subtotalLabel,
    required this.subtotalAmount,
    required this.shippingLabel,
    required this.shippingAmount,
    this.extraFeeLabel,
    this.extraFeeAmount,
    required this.totalAmount,
  });

  Widget _buildRow(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7B2CF5),
            Color(0xFF9D4DFF),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.local_offer_outlined,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          _buildRow(
            subtotalLabel,
            subtotalAmount,
          ),

          _buildRow(
            shippingLabel,
            shippingAmount,
          ),

          if (extraFeeLabel != null &&
              extraFeeAmount != null)
            _buildRow(
              extraFeeLabel!,
              extraFeeAmount!,
            ),

          const SizedBox(height: 6),

          _buildRow(
            "Total",
            totalAmount,
          ),
        ],
      ),
    );
  } 
}

class OrderTrackingCard extends StatelessWidget {
  final String trackingMessage;
  final VoidCallback onTap;
  const OrderTrackingCard({
    super.key,
    required this.trackingMessage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(30),
      child: Container(
        margin:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(30),
          border: Border.all(
            color:
                const Color(0xFF7B2CF5),
          ),
        ),
        child: Row(
          children: [
            // Tracking Icon
            const Icon(
              Icons
                  .local_shipping_outlined,
              color:
                  Color(0xFF7B2CF5),
            ),
            const SizedBox(width: 12),
            // Tracking Message
            Expanded(
              child: Text(
                trackingMessage,
                style:
                    const TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.w500,
                ),
              ),
            ),
            // Arrow Icon
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}


