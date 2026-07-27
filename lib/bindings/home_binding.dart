import 'package:get/get.dart';
import 'package:shopease/controller/home_controller.dart';
import 'package:shopease/services/home_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeService>(HomeService.new);
    Get.lazyPut<HomeController>(
      () => HomeController(homeService: Get.find<HomeService>()),
    );
  }
}
