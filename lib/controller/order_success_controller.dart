import 'package:confetti/confetti.dart';
import 'package:get/get.dart';
import 'package:shopease/views/main_navigation_screen.dart';
import 'package:shopease/views/order_history_view.dart';

class OrderSuccessController extends GetxController {
  late final ConfettiController confettiController;

  @override
  void onInit() {
    super.onInit();

    confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );

    confettiController.play();
  }

  void viewOrders() {
    Get.off(
      () => const OrderHistoryView(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 250),
    );
  }

  void continueShopping() {
    Get.offAll(
      () => const MainNavigationScreen(
        initialIndex: 0,
      ),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }
}