import 'package:get/get.dart';
import 'package:shopease/models/notification_model.dart';
import 'package:shopease/services/api_service.dart';

class NotificationController extends GetxController {
  final ApiService _api = ApiService();

  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;

      final response = await _api.getNotifications();

      // unread count
      unreadCount.value = response['unread_count'] ?? 0;

      // Handle different response structures
      List list = [];

      if (response['data'] is List) {
        // Case: "data": [ ... ]
        list = response['data'];
      } else if (response['data'] is Map && response['data']['data'] is List) {
        // Case: "data": { "data": [ ... ] }
        list = response['data']['data'];
      }

      notifications.value = list
          .map((e) => NotificationModel.fromJson(e))
          .toList();
    } catch (e) {
      print("Notification Error → $e");
      Get.snackbar("Error", "Failed to load notifications");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshNotifications() async {
    await fetchNotifications();
  }

  Future<void> markAsRead(int id) async {
    try {
      await _api.markNotificationAsRead(id);

      final index = notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        notifications[index] = notifications[index].copyWith(
          isRead: true,
          readAt: DateTime.now(),
        );
        notifications.refresh();
        if (unreadCount.value > 0) unreadCount.value--;
      }
    } catch (e) {
      print("Mark as read error → $e");
    }
  }

  Future<void> markAllRead() async {
    try {
      await _api.markAllNotificationsAsRead();

      for (int i = 0; i < notifications.length; i++) {
        notifications[i] = notifications[i].copyWith(
          isRead: true,
          readAt: DateTime.now(),
        );
      }
      notifications.refresh();
      unreadCount.value = 0;
    } catch (e) {
      print("Mark all read error → $e");
    }
  }
}
