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
   Future<bool> addReview({
    required int orderId,
    required int productId,
    required int rating,
    required String comment,
  }) async {
    try {
      isLoading.value = true;

      await _service.addReview(
        orderId: orderId,
        productId: productId,
        rating: rating,
        comment: comment,
      );
    return true;
     } catch (e) {

    Get.snackbar(
      'Review Error',
      e.toString(),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
    );

      return false;
    } finally {
      isLoading.value = false;
    }
  }
}


//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString().replaceFirst('Exception: ', ''),
//         snackPosition: SnackPosition.BOTTOM,
//       );

//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }


