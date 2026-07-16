class OrderSuccessArguments {
  final String orderId;
  final String paymentMethod;
  final double amount;

  const OrderSuccessArguments({
    required this.orderId,
    required this.paymentMethod,
    required this.amount,
  });
}