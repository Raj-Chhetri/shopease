import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/order_controller.dart';
import 'package:shopease/models/order_model.dart';
import 'package:shopease/views/order_details_view.dart';
import 'package:shopease/widgets/order_card_widget.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final OrderHistoryController controller =
      Get.put(OrderHistoryController());

  final TextEditingController _searchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: controller.tabs.length,
      vsync: this,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      controller.changeTab(_tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _openOrder(OrderModel order) {
    Get.to(
      () => OrderDetailsView(orderId: order.id),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,

        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(Icons.arrow_back_rounded),
        ),

        title: Text(
          'Order History',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SafeArea(
        top: false,

        child: Column(
          children: [
            // SEARCH
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                12,
              ),

              child: TextField(
                controller: _searchController,

                onChanged: (value) {
                  controller.onSearchChanged(value);
                  setState(() {});
                },

                textInputAction: TextInputAction.search,

                decoration: InputDecoration(
                  hintText: 'Search by order ID or product',

                  prefixIcon: const Icon(
                    Icons.search_rounded,
                  ),

                  suffixIcon:
                      _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                _searchController.clear();

                                controller.onSearchChanged('');

                                setState(() {});
                              },

                              icon: const Icon(
                                Icons.close_rounded,
                              ),
                            ),
                ),
              ),
            ),

            // TABS
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,

              indicatorColor:
                  theme.colorScheme.primary,

              labelColor:
                  theme.colorScheme.primary,

              unselectedLabelColor:
                  theme.colorScheme.onSurfaceVariant,

              tabs: controller.tabs
                  .map(
                    (tab) => Tab(
                      text: tab.label,
                    ),
                  )
                  .toList(),
            ),

            // ORDERS
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.errorMessage.value.isNotEmpty) {
                  return _OrderErrorState(
                    message:
                        controller.errorMessage.value,
                    onRetry:
                        controller.loadOrders,
                  );
                }

                final orders =
                    controller.visibleOrders;

                if (orders.isEmpty) {
                  return const _EmptyOrderState();
                }

                return RefreshIndicator(
                  onRefresh:
                      controller.loadOrders,

                  child: LayoutBuilder(
                    builder:
                        (context, constraints) {
                      final padding =
                          constraints.maxWidth < 700
                              ? 14.0
                              : 32.0;

                      return ListView.builder(
                        padding:
                            EdgeInsets.fromLTRB(
                          padding,
                          16,
                          padding,
                          40,
                        ),

                        itemCount:
                            orders.length,

                        itemBuilder:
                            (context, index) {
                          final order =
                              orders[index];

                          if (order.items.isEmpty) {
                            return const SizedBox
                                .shrink();
                          }

                          final item =
                              order.items.first;

                          return Center(
                            child: ConstrainedBox(
                              constraints:
                                  const BoxConstraints(
                                maxWidth: 850,
                              ),

                              child:
                                  OrderCardWidget(
                                orderId:
                                    order.id,

                                productId:
                                    item.productId,

                                orderNumber:
                                    order.orderNumber,

                                shopName:
                                    item.shopName,

                                status:
                                    order.status,

                                productName:
                                    item.name,

                                variant: [
                                  if (item.color !=
                                      null)
                                    'Color: ${item.color}',

                                  if (item.size !=
                                      null)
                                    'Size: ${item.size}',
                                ].join(' • '),

                                price:
                                    item.price,

                                quantity:
                                    item.quantity,

                                total:
                                    order.total,

                                imageUrl:
                                    item.imageUrl,

                                onTap: () {
                                  _openOrder(
                                    order,
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

                                // RETURN / CANCEL ACTION
                                onLeftTap: () {
                                  final status =
                                      order.status
                                          .toLowerCase();

                                  if (status ==
                                          'pending' ||
                                      status ==
                                          'processing') {
                                    _cancelOrder(
                                      order,
                                    );
                                  } else if (status ==
                                      'delivered') {
                                    _returnOrder(
                                      order,
                                    );
                                  }
                                },

                                onRightTap: () {
                                  _openOrder(
                                    order,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // CANCEL ORDER
  Future<void> _cancelOrder(
    OrderModel order,
  ) async {
    final confirmed =
        await showDialog<bool>(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Cancel order?',
          ),

          content: Text(
            'Cancel order #${order.orderNumber}?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },

              child: const Text(
                'Keep order',
              ),
            ),

            FilledButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },

              child: const Text(
                'Cancel order',
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    await controller.cancelOrder(
      order.id,
    );
  }

  // RETURN / REFUND ORDER
  Future<void> _returnOrder(
    OrderModel order,
  ) async {
    final confirmed =
        await showDialog<bool>(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Return/Refund order?',
          ),

          content: Text(
            'Do you want to request a return/refund for order #${order.orderNumber}?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },

              child: const Text(
                'Cancel',
              ),
            ),

            FilledButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },

              child: const Text(
                'Return/Refund',
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    await controller.returnOrder(
      order.id,
    );
  }

  String? _leftActionLabel(
    String status,
  ) {
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

  String? _rightActionLabel(
    String status,
  ) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return 'Review';

      case 'shipped':
        return 'Track Order';

      default:
        return 'View Details';
    }
  }
}

// EMPTY STATE

class _EmptyOrderState
    extends StatelessWidget {
  const _EmptyOrderState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 68,
            ),

            SizedBox(height: 14),

            Text(
              'No orders found',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),

            SizedBox(height: 6),

            Text(
              'Your orders will appear here.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ERROR STATE

class _OrderErrorState
    extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _OrderErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          const Icon(
            Icons.cloud_off_rounded,
            size: 58,
          ),

          const SizedBox(height: 14),

          Text(message),

          const SizedBox(height: 16),

          FilledButton(
            onPressed: onRetry,
            child: const Text(
              'Try again',
            ),
          ),
        ],
      ),
    );
  }
}















// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopease/controller/order_controller.dart';
// import 'package:shopease/models/order_model.dart';
// import 'package:shopease/views/order_details_view.dart';
// import 'package:shopease/widgets/order_card_widget.dart';

// class OrderHistoryView extends StatefulWidget {
//   const OrderHistoryView({super.key});

//   @override
//   State<OrderHistoryView> createState() => _OrderHistoryViewState();
// }

// class _OrderHistoryViewState extends State<OrderHistoryView>
//     with SingleTickerProviderStateMixin {
//   late final TabController _tabController;

//   final OrderHistoryController controller = Get.put(OrderHistoryController());

//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     _tabController = TabController(length: controller.tabs.length, vsync: this);

//     _tabController.addListener(() {
//       if (_tabController.indexIsChanging) return;

//       controller.changeTab(_tabController.index);
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _openOrder(OrderModel order) {
//     Get.to(
//       () => OrderDetailsView(orderId: order.id),
//       transition: Transition.rightToLeft,
//       duration: const Duration(milliseconds: 250),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: theme.scaffoldBackgroundColor,
//         surfaceTintColor: Colors.transparent,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: Get.back,
//           icon: const Icon(Icons.arrow_back_rounded),
//         ),
//         title: Text(
//           'Order History',
//           style: theme.textTheme.headlineSmall?.copyWith(
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         top: false,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
//               child: TextField(
//                 controller: _searchController,
//                 onChanged: (value) {
//                   controller.onSearchChanged(value);
//                   setState(() {});
//                 },
//                 textInputAction: TextInputAction.search,
//                 decoration: InputDecoration(
//                   hintText: 'Search by order ID or product',
//                   prefixIcon: const Icon(Icons.search_rounded),
//                   suffixIcon: _searchController.text.isEmpty
//                       ? null
//                       : IconButton(
//                           onPressed: () {
//                             _searchController.clear();
//                             controller.onSearchChanged('');
//                             setState(() {});
//                           },
//                           icon: const Icon(Icons.close_rounded),
//                         ),
//                 ),
//               ),
//             ),

//             TabBar(
//               controller: _tabController,
//               isScrollable: true,
//               tabAlignment: TabAlignment.start,
//               indicatorColor: theme.colorScheme.primary,
//               labelColor: theme.colorScheme.primary,
//               unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
//               tabs: controller.tabs.map((tab) => Tab(text: tab.label)).toList(),
//             ),

//             Expanded(
//               child: Obx(() {
//                 if (controller.isLoading.value) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (controller.errorMessage.value.isNotEmpty) {
//                   return _OrderErrorState(
//                     message: controller.errorMessage.value,
//                     onRetry: controller.loadOrders,
//                   );
//                 }

//                 final orders = controller.visibleOrders;

//                 // print("Controller orders: ${controller.orders.length}");     //added 3 line 151-153
//                 //  print("Visible orders: ${orders.length}");
//                 // print("Selected tab: ${controller.selectedTabIndex.value}");

//                 if (orders.isEmpty) {
//                   return const _EmptyOrderState();
//                 }

//                 return RefreshIndicator(
//                   onRefresh: controller.loadOrders,
//                   child: LayoutBuilder(
//                     builder: (context, constraints) {
//                       final padding = constraints.maxWidth < 700 ? 14.0 : 32.0;

//                       return ListView.builder(
//                         padding: EdgeInsets.fromLTRB(padding, 16, padding, 40),
//                         itemCount: orders.length,
//                         itemBuilder: (context, index) {
//                           final order = orders[index];

//                           if (order.items.isEmpty) {
//                             return const SizedBox.shrink();
//                           }

//                           final item = order.items.first;

//                           return Center(
//                             child: ConstrainedBox(
//                               constraints: const BoxConstraints(maxWidth: 850),
//                               child: OrderCardWidget(
//                                 orderId: order.id,
//                                 productId: item.productId,
//                                 orderNumber: order.orderNumber,
//                                 shopName: item.shopName,
//                                 status: order.status,
//                                 productName: item.name,
//                                 variant: [
//                                   if (item.color != null)
//                                     'Color: ${item.color}',
//                                   if (item.size != null) 'Size: ${item.size}',
//                                 ].join(' • '),
//                                 price: item.price,
//                                 quantity: item.quantity,
//                                 total: order.total,
//                                 imageUrl: item.imageUrl,
//                                 onTap: () {
//                                   _openOrder(order);
//                                 },
//                                 leftButtonText: _leftActionLabel(order.status),
//                                 rightButtonText: _rightActionLabel(
//                                   order.status,
//                                 ),
//                                 onLeftTap:
//                                     order.status.toLowerCase() == 'pending' ||
//                                         order.status.toLowerCase() ==
//                                             'processing'
//                                     ? () {
//                                         _cancelOrder(order);
//                                       }
//                                     : null,
//                                 onRightTap: () {
//                                   _openOrder(order);
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _cancelOrder(OrderModel order) async {
//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           title: const Text('Cancel order?'),
//           content: Text('Cancel order #${order.orderNumber}?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(dialogContext, false);
//               },
//               child: const Text('Keep order'),
//             ),
//             FilledButton(
//               onPressed: () {
//                 Navigator.pop(dialogContext, true);
//               },
//               child: const Text('Cancel order'),
//             ),
//           ],
//         );
//       },
//     );

//     if (confirmed != true) return;

//     // Cancellation API can be added to the controller later.
//     // debugPrint('PUT /api/orders/${order.id}/cancel');
//     await controller.cancelOrder(order.id);
//   }

//   String? _leftActionLabel(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//       case 'processing':
//         return 'Cancel Order';

//       case 'delivered':
//         return 'Return/Refund';

//       default:
//         return null;
//     }
//   }

//   String? _rightActionLabel(String status) {
//     switch (status.toLowerCase()) {
//       case 'delivered':
//         return 'Review';

//       case 'shipped':
//         return 'Track Order';

//       default:
//         return 'View Details';
//     }
//   }
// }

// class _EmptyOrderState extends StatelessWidget {
//   const _EmptyOrderState();

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Padding(
//         padding: EdgeInsets.all(32),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.receipt_long_outlined, size: 68),
//             SizedBox(height: 14),
//             Text(
//               'No orders found',
//               style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
//             ),
//             SizedBox(height: 6),
//             Text('Your orders will appear here.', textAlign: TextAlign.center),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _OrderErrorState extends StatelessWidget {
//   final String message;
//   final VoidCallback onRetry;

//   const _OrderErrorState({required this.message, required this.onRetry});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(Icons.cloud_off_rounded, size: 58),
//           const SizedBox(height: 14),
//           Text(message),
//           const SizedBox(height: 16),
//           FilledButton(onPressed: onRetry, child: const Text('Try again')),
//         ],
//       ),
//     );
//   }
// }







