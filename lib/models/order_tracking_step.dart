class OrderTrackingStep {
  final String title;
  final String description;
  final String dateTime;
  final bool isCompleted;
  final bool isCurrent;

  const OrderTrackingStep({
    required this.title,
    required this.description,
    required this.dateTime,
    this.isCompleted = false,
    this.isCurrent = false,
  });
  factory OrderTrackingStep.fromJson(
    Map<String, dynamic> json, {
    bool isCurrent = false,
    bool isCompleted = false,
  }) {
    return OrderTrackingStep(
      title: _formatStatus(json['status']?.toString() ?? ''),
      description: json['note']?.toString() ?? '',
      dateTime: _formatDate(json['date']?.toString() ?? ''),
      isCurrent: isCurrent,
      isCompleted: isCompleted,
    );
  }

  static String _formatStatus(String status) {
    if (status.isEmpty) {
      return 'Unknown';
    }

    return status
        .split('_')
        .map(
          (word) => word.isEmpty
              ? word
              : word[0].toUpperCase() + word.substring(1),
        )
        .join(' ');
  }

  static String _formatDate(String date) {
    if (date.isEmpty) {
      return '';
    }

    try {
      final parsedDate = DateTime.parse(
        date.replaceFirst(' ', 'T'),
      );

      final day = parsedDate.day.toString().padLeft(2, '0');
      final month = parsedDate.month.toString().padLeft(2, '0');
      final year = parsedDate.year;

      final hour = parsedDate.hour == 0
          ? 12
          : parsedDate.hour > 12
              ? parsedDate.hour - 12
              : parsedDate.hour;

      final minute =
          parsedDate.minute.toString().padLeft(2, '0');

      final period = parsedDate.hour >= 12 ? 'PM' : 'AM';

      return '$day/$month/$year at $hour:$minute $period';
    } catch (_) {
      return date;
    }
  }
}
