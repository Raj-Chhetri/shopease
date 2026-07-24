class NotificationSetting {
  final bool pushEnabled;
  final bool emailEnabled;
  final bool orderUpdates;
  final bool promotions;

  NotificationSetting({
    this.pushEnabled = true,
    this.emailEnabled = true,
    this.orderUpdates = true,
    this.promotions = true,
  });

  factory NotificationSetting.fromJson(Map<String, dynamic> json) {
    return NotificationSetting(
      pushEnabled: json['push_enabled'] ?? true,
      emailEnabled: json['email_enabled'] ?? true,
      orderUpdates: json['order_updates'] ?? true,
      promotions: json['promotions'] ?? true,
    );
  }
}
