import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/models/order_model.dart';
import 'package:shopease/services/dio_service.dart';
import 'package:shopease/services/payment_service.dart';

class OrderHistoryController extends GetxController {
  OrderHistoryController({Dio? dio}) : _dio = dio ?? DioService().dio;

  final Dio _dio;

  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final Set<int> _locallyCreatedOrderIds = <int>{};

  final RxBool isLoading = false.obs;

  final RxString errorMessage = ''.obs;

  final RxInt selectedTabIndex = 0.obs;

  final RxString searchQuery = ''.obs;

  Timer? _debounce;

  final List<OrderTab> tabs = const [
    OrderTab(label: 'all_orders'),
    OrderTab(label: 'to_pay', filter: OrderFilter.toPay),
    OrderTab(label: 'processing', filter: OrderFilter.processing),
    OrderTab(label: 'to_ship', filter: OrderFilter.toShip),
    OrderTab(label: 'to_receive', filter: OrderFilter.toReceive),
    OrderTab(label: 'return_refund', filter: OrderFilter.returnOrRefund),
    OrderTab(label: 'to_review', filter: OrderFilter.toReview),
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

        final fetchedIds = fetchedOrders.map((order) => order.id).toSet();
        _locallyCreatedOrderIds.removeAll(fetchedIds);
        fetchedOrders.addAll(
          orders.where(
            (order) =>
                _locallyCreatedOrderIds.contains(order.id) &&
                !fetchedIds.contains(order.id),
          ),
        );

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

  /// Makes a newly-created checkout visible immediately, then replaces the
  /// lightweight checkout result with the complete backend order when ready.
  Future<void> refreshAfterCheckout(CheckoutResult result) async {
    _locallyCreatedOrderIds.add(result.orderId);
    _upsertOrder(
      OrderModel(
        id: result.orderId,
        orderNumber: result.orderNumber,
        status: result.orderStatus,
        paymentMethod: result.paymentMethod,
        paymentStatus: result.paymentStatus,
        total: result.payableAmount,
        items: const [],
        createdAt: DateTime.now(),
      ),
    );

    try {
      final response = await _dio.get(
        '/orders/${result.orderId}',
        options: await _authenticatedOptions(),
      );
      final responseData = response.data;
      final data = responseData is Map ? responseData['data'] : null;

      if (response.statusCode == 200 && data is Map) {
        _upsertOrder(OrderModel.fromJson(Map<String, dynamic>.from(data)));
      }
    } catch (_) {
      // Keep the checkout result already inserted above. Pull-to-refresh will
      // retry the order list without turning a successful checkout into an error.
    }
  }

  void _upsertOrder(OrderModel order) {
    final updated = orders.where((item) => item.id != order.id).toList()
      ..add(order)
      ..sort((left, right) {
        final dateComparison = (right.createdAt ?? DateTime(1970)).compareTo(
          left.createdAt ?? DateTime(1970),
        );
        return dateComparison != 0
            ? dateComparison
            : right.id.compareTo(left.id);
      });
    orders.assignAll(updated);
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
    final tab = tabs[selectedTabIndex.value];
    final query = searchQuery.value;

    return orders.where((order) {
      final matchesStatus = tab.matches(order);

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
  final OrderFilter? filter;

  const OrderTab({required this.label, this.filter});

  bool matches(OrderModel order) {
    final selectedFilter = filter;
    if (selectedFilter == null) return true;

    final status = order.status.trim().toLowerCase();
    final paymentStatus = order.paymentStatus.trim().toLowerCase();
    final paymentMethod = order.paymentMethod.trim().toLowerCase();

    switch (selectedFilter) {
      case OrderFilter.toPay:
        return paymentMethod != 'cod' &&
            (paymentStatus.isEmpty ||
                paymentStatus == 'unpaid' ||
                paymentStatus == 'pending') &&
            (status == 'pending' || status == 'pending_payment');
      case OrderFilter.processing:
        return status == 'processing' || status == 'packed';
      case OrderFilter.toShip:
        return status == 'confirmed';
      case OrderFilter.toReceive:
        return status == 'shipped' ||
            status == 'in_transit' ||
            status == 'out_for_delivery';
      case OrderFilter.returnOrRefund:
        return status == 'return_requested' ||
            status == 'returned' ||
            status == 'refund_requested' ||
            status == 'refunded';
      case OrderFilter.toReview:
        return status == 'delivered' || status == 'completed';
    }
  }
}

enum OrderFilter {
  toPay,
  processing,
  toShip,
  toReceive,
  returnOrRefund,
  toReview,
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
