import '../models/notification_models.dart';

class NotificationModel {
  final int? id;
  final String? title;
  final String? redirectLink;
  final bool? isRead;
  final DateTime? readAt;
  final DateTime? createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.redirectLink,
    required this.isRead,
    required this.readAt,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"],
      title: json["title"],
      redirectLink: json["redirect_link"],
      isRead: json["is_read"] ?? false,
      readAt: json["read_at"] == null ? null : DateTime.parse(json["read_at"]),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
    );
  }

  get body => null;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "redirect_link": redirectLink,
      "is_read": isRead,
      "read_at": readAt?.toIso8601String(),
      "created_at": createdAt?.toIso8601String(),
    };
  }
}

class NotificationListModel {
  final int unreadCount;
  final NotificationPagination data;

  NotificationListModel({required this.unreadCount, required this.data});

  factory NotificationListModel.fromJson(Map<String, dynamic> json) {
    return NotificationListModel(
      unreadCount: json["unread_count"] ?? 0,
      data: NotificationPagination.fromJson(json["data"]),
    );
  }
}

class NotificationPagination {
  final int currentPage;
  final int lastPage;
  final int total;
  final List<NotificationModel> notifications;

  NotificationPagination({
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.notifications,
  });

  factory NotificationPagination.fromJson(Map<String, dynamic> json) {
    return NotificationPagination(
      currentPage: json["current_page"] ?? 1,
      lastPage: json["last_page"] ?? 1,
      total: json["total"] ?? 0,
      notifications: json["data"] == null
          ? []
          : List<NotificationModel>.from(
              json["data"].map((x) => NotificationModel.fromJson(x)),
            ),
    );
  }
}

class NotificationDetailModel {
  final NotificationModel? data;

  NotificationDetailModel({required this.data});

  factory NotificationDetailModel.fromJson(Map<String, dynamic> json) {
    return NotificationDetailModel(
      data: json["data"] == null
          ? null
          : NotificationModel.fromJson(json["data"]),
    );
  }
}

class MarkOneReadModel {
  final NotificationModel? data;

  MarkOneReadModel({required this.data});

  factory MarkOneReadModel.fromJson(Map<String, dynamic> json) {
    return MarkOneReadModel(
      data: json["data"] == null
          ? null
          : NotificationModel.fromJson(json["data"]),
    );
  }
}

class MarkOneUnreadModel {
  final NotificationModel? data;

  MarkOneUnreadModel({required this.data});

  factory MarkOneUnreadModel.fromJson(Map<String, dynamic> json) {
    return MarkOneUnreadModel(
      data: json["data"] == null
          ? null
          : NotificationModel.fromJson(json["data"]),
    );
  }
}

class MarkAllReadModel {
  final String? message;

  MarkAllReadModel({this.message});

  factory MarkAllReadModel.fromJson(Map<String, dynamic> json) {
    return MarkAllReadModel(message: json["message"]);
  }
}
