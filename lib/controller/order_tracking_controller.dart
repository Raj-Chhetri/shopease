import 'package:get/get.dart';
import 'package:shopease/models/order_tracking_step.dart';
import 'package:shopease/services/order_tracking_service.dart';

class OrderTrackingController extends GetxController {
  final OrderTrackingService _trackingService =
      OrderTrackingService();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<OrderTrackingStep> trackingSteps =
      <OrderTrackingStep>[].obs;

  Future<void> loadTracking(int orderId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      trackingSteps.clear();

      final steps = await _trackingService.getOrderTracking(
        orderId,
      );

      if (steps.isEmpty) {
        errorMessage.value =
            'No tracking information available.';
        return;
      }

      final updatedSteps = <OrderTrackingStep>[];

      for (int i = 0; i < steps.length; i++) {
        final step = steps[i];

        updatedSteps.add(
          OrderTrackingStep(
            title: step.title,
            description: step.description,
            dateTime: step.dateTime,
            isCurrent: i == steps.length - 1,
            isCompleted: true,
          ),
        );
      }

      trackingSteps.assignAll(
        updatedSteps.reversed.toList(),
      );
    } catch (e) {
      errorMessage.value = e
          .toString()
          .replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }
}