// import 'package:flutter/material.dart';

// class OrderCardWidget extends StatelessWidget {
//   final String shopName;
//   final String status;

//   final String productName;
//   final String color;
//   final String price;
//   final String qty;
//   final String total;
//   final String image;
//  final VoidCallback? onTap;


//   final String? leftButtonText;
//   final String? rightButtonText;

//   final VoidCallback? onLeftTap;
//   final VoidCallback? onRightTap;

//   const OrderCardWidget({
//     super.key,
//     required this.shopName,
//     required this.status,
//     required this.productName,
//     required this.color,
//     required this.price,
//     required this.qty,
//     required this.total,
//     required this.image,
//     this.leftButtonText,
//     this.rightButtonText,
//     this.onLeftTap,
//     this.onRightTap,
//    this.onTap,
//   });

// Widget _button(String text, VoidCallback? onTap, bool filled) {
//   return Expanded(
//     child: SizedBox(
//       height: 38,
//       child: filled
//           ? ElevatedButton(
//               onPressed: onTap,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF7B2CF5),
//                 foregroundColor: Colors.white,
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               child: Text(
//                 text,
//                 style: const TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             )
//           : OutlinedButton(
//               onPressed: onTap,
//               style: OutlinedButton.styleFrom(
//                 foregroundColor: const Color(0xFF7B2CF5),
//                 side: const BorderSide(
//                   color: Color(0xFF7B2CF5),
//                   width: 1.5,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               child: Text(
//                 text,
//                 style: const TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//     ),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // HEADER
//           Row(
//             children: [
//               const Icon(Icons.store),
//               const SizedBox(width: 8),
//               Text(shopName),
//               const Spacer(),
//              Text(
//   status,
//   style: const TextStyle(
//     color: Color(0xFF7B2CF5),
//     fontSize: 13,
//     fontWeight: FontWeight.w600,
//   ),
// ),
//             ],
//           ),

//           const SizedBox(height: 16),
// // PRODUCT
// InkWell(
//   onTap: onTap,
//   child: Row(
//     children: [
//       Container(
//         width: 85,
//         height: 85,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Colors.grey.shade100,
//           image: DecorationImage(
//         image: image.startsWith('http')
//         ? NetworkImage(image)
//          : AssetImage(image) as ImageProvider,
//   fit: BoxFit.cover,
// ),
//         ),
//       ),

//       const SizedBox(width: 10),

//       Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               productName,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),

//             const SizedBox(height: 6),

//             Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 10,
//                 vertical: 4,
//               ),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFEAE6E6),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 "Color: $color",
//                 style: const TextStyle(fontSize: 12),
//               ),
//             ),

//             const SizedBox(height: 10),

//             Row(
//               children: [
//                 Text(
//                   price,
//                   style: const TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Spacer(),
//                 Text(
//                   "Qty: $qty",
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 6),

//             Row(
//               children: [
//                 const Spacer(),
//                 Text(
//                   "Total ($qty Item${qty == "1" ? "" : "s"}): ",
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 Text(
//                   total,
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ],
//   ),
// ),

//           const SizedBox(height: 12),

// // BUTTONS
// if (leftButtonText != null || rightButtonText != null)
//   Row(
//     mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       SizedBox(
//         width: 228, 
//         child: Row(
//           children: [
//             if (leftButtonText != null)
//               Expanded(
//                 child: SizedBox(
//                   height: 34,
//                   child: OutlinedButton(
//                     onPressed: onLeftTap,
//                     style: OutlinedButton.styleFrom(
//                       padding: EdgeInsets.zero,
//                       foregroundColor: const Color(0xFF7B2CF5),
//                       side: const BorderSide(color: Color(0xFF7B2CF5)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(18),
//                       ),
//                     ),
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: Text(leftButtonText!),
//                     ),
//                   ),
//                 ),
//               ),

//             if (leftButtonText != null && rightButtonText != null)
//               const SizedBox(width: 8),

//             if (rightButtonText != null)
//               Expanded(
//                 child: SizedBox(
//                   height: 34,
//                   child: ElevatedButton(
//                     onPressed: onRightTap,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF7B2CF5),
//                       foregroundColor: Colors.white,
//                       elevation: 0,
//                       padding: EdgeInsets.zero,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(18),
//                       ),
//                     ),
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: Text(rightButtonText!),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     ],
//   ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class OrderCardWidget extends StatelessWidget {
  final int orderId;
  final int productId;
  final String orderNumber;
  final String shopName;
  final String status;
  final String productName;
  final String? variant;
  final double price;
  final int quantity;
  final double total;
  final String imageUrl;

  final VoidCallback? onTap;
  final String? leftButtonText;
  final String? rightButtonText;
  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;

  const OrderCardWidget({
    super.key,
    required this.orderId,
    required this.productId,
    required this.orderNumber,
    required this.shopName,
    required this.status,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.total,
    required this.imageUrl,
    this.variant,
    this.onTap,
    this.leftButtonText,
    this.rightButtonText,
    this.onLeftTap,
    this.onRightTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _statusColor(status);

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.storefront_outlined,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    shopName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _formatStatus(status),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Order #$orderNumber',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const Divider(height: 24),
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: 88,
                      height: 96,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          width: 88,
                          height: 96,
                          color: theme.colorScheme
                              .surfaceContainerHighest,
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (variant != null &&
                            variant!.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            variant!,
                            style:
                                theme.textTheme.bodySmall?.copyWith(
                              color: theme
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ],
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Rs. ${price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Qty: $quantity',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Total: ',
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  'Rs. ${total.toStringAsFixed(0)}',
                  style:
                      theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            if (leftButtonText != null ||
                rightButtonText != null) ...[
              const SizedBox(height: 14),
              Wrap(
                alignment: WrapAlignment.end,
                spacing: 10,
                runSpacing: 10,
                children: [
                  if (leftButtonText != null)
                    OutlinedButton(
                      onPressed: onLeftTap,
                      child: Text(leftButtonText!),
                    ),
                  if (rightButtonText != null)
                    FilledButton(
                      onPressed: onRightTap,
                      child: Text(rightButtonText!),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatStatus(String value) {
    return value
        .replaceAll('_', ' ')
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map(
          (word) =>
              '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' ');
  }

  Color _statusColor(String value) {
    switch (value.toLowerCase()) {
      case 'completed':
      case 'delivered':
        return Colors.green;

      case 'pending':
      case 'to_pay':
        return Colors.orange;

      case 'processing':
      case 'confirmed':
        return Colors.blue;

      case 'shipped':
      case 'to_ship':
      case 'in_transit':
        return Colors.deepPurple;

      case 'cancelled':
      case 'returned':
      case 'refunded':
        return Colors.red;

      default:
        return const Color(0xFF6D28FF);
    }
  }
}