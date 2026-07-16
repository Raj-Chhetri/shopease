import 'dart:ui';

class PaymentMethod {
  final String id;
  final String name;
  final String asset;
  final Color color;
  final bool enabled;
  final bool isCashOnDelivery;

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.asset,
    required this.color,
    required this.enabled,
    required this.isCashOnDelivery,
  });
}