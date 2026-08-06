import 'package:get/get.dart';
import 'package:shopease/services/payment_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentService>(
      () => PaymentService(),
      fenix: true,
    );
  }
}