import 'package:get/get.dart';
import 'package:shopease/models/order_details_model.dart';
import 'package:shopease/services/order_details_service.dart';

class OrderDetailsController extends GetxController {
  final OrderDetailsService _service = OrderDetailsService();

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final Rxn<OrderDetailsModel> order = Rxn<OrderDetailsModel>();


  Future<void> loadOrderDetails(int orderId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _service.getOrderDetails(orderId);

      order.value = result;

    } catch (e) {
      errorMessage.value = e.toString();

    } finally {
      isLoading.value = false;
    }
  }


  Future<void> cancelOrder(int orderId) async {
    try {
      isLoading.value = true;

      await _service.cancelOrder(orderId);

      await loadOrderDetails(orderId);

      Get.snackbar(
        'Success',
        'Order cancelled successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );

    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );

    } finally {
      isLoading.value = false;
    }
  }


  Future<void> refreshOrder(int orderId) async {
    await loadOrderDetails(orderId);
  }
}




