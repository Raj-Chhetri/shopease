import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shopease/models/order_model.dart';
import 'package:shopease/services/dio_service.dart';

class OrderHistoryController extends GetxController {
  final Dio _dio = DioService().dio;

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
      final response = await _dio.get(
        '/orders',
        options: Options(
        headers: {
          'Authorization':
              'Bearer qHjhCLJ8qpZAS3f6HODAKwdRbGJEQ74OL9KHRM0od152e9f5',
          },
       ),
      );

      print('Status Code: ${response.statusCode}');
      print('Response: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;

        final List<dynamic> orderList =
            responseData is Map<String, dynamic>
                ? (responseData['data'] ?? [])
                : [];

        final fetchedOrders = orderList
            .whereType<Map<String, dynamic>>()
            .map(OrderModel.fromJson)
            .toList();

        orders.assignAll(fetchedOrders);
      } else {
        errorMessage.value =
            'Unable to load orders. Please try again.';
      }
    } on DioException catch (e) {
      print('Dio Error: ${e.message}');
      print('Response: ${e.response?.data}');

      errorMessage.value =
          'Unable to load orders. Please try again.';
    } catch (e) {
      print('Error loading orders: $e');

      errorMessage.value =
          'Unable to load orders. Please try again.';
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
          order.orderNumber
              .toLowerCase()
              .contains(query) ||
          order.items.any(
            (item) => item.name
                .toLowerCase()
                .contains(query),
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


















// import 'package:get/get.dart';
// import 'package:shopease/services/order_service.dart';

// import '../models/order_model.dart';

// class OrderController extends GetxController {
//   final OrderService _orderService = OrderService();

//   final RxList<OrderModel> orders = <OrderModel>[].obs;

//   final RxBool isLoading = false.obs;

//   final RxString errorMessage = ''.obs;

//   Future<void> fetchOrders() async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';

//       final result = await _orderService.fetchOrders();

//       orders.assignAll(result);
//     } catch (e) {
//       errorMessage.value = e.toString();
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }