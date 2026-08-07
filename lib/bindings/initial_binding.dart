import 'package:get/get.dart';
import 'package:shopease/controller/cart_controller.dart';
import 'package:shopease/controller/order_controller.dart';
import 'package:shopease/services/payment_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentService>(() => PaymentService(), fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
    Get.lazyPut<OrderHistoryController>(
      () => OrderHistoryController(),
      fenix: true,
    );
  }
}
