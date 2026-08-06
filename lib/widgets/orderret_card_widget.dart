// import 'package:flutter/material.dart';

// class OrderCard extends StatelessWidget {
//   final String shopName;                   
//   final String status;
//   final String productName;
//   final String color;
//   final String price;
//   final String total;
//   final String quantity;
//   final String imagePath; 
//   final VoidCallback? onTap; 
//   final bool showTotalItem;       
// final String? leftButtonText;      
//   final String? rightButtonText;                     

//   const OrderCard({
//     super.key,
//     required this.shopName,
//     required this.productName,
//     required this.color,
//     required this.price,
//     required this.total,
//     required this.quantity,
//     required this.status,
//     required this.imagePath,
//     this.onTap,
//     this.showTotalItem = true,
//     this.leftButtonText,
//     this.rightButtonText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(
//         horizontal: 16,
//         vertical: 8,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//              Row(                                         //  HEADER 
//             children: [
//               const Icon(
//                 Icons.storefront_outlined, size: 18,
//               ),
//               const SizedBox(width: 6),
//               Text(
//                 shopName,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               const Spacer(),
//               Text(
//                 status,
//                 style: TextStyle(
//                  color: Color(0xFF7B2CF5),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//            //  PRODUCT SECTION 
//           InkWell(
//             onTap: onTap,
//             child: Row(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start,
//               children: [
//                 // Product Image
//                 Container(
//                   height: 110,
//                   width: 110,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius:
//                         BorderRadius.circular(18),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey
//                             .withValues(alpha: .2),
//                         blurRadius: 8,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: ClipRRect(
//                     borderRadius:
//                         BorderRadius.circular(18),
//                     child: imagePath.startsWith(
//                             'http')
//                         ? Image.network(
//                             imagePath,
//                             width: 110,
//                             height: 110,
//                             fit: BoxFit.cover,
//                           )
//                         : Image.asset(
//                             imagePath,
//                             width: 110,
//                             height: 110,
//                             fit: BoxFit.cover,
//                           ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 // Product Details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                     children: [ // Product Name
//                       Text( productName,
//                         style: const TextStyle(
//                           fontWeight:
//                               FontWeight.w600, fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       // Product Color
//                       Container(
//                         padding:
//                             const EdgeInsets
//                                 .symmetric(
//                           horizontal: 10,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: const Color(
//                               0xFFF2F2F2),
//                           borderRadius:
//                               BorderRadius
//                                   .circular(20),
//                         ),
//                         child: Text(
//                           'Color: $color',
//                           style:
//                               const TextStyle(
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       // Price & Quantity
//                       Row(
//                         children: [
//                           Text( price, style: const TextStyle(
//                               fontWeight:
//                                   FontWeight.bold,
//                             ),
//                           ),
//                           const Spacer(),
//                           Text(
//                             'Qty: $quantity',
//                             style:
//                                 const TextStyle(
//                               fontWeight:
//                                   FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 4),
//                       // Total Item
//                       if (showTotalItem)
//                         Align(
//                           alignment:
//                               Alignment
//                                   .centerRight,
//                           child: Text(
//                             'Total(Item): $total',
//                             style:
//                                 const TextStyle(
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 10),           //  ACTION BUTTONS 
//           Padding(
//             padding:
//                 const EdgeInsets.only(
//               left: 122,
//             ),
//             child: _buildButtons(),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget _buildButtons() {
//     if (leftButtonText != null &&
//         rightButtonText != null) {
//       return Row(
//         children: [
//           Expanded(
//             child: _outlineButton(
//               leftButtonText!,
//             ),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: _filledButton(
//               rightButtonText!,
//             ),
//           ),
//         ],
//       );
//     }
//     switch (status) {
//       case "Completed":
//         return Row(
//           children: [
//             Expanded(
//               child: _outlineButton(
//                 "Return/Refund",
//               ),
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: _filledButton(
//                 "Buy Again",
//               ),
//             ),
//           ],
//         );
//       case "Shipped":
//         return Row(
//           children: [
//             Expanded(
//               child: _outlineButton(
//                 "View Details",
//               ),
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: _filledButton(
//                 "Track Order",
//               ),
//             ),
//           ],
//         );
//       case "Processing":
//         return _outlineButton(
//           "Cancel Order",
//         );
//       case "Cancelled":
//         return _outlineButton(
//           "View Details",
//         );

//       default:
//         return const SizedBox();
//     }
//   }
//    // FILLED BUTTON 
//   Widget _filledButton(
//     String text,
//   ) {
//     return Container(
//       height: 38,
//       decoration: BoxDecoration(
//         color: const Color(0xFF7B2CF5),
//         borderRadius:
//             BorderRadius.circular(25),
//       ),
//       child: Center(
//         child: Text(
//           text,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// //   // OUTLINE BUTTON 
//   Widget _outlineButton(
//     String text,
//   ) {
//     return Container(
//       height: 38,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color:const Color(0xFF7B2CF5),
//         ),
//         borderRadius:BorderRadius.circular(25),
//       ),
//       child: Center(
//         child: Text(
//           text,
//           style: const TextStyle(
//             color: Color(0xFF7B2CF5),
//             fontWeight:
//                 FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }
// // TRACKING CARD WIDGET
// class OrderTrackingCard extends StatelessWidget {
//   final String trackingMessage;
//   final VoidCallback onTap;
//   const OrderTrackingCard({
//     super.key,
//     required this.trackingMessage,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius:
//           BorderRadius.circular(30),
//       child: Container(
//         margin:
//             const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 12,
//         ),
//         padding:
//             const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 14,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius:
//               BorderRadius.circular(30),
//           border: Border.all(
//             color:
//                 const Color(0xFF7B2CF5),
//           ),
//         ),
//         child: Row(
//           children: [
//             // Tracking Icon
//             const Icon(
//               Icons
//                   .local_shipping_outlined,
//               color:
//                   Color(0xFF7B2CF5),
//             ),
//             const SizedBox(width: 12),
//             // Tracking Message
//             Expanded(
//               child: Text(
//                 trackingMessage,
//                 style:
//                     const TextStyle(
//                   fontSize: 16,
//                   fontWeight:
//                       FontWeight.w500,
//                 ),
//               ),
//             ),
//             // Arrow Icon
//             const Icon(
//               Icons.arrow_forward_ios,
//               size: 18,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }