// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopease/models/order_tracking_step.dart';
// import 'package:shopease/widgets/order_tracking_caard_widget.dart';

// class OrderTrackingView extends StatelessWidget {
//   const OrderTrackingView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//        backgroundColor: Colors.white,

//   appBar: AppBar(
//     backgroundColor: Colors.white,
//     surfaceTintColor: Colors.white,
//     elevation: 0,
//     centerTitle: true,

//     leading: IconButton(
//       onPressed: () {
//         Get.back(); // or Get.off(() => const HomeView());
//       },
//       icon: const Icon(
//         Icons.arrow_back,
//         color: Colors.black,
//         size: 28,
//       ),
//     ),

//     title: const Text(
//       "Order Tracking",
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 28,
//         fontWeight: FontWeight.bold,
//       ),
//     ),

  
//   ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             OrderTrackingCaardWidget(
//               orderId: "213732676987",
//               dateLabel: "Delivered On",
//               date: "27 Oct 2025, 11:22 AM",
//               status: "Delivered",
//             ),

//             const SizedBox(height: 20),

//             OrderTrackingTimeline(
//               steps: const [
//                 OrderTrackingStep(
//                   title: "Delivered",
//                   description:
//                       "Your order has been delivered successfully.",
//                   dateTime:
//                       "27 Oct, 2025 at 11:22 AM",
//                   isCurrent: true,
//                 ),

//                 OrderTrackingStep(
//                   title: "Out for Delivery",
//                   description:
//                       "Your order is out for delivery.",
//                   dateTime:
//                       "27 Oct, 2025 at 09:30 AM",
//                   isCompleted: true,
//                 ),

//                 OrderTrackingStep(
//                   title: "In Transit",
//                   description:
//                       "Your order is on the way.",
//                   dateTime:
//                       "26 Oct, 2025 at 05:15 PM",
//                   isCompleted: true,
//                 ),

//                 OrderTrackingStep(
//                   title: "Ready to Ship",
//                   description:
//                       "Your package is packed and ready.",
//                   dateTime:
//                       "26 Oct, 2025 at 10:00 AM",
//                   isCompleted: true,
//                 ),

//                 OrderTrackingStep(
//                   title: "Confirmed",
//                   description:
//                       "Your order has been confirmed.",
//                   dateTime:
//                       "25 Oct, 2025 at 03:00 PM",
//                   isCompleted: true,
//                 ),

//                 OrderTrackingStep(
//                   title: "Order Placed",
//                   description:
//                       "You placed your order.",
//                   dateTime:
//                       "25 Oct, 2025 at 01:20 PM",
//                   isCompleted: true,
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/models/order_tracking_step.dart';
import 'package:shopease/widgets/order_tracking_caard_widget.dart';

class OrderTrackingView extends StatefulWidget {
  final int orderId;

  const OrderTrackingView({
    super.key,
    required this.orderId,
  });

  @override
  State<OrderTrackingView> createState() =>
      _OrderTrackingViewState();
}

class _OrderTrackingViewState
    extends State<OrderTrackingView> {
  bool _isLoading = false;
  String? _errorMessage;

  final List<OrderTrackingStep> _steps = const [
    OrderTrackingStep(
      title: 'Delivered',
      description:
          'Your order has been delivered successfully.',
      dateTime: '27 Oct 2025 at 11:22 AM',
      isCurrent: true,
      isCompleted: true,
    ),
    OrderTrackingStep(
      title: 'Out for Delivery',
      description:
          'Your order was out for delivery.',
      dateTime: '27 Oct 2025 at 09:30 AM',
      isCompleted: true,
    ),
    OrderTrackingStep(
      title: 'In Transit',
      description: 'Your order was on the way.',
      dateTime: '26 Oct 2025 at 05:15 PM',
      isCompleted: true,
    ),
    OrderTrackingStep(
      title: 'Confirmed',
      description:
          'Your order was confirmed.',
      dateTime: '25 Oct 2025 at 03:00 PM',
      isCompleted: true,
    ),
    OrderTrackingStep(
      title: 'Order Placed',
      description: 'You placed your order.',
      dateTime: '25 Oct 2025 at 01:20 PM',
      isCompleted: true,
    ),
  ];

  Future<void> _loadTracking() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // GET /api/orders/${widget.orderId}/tracking
      await Future<void>.delayed(
        const Duration(milliseconds: 500),
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            'Unable to load tracking information.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTracking();
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
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
        title: Text(
          'Order Tracking',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _errorMessage != null
                ? Center(
                    child: Text(_errorMessage!),
                  )
                : RefreshIndicator(
                    onRefresh: _loadTracking,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final padding =
                            constraints.maxWidth < 700
                                ? 16.0
                                : 32.0;

                        return ListView(
                          padding: EdgeInsets.fromLTRB(
                            padding,
                            12,
                            padding,
                            40,
                          ),
                          children: [
                            Center(
                              child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(
                                  maxWidth: 760,
                                ),
                                child: Column(
                                  children: [
                                    OrderTrackingCaardWidget(
                                      orderId: widget
                                          .orderId
                                          .toString(),
                                      dateLabel:
                                          'Delivered on',
                                      date:
                                          '27 Oct 2025, 11:22 AM',
                                      status:
                                          'Delivered',
                                    ),
                                    const SizedBox(height: 20),
                                    OrderTrackingTimeline(
                                      steps: _steps,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}