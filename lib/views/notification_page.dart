import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/notification_controller.dart';
import '../models/notification_models.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final NotificationController controller = Get.put(NotificationController());

  static const Color primary = Color(0xFF6D28FF);

  @override
  Widget build(BuildContext context) {
    final bool dark = Theme.of(context).brightness == Brightness.dark;

    final double width = MediaQuery.of(context).size.width;

    final bool mobile = width < 700;

    return Scaffold(
      backgroundColor: dark ? const Color(0xff111827) : const Color(0xffF6F7FB),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          "notifications".tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final unread = controller.notifications
            .where((e) => !(e.isRead ?? false))
            .toList();

        final read = controller.notifications
            .where((e) => (e.isRead ?? false))
            .toList();

        // Empty State
        if (controller.notifications.isEmpty) {
          return const _EmptyNotification();
        }

        return RefreshIndicator(
          onRefresh: controller.refreshNotifications,

          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: mobile ? 16 : width * .12,
              vertical: 20,
            ),

            children: [
              if (controller.unreadCount.value > 0)
                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff7C3AED), Color(0xff5B21B6)],
                    ),

                    borderRadius: BorderRadius.circular(22),

                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(.30),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),

                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(18),
                        ),

                        child: const Icon(
                          Icons.notifications_active,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),

                      const SizedBox(width: 18),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              "Unread_notifications".tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              "${controller.unreadCount.value} ${"new_messages".tr}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),

                        child: Text(
                          controller.unreadCount.value.toString(),
                          style: const TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (unread.isNotEmpty) ...[
                _SectionTitle(
                  title: "Unread".tr,
                  color: Colors.red,
                  count: unread.length,
                  showMarkAll: true,
                ),

                const SizedBox(height: 15),

                ...unread.map(
                  (notification) =>
                      _NotificationTile(notification: notification),
                ),
              ],

              const SizedBox(height: 30),

              if (read.isNotEmpty) ...[
                _SectionTitle(
                  title: "Read".tr,
                  color: Colors.green,
                  count: read.length,
                  showMarkAll: false,
                ),

                const SizedBox(height: 15),

                ...read.map(
                  (notification) =>
                      _NotificationTile(notification: notification),
                ),
              ],

              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }
}

///--------------------------------------------------------------
/// Section Title
///--------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  final String title;
  final Color color;
  final int count;
  final bool showMarkAll;

  const _SectionTitle({
    super.key,
    required this.title,
    required this.color,
    required this.count,
    this.showMarkAll = false,
  });

  static const Color primary = Color(0xFF6D28FF);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    final bool dark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),

        const SizedBox(width: 10),

        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: dark ? Colors.white : Colors.black87,
          ),
        ),

        const SizedBox(width: 10),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: color.withOpacity(.12),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),

        const Spacer(),

        if (showMarkAll)
          ElevatedButton.icon(
            onPressed: controller.markAllRead,
            icon: const Icon(Icons.done_all, size: 18),
            label: Text("Mark all".tr),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
      ],
    );
  }
}

///--------------------------------------------------------------
/// Empty Notification Widget
///--------------------------------------------------------------

class _EmptyNotification extends StatelessWidget {
  const _EmptyNotification({super.key});

  static const Color primary = Color(0xFF6D28FF);

  @override
  Widget build(BuildContext context) {
    final bool dark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: primary.withOpacity(.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_off_outlined,
                color: primary,
                size: 70,
              ),
            ),

            const SizedBox(height: 25),

            Text(
              "no_notifications".tr,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: dark ? Colors.white : Colors.black87,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "you_are_all_caught_up".tr,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: () {
                Get.find<NotificationController>().refreshNotifications();
              },
              icon: const Icon(Icons.refresh),
              label: Text("refresh".tr),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationModel notification;

  const _NotificationTile({super.key, required this.notification});

  static const Color primary = Color(0xFF6D28FF);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    final bool dark = Theme.of(context).brightness == Brightness.dark;

    final bool isRead = notification.isRead ?? false;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 16),

      child: Material(
        color: dark ? const Color(0xff1F2937) : Colors.white,
        elevation: 2,
        borderRadius: BorderRadius.circular(20),

        child: InkWell(
          borderRadius: BorderRadius.circular(20),

          onTap: () async {
            if (!isRead) {
              await controller.markOneRead(notification.id!);
            }
          },

          child: Padding(
            padding: const EdgeInsets.all(18),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  width: 58,
                  height: 58,

                  decoration: BoxDecoration(
                    color: isRead
                        ? Colors.green.withOpacity(.12)
                        : Colors.red.withOpacity(.12),
                    shape: BoxShape.circle,
                  ),

                  child: Icon(
                    isRead
                        ? Icons.mark_email_read_rounded
                        : Icons.mark_email_unread_rounded,
                    color: isRead ? Colors.green : Colors.red,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 18),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        notification.title ?? "",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: isRead
                              ? FontWeight.w600
                              : FontWeight.bold,
                          color: dark ? Colors.white : Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: isRead ? Colors.green : Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),

                          const SizedBox(width: 8),

                          Text(
                            isRead ? "read".tr : "unread".tr,
                            style: TextStyle(
                              color: isRead ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      if (notification.redirectLink != null &&
                          notification.redirectLink!.isNotEmpty) ...[
                        const SizedBox(height: 10),

                        Text(
                          notification.redirectLink!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: primary, fontSize: 13),
                        ),
                      ],

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 15,
                            color: Colors.grey,
                          ),

                          const SizedBox(width: 6),

                          Text(
                            _formatDate(notification.createdAt),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),

                  onSelected: (value) {
                    if (value == "read") {
                      controller.markOneRead(notification.id!);
                    }

                    if (value == "unread") {
                      controller.markOneUnread(notification.id!);
                    }
                  },

                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: "read",
                      child: Row(
                        children: [
                          const Icon(Icons.done, color: Colors.green),
                          const SizedBox(width: 10),
                          Text("mark_as_read".tr),
                        ],
                      ),
                    ),

                    PopupMenuItem(
                      value: "unread",
                      child: Row(
                        children: [
                          const Icon(
                            Icons.mark_email_unread,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 10),
                          Text("mark_as_unread".tr),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "";

    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) {
      return "Just now".tr;
    }

    if (diff.inHours < 1) {
      return "${diff.inMinutes} ${"minutes_ago".tr}";
    }

    if (diff.inDays < 1) {
      return "${diff.inHours} ${"hours_ago".tr}";
    }

    if (diff.inDays == 1) {
      return "Yesterday".tr;
    }

    if (diff.inDays < 7) {
      return "${diff.inDays} ${"days_ago".tr}";
    }

    return "${date.day}/${date.month}/${date.year}";
  }
}
