// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopease/views/cartScreen_view.dart';
// import 'package:shopease/views/order_details_view.dart';
// import 'package:shopease/views/search_screen.dart';
// import 'package:shopease/widgets/order_card_widget.dart';

// class OrderHistoryView extends StatelessWidget {
//   const OrderHistoryView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(   
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//     backgroundColor: Colors.white,
//     surfaceTintColor: Colors.white,
//     elevation: 0,
//     centerTitle: true,

//     leading: IconButton(
//       onPressed: () {
//         Get.back();
//       },
//       icon: const Icon(
//         Icons.arrow_back, color: Colors.black,size: 28,
//       ),
//     ),
//     title: const Text(
//       "Order History",style: TextStyle(
//         color: Colors.black,fontSize: 28,fontWeight: FontWeight.bold,
//       ),
//     ),

//     actions: [
//       IconButton(
//         onPressed: () {
//           Get.to(()=>SearchScreen());
//         },icon: const Icon(
//           Icons.search,color: Colors.black,
//         ),
//       ),
//       IconButton(
//         onPressed: () {
//           Get.to(() => const Cartscreenview());
//         },
//         icon: const Icon(
//           Icons.shopping_cart_outlined,color: Colors.black,
//         ),
//       ),
//     ],
//   ),
//       body: SafeArea(
//         child: DefaultTabController(
//           length: 7,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // SEARCH BAR
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 42,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: const Color(0xFF8B5CF6),
//                           ),                       
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: const TextField(
//                           decoration: InputDecoration(
//                             hintText: "Search by Order ID or Product",
//                             prefixIcon: Icon(Icons.search),
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(width: 10),

//                     Container(
//                       height: 38,
//                       width: 38,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF4EEFF),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.filter_alt_outlined,
//                           color: Color(0xFF8B5CF6),
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 12),
//               // TAB BAR
//               const TabBar(
//                 isScrollable: true,
//                 tabAlignment: TabAlignment.start,
//                 padding: EdgeInsets.zero,
//                 dividerColor: Colors.transparent,
//                 indicatorColor: Color(0xFF7B2CF5),
//                 indicatorWeight: 3,
//                 indicatorSize: TabBarIndicatorSize.label,
//                 labelColor: Color(0xFF7B2CF5),
//                 unselectedLabelColor: Colors.black87,
//                 tabs: [
//                   Tab(text: 'All Orders'),
//                   Tab(text: 'To Pay'),
//                   Tab(text: 'Processing'),
//                   Tab(text: 'To Ship'),
//                   Tab(text: 'To Receive'),
//                   Tab(text: 'Return/Refund'),
//                   Tab(text: 'To Review'),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               //huhu
//               Expanded(
//                 child: TabBarView(
//                   children: [

//                     // ALL ORDERS 
//                     ListView(
//                       padding: const EdgeInsets.all(16),
//                       children: [

//                         OrderCardWidget(
//                           shopName: "Kathmandu Shop",
//                           status: "Completed",
//                           productName: "Nike Air Max",
//                           color: "White Orange",
//                           price: "Rs. 3000",
//                           qty: "1",
//                           total: "Rs. 3120",
//                           image: "https://www.bing.com/th/id/OIP.tJQjxbLRRaEt9B4OB546kAHaHw?w=193&h=202&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2",
                             
//                           onTap: () {
//                           Get.to(() => const OrderDetailsView());
//                           },

//                           leftButtonText: "Return/Refund",
//                           rightButtonText: "Buy Again",

//                           onLeftTap: () {},
//                           onRightTap: () {
//                           },
//                         ),

//                         OrderCardWidget(
//                           shopName: "Nepal Store",
//                           status: "Processing",
//                           productName: "Womens Handbag",
//                           color: "Brown",
//                           price: "Rs. 10000",
//                           qty: "2",
//                           total: "Rs. 20150",
//                           image: "https://i5.walmartimages.com/seo/TAIAOJING-Womens-Handbags-Casual-Leather-Messenger-Bag-Large-Capacity-Handbag-Fashion-Bag_317c7ab0-780c-4476-baf2-aceaff2b65a3.2cbbebf7c4c0b06e46f83dc08f5e7253.jpeg",

//                           leftButtonText: "Cancel Order",
//                           rightButtonText: null,

//                           onLeftTap: () {},
//                         ),
//                       ],
//                     ),

//                     // TO PAY 
//                     const Center(child: Text("No orders yet")),

//                    //Processing
//                    ListView(
//                       padding: const EdgeInsets.all(16),
//                       children: [
//                     OrderCardWidget(
//                           shopName: "Nepal Store",
//                           status: "Processing",
//                           productName: "Womens Handbag",
//                           color: "Brown",
//                           price: "Rs. 10000",
//                           qty: "2",
//                           total: "Rs. 20150",
//                           image: "https://i5.walmartimages.com/seo/TAIAOJING-Womens-Handbags-Casual-Leather-Messenger-Bag-Large-Capacity-Handbag-Fashion-Bag_317c7ab0-780c-4476-baf2-aceaff2b65a3.2cbbebf7c4c0b06e46f83dc08f5e7253.jpeg",

//                           leftButtonText: "Cancel Order",
//                           rightButtonText: null,

//                           onLeftTap: () {},
//                         ),
//                       ],
//                     ),
//                     //  TO SHIP 
//                     const Center(child: Text("No orders yet")),

//                     //  TO RECEIVE 
//                     const Center(child: Text("No orders yet")),

//                     // RETURN / REFUND 
//                     const Center(child: Text("No orders yet")),

