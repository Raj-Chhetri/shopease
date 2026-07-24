class AppNotification {
  final String id;
  final String title;
  final String message;
  final String type;
  final String? icon;
  final DateTime createdAt;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    this.icon,
    required this.createdAt,
    this.isRead = false,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'].toString(),
      title: json['data']['title'] ?? 'Notification',
      message: json['data']['message'] ?? '',
      type: json['data']['type'] ?? 'general',
      icon: json['data']['icon'],
      createdAt: DateTime.parse(json['created_at']),
      isRead: json['read_at'] != null,
    );
  }
}
