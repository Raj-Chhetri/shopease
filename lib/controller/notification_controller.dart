import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../models/notification_models.dart';
import '../services/notification_service.dart';

class NotificationController extends GetxController {
  final NotificationService _service = NotificationService();

  final RxBool isLoading = false.obs;

  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  final RxInt unreadCount = 0.obs;

  final Rxn<NotificationModel> selectedNotification = Rxn<NotificationModel>();

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      isLoading.value = true;

      final response = await _service.getNotifications();

      notifications.assignAll(response.data.notifications);

      unreadCount.value = response.unreadCount;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshNotifications() async {
    await loadNotifications();
  }

  Future<void> getNotification(int id) async {
    try {
      isLoading.value = true;

      final response = await _service.getNotification(id);

      selectedNotification.value = response.data;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markOneRead(int id) async {
    try {
      final response = await _service.markOneRead(id);

      final index = notifications.indexWhere((e) => e.id == id);

      if (index != -1) {
        notifications[index] = response.data!;
      }

      unreadCount.value = notifications
          .where((e) => !(e.isRead ?? false))
          .length;

      notifications.refresh();

      Fluttertoast.showToast(msg: "Marked as read");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> markOneUnread(int id) async {
    try {
      final response = await _service.markOneUnread(id);

      final index = notifications.indexWhere((e) => e.id == id);

      if (index != -1) {
        notifications[index] = response.data!;
      }

      unreadCount.value = notifications
          .where((e) => !(e.isRead ?? false))
          .length;

      notifications.refresh();

      Fluttertoast.showToast(msg: "Marked as unread");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> markAllRead() async {
    try {
      await _service.markAllRead();

      for (int i = 0; i < notifications.length; i++) {
        final old = notifications[i];

        notifications[i] = NotificationModel(
          id: old.id,
          title: old.title,
          redirectLink: old.redirectLink,
          isRead: true,
          readAt: DateTime.now(),
          createdAt: old.createdAt,
        );
      }

      unreadCount.value = 0;

      notifications.refresh();

      Fluttertoast.showToast(msg: "All notifications marked as read");
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  List<NotificationModel> get unreadNotifications =>
      notifications.where((e) => !(e.isRead ?? false)).toList();

  List<NotificationModel> get readNotifications =>
      notifications.where((e) => e.isRead ?? false).toList();

  get Fluttertoast => null;
}