//                     //  TO REVIEW 
//                     const Center(child: Text("No orders yet")),
//                   ],
//                 ),
//               ),              
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/models/order_model.dart';
import 'package:shopease/views/order_details_view.dart';
import 'package:shopease/widgets/order_card_widget.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() =>
      _OrderHistoryViewState();
}

class _OrderHistoryViewState
    extends State<OrderHistoryView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController =
      TextEditingController();

  Timer? _debounce;

  bool _isLoading = false;
  String? _errorMessage;

  final List<_OrderTab> _tabs = const [
    _OrderTab(label: 'All Orders'),
    _OrderTab(label: 'To Pay', status: 'pending'),
    _OrderTab(label: 'Processing', status: 'processing'),
    _OrderTab(label: 'To Ship', status: 'confirmed'),
    _OrderTab(label: 'To Receive', status: 'shipped'),
    _OrderTab(label: 'Return/Refund', status: 'returned'),
    _OrderTab(label: 'To Review', status: 'delivered'),
  ];

  final List<OrderModel> _orders = [
    const OrderModel(
      id: 1,
      orderNumber: '213732676987',
      status: 'delivered',
      paymentMethod: 'cod',
      paymentStatus: 'paid',
      total: 3120,
      items: [
        OrderItemModel(
          id: 1,
          productId: 1,
          name: 'Nike Air Max',
          shopName: 'Kathmandu Shop',
          imageUrl:
              'https://images.unsplash.com/photo-1542291026-7eec264c27ff'
              '?auto=format&fit=crop&w=600&q=80',
          price: 3000,
          quantity: 1,
          color: 'White Orange',
        ),
      ],
    ),
    const OrderModel(
      id: 2,
      orderNumber: '213732676988',
      status: 'processing',
      paymentMethod: 'esewa',
      paymentStatus: 'paid',
      total: 20150,
      items: [
        OrderItemModel(
          id: 2,
          productId: 2,
          name: 'Women’s Handbag',
          shopName: 'Nepal Store',
          imageUrl:
              'https://images.unsplash.com/photo-1584917865442-de89df76afd3'
              '?auto=format&fit=crop&w=600&q=80',
          price: 10000,
          quantity: 2,
          color: 'Brown',
        ),
      ],
    ),
  ];

  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      setState(() {
        _selectedTabIndex = _tabController.index;
      });

      _loadOrders();
    });
  }

  List<OrderModel> get _visibleOrders {
    final status = _tabs[_selectedTabIndex].status;
    final query = _searchController.text
        .trim()
        .toLowerCase();

    return _orders.where((order) {
      final matchesStatus = status == null ||
          order.status.toLowerCase() ==
              status.toLowerCase();

      final matchesQuery = query.isEmpty ||
          order.orderNumber.toLowerCase().contains(query) ||
          order.items.any(
            (item) =>
                item.name.toLowerCase().contains(query),
          );

      return matchesStatus && matchesQuery;
    }).toList();
  }

  Future<void> _loadOrders() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final status = _tabs[_selectedTabIndex].status;

      // GET /api/orders
      //
      // Query:
      // {
      //   if (status != null) 'status': status,
      //   'start_date': ...,
      //   'end_date': ...,
      // }

      debugPrint(
        'GET /api/orders?status=${status ?? ''}',
      );

      await Future<void>.delayed(
        const Duration(milliseconds: 450),
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            'Unable to load orders. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 350),
      () {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  Future<void> _cancelOrder(OrderModel order) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Cancel order?'),
          content: Text(
            'Cancel order #${order.orderNumber}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Keep order'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Cancel order'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    // PUT /api/orders/{order_id}/cancel
    debugPrint(
      'PUT /api/orders/${order.id}/cancel',
    );
  }

  void _openOrder(OrderModel order) {
    Get.to(
      () => OrderDetailsView(
        orderId: order.id,
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final orders = _visibleOrders;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                12,
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText:
                      'Search by order ID or product',
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                  ),
                  suffixIcon:
                      _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.close_rounded,
                              ),
                            ),
                ),
              ),
            ),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor:
                  theme.colorScheme.primary,
              labelColor: theme.colorScheme.primary,
              unselectedLabelColor:
                  theme.colorScheme.onSurfaceVariant,
              tabs: _tabs
                  .map(
                    (tab) => Tab(text: tab.label),
                  )
                  .toList(),
            ),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(),
                    )
                  : _errorMessage != null
                      ? _OrderErrorState(
                          message: _errorMessage!,
                          onRetry: _loadOrders,
                        )
                      : orders.isEmpty
                          ? const _EmptyOrderState()
                          : RefreshIndicator(
                              onRefresh: _loadOrders,
                              child: LayoutBuilder(
                                builder:
                                    (context, constraints) {
                                  final padding =
                                      constraints.maxWidth <
                                              700
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

                                      if (order
                                          .items.isEmpty) {
                                        return const SizedBox
                                            .shrink();
                                      }

                                      final item =
                                          order.items.first;

                                      return Center(
                                        child:
                                            ConstrainedBox(
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
                                            onLeftTap:
                                                order.status ==
                                                            'pending' ||
                                                        order.status ==
                                                            'processing'
                                                    ? () {
                                                        _cancelOrder(
                                                          order,
                                                        );
                                                      }
                                                    : null,
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
                            ),
            ),
          ],
        ),
      ),
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
      case 'delivered':
        return 'Review';

      case 'shipped':
        return 'Track Order';

      default:
        return 'View Details';
    }
  }
}

class _OrderTab {
  final String label;
  final String? status;

  const _OrderTab({
    required this.label,
    this.status,
  });
}

class _EmptyOrderState extends StatelessWidget {
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

class _OrderErrorState extends StatelessWidget {
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
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}