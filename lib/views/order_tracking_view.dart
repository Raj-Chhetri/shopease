import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/order_tracking_controller.dart';
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
  late final OrderTrackingController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(
      OrderTrackingController(),
      tag: widget.orderId.toString(),
    );

    controller.loadTracking(widget.orderId);
  }

  @override
  void dispose() {
    Get.delete<OrderTrackingController>(
      tag: widget.orderId.toString(),
    );

    super.dispose();
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
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.errorMessage.value,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        controller.loadTracking(
                          widget.orderId,
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final steps = controller.trackingSteps;

          if (steps.isEmpty) {
            return const Center(
              child: Text(
                'No tracking information available.',
              ),
            );
          }

          final currentStep = steps.first;

          return RefreshIndicator(
            onRefresh: () {
              return controller.loadTracking(
                widget.orderId,
              );
            },
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
                              orderId: widget.orderId
                                  .toString(),
                              dateLabel: currentStep.title,
                              date: currentStep.dateTime,
                              status: currentStep.title,
                            ),
                            const SizedBox(height: 20),
                            OrderTrackingTimeline(
                              steps: steps,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }),
      ),
    );
  }
}