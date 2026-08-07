import 'dart:async';

import 'package:get/get.dart';
import 'package:shopease/models/order_model.dart';
import 'package:shopease/services/order_service.dart';

class OrderHistoryController extends GetxController {
  final OrderService _orderService = OrderService();

  final RxList<OrderModel> orders = <OrderModel>[].obs;

  final RxBool isLoading = false.obs;

  final RxString errorMessage = ''.obs;

  final RxInt selectedTabIndex = 0.obs;

  final RxString searchQuery = ''.obs;

  Timer? _debounce;

  final List<OrderTab> tabs = const [
    OrderTab(label: 'All Orders'),
    OrderTab(label: 'To Pay', status: 'pending'),
    OrderTab(label: 'Processing', status: 'processing'),
    OrderTab(label: 'To Ship', status: 'confirmed'),
    OrderTab(label: 'To Receive', status: 'shipped'),
    OrderTab(label: 'Return/Refund', status: 'returned'),
    OrderTab(label: 'To Review', status: 'delivered'),
  ];

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }

  Future<void> loadOrders() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final fetchedOrders = await _orderService.getOrders();
      orders.assignAll(fetchedOrders);
    } catch (e) {
      errorMessage.value =
          e.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelOrder(int orderId) async {
    try {
      isLoading.value = true;

      await _orderService.cancelOrder(orderId);

      await loadOrders();

      Get.snackbar(
        'Success',
        'Order cancelled successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // RETURN / REFUND
  Future<void> returnOrder(
    int orderId, {
    String note = 'I want to return this order',
  }) async {
    try {
      isLoading.value = true;

      await _orderService.returnOrder(
        orderId,
        note: note,
      );

      await loadOrders();

      Get.snackbar(
        'Success',
        'Return request submitted successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceFirst('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 350),
      () {
        searchQuery.value = value.trim().toLowerCase();
      },
    );
  }

  List<OrderModel> get visibleOrders {
    final status = tabs[selectedTabIndex.value].status;
    final query = searchQuery.value;

    return orders.where((order) {
      final matchesStatus =
          status == null ||
          order.status.toLowerCase() ==
              status.toLowerCase();

      final matchesQuery =
          query.isEmpty ||
          order.orderNumber.toLowerCase().contains(query) ||
          order.items.any(
            (item) => item.name.toLowerCase().contains(query),
          );

      return matchesStatus && matchesQuery;
    }).toList();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}

class OrderTab {
  final String label;
  final String? status;

  const OrderTab({
    required this.label,
    this.status,
  });
}











// import 'dart:async';

// import 'package:get/get.dart';
// import 'package:shopease/models/order_model.dart';
// import 'package:shopease/services/order_service.dart';

// class OrderHistoryController extends GetxController {
//   final OrderService _orderService = OrderService();

//   final RxList<OrderModel> orders = <OrderModel>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxString errorMessage = ''.obs;
//   final RxInt selectedTabIndex = 0.obs;
//   final RxString searchQuery = ''.obs;

//   Timer? _debounce;

//   final List<OrderTab> tabs = const [
//     OrderTab(label: 'All Orders'),
//     OrderTab(label: 'To Pay', status: 'pending'),
//     OrderTab(label: 'Processing', status: 'processing'),
//     OrderTab(label: 'To Ship', status: 'confirmed'),
//     OrderTab(label: 'To Receive', status: 'shipped'),
//     OrderTab(label: 'Return/Refund', status: 'returned'),
//     OrderTab(label: 'To Review', status: 'delivered'),
//   ];

//   @override
//   void onInit() {
//     super.onInit();
//     loadOrders();
//   }

//   Future<void> loadOrders() async {
//     isLoading.value = true;
//     errorMessage.value = '';

//     try {
//       final fetchedOrders = await _orderService.getOrders();
//       orders.assignAll(fetchedOrders);
//     } catch (e) {
//       errorMessage.value =
//           e.toString().replaceFirst('Exception: ', '');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> cancelOrder(int orderId) async {
//     try {
//       isLoading.value = true;

//       await _orderService.cancelOrder(orderId);
//       await loadOrders();

//       Get.snackbar(
//         'Success',
//         'Order cancelled successfully.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString().replaceFirst('Exception: ', ''),
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> returnOrder(
//     int orderId, {
//     String note = 'I want to return this order',
//   }) async {
//     try {
//       isLoading.value = true;

//       await _orderService.returnOrder(
//         orderId,
//         note: note,
//       );

//       await loadOrders();

//       Get.snackbar(
//         'Success',
//         'Return request submitted successfully.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString().replaceFirst('Exception: ', ''),
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void changeTab(int index) {
//     selectedTabIndex.value = index;
//   }

//   void onSearchChanged(String value) {
//     _debounce?.cancel();

//     _debounce = Timer(
//       const Duration(milliseconds: 350),
//       () {
//         searchQuery.value = value.trim().toLowerCase();
//       },
//     );
//   }

//   List<OrderModel> get visibleOrders {
//     final status = tabs[selectedTabIndex.value].status;
//     final query = searchQuery.value;

//     final filteredOrders = orders.where((order) {
//       final matchesStatus =
//           status == null ||
//           order.status.toLowerCase() == status.toLowerCase();

//       final matchesQuery =
//           query.isEmpty ||
//           order.orderNumber.toLowerCase().contains(query) ||
//           order.items.any(
//             (item) => item.name.toLowerCase().contains(query),
//           );

//       return matchesStatus && matchesQuery;
//     });

//     final uniqueOrders = <int, OrderModel>{};

//     for (final order in filteredOrders) {
//       uniqueOrders.putIfAbsent(order.id, () => order);
//     }

//     return uniqueOrders.values.toList();
//   }

//   @override
//   void onClose() {
//     _debounce?.cancel();
//     super.onClose();
//   }
// }

// class OrderTab {
//   final String label;
//   final String? status;

//   const OrderTab({
//     required this.label,
//     this.status,
//   });
// }







