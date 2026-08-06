import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<void> loadOrders() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _dio.get(
        '/orders',
        options: await _authenticatedOptions(),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        final orderList = _extractOrderList(responseData);

        final fetchedOrders = orderList
            .whereType<Map>()
            .map(Map<String, dynamic>.from)
            .map(OrderModel.fromJson)
            .toList();

        fetchedOrders.sort((left, right) {
          final dateComparison = (right.createdAt ?? DateTime(1970)).compareTo(
            left.createdAt ?? DateTime(1970),
          );

          return dateComparison != 0
              ? dateComparison
              : right.id.compareTo(left.id);
        });

        orders.assignAll(fetchedOrders);
      } else {
        errorMessage.value = 'Unable to load orders. Please try again.';
      }
    } on DioException catch (error) {
      errorMessage.value = _errorMessage(
        error,
        fallback: 'Unable to load orders. Please try again.',
      );
    } catch (e) {
      errorMessage.value = e is StateError
          ? e.message
          : 'Unable to load orders. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> cancelOrder(int orderId) async {
    try {
      final response = await _dio.put(
        '/orders/$orderId/cancel',
        options: await _authenticatedOptions(),
      );

      if (response.statusCode == 200 &&
          response.data is Map &&
          response.data['success'] == true) {
        await loadOrders();
        return true;
      }

      return false;
    } on DioException catch (error) {
      Get.snackbar(
        'Unable to cancel order',
        _errorMessage(error, fallback: 'Please try again.'),
      );
      return false;
    }
  }

  Future<Options> _authenticatedOptions() async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token')?.trim();

    if (token == null || token.isEmpty) {
      throw StateError('Please sign in to view your orders.');
    }

    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  List<dynamic> _extractOrderList(dynamic responseData) {
    if (responseData is! Map) return const [];

    final data = responseData['data'];

    if (data is List) return data;

    if (data is Map) {
      final nestedOrders = data['data'] ?? data['orders'];
      if (nestedOrders is List) return nestedOrders;
    }

    return const [];
  }

  String _errorMessage(DioException error, {required String fallback}) {
    final responseData = error.response?.data;

    if (responseData is Map && responseData['message'] != null) {
      return responseData['message'].toString();
    }

    if (error.response?.statusCode == 401) {
      return 'Your session has expired. Please sign in again.';
    }

    return fallback;
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 350), () {
      searchQuery.value = value.trim().toLowerCase();
    });
  }

  List<OrderModel> get visibleOrders {
    final status = tabs[selectedTabIndex.value].status;
    final query = searchQuery.value;

    return orders.where((order) {
      final matchesStatus =
          status == null || order.status.toLowerCase() == status.toLowerCase();

      final matchesQuery =
          query.isEmpty ||
          order.orderNumber.toLowerCase().contains(query) ||
          order.items.any((item) => item.name.toLowerCase().contains(query));

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

  const OrderTab({required this.label, this.status});
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
