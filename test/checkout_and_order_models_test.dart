import 'package:flutter_test/flutter_test.dart';
import 'package:shopease/models/order_model.dart';
import 'package:shopease/services/payment_service.dart';

void main() {
  group('CheckoutResult', () {
    test('parses the Cash on Delivery checkout response', () {
      final result = CheckoutResult.fromJson({
        'order_id': 17,
        'order_number': 'ORD-2026-000012',
        'payable_amount': '1859.98',
        'payment_method': 'cod',
        'payment_status': 'unpaid',
        'order_status': 'confirmed',
      }, fallbackAmount: 0);

      expect(result.orderId, 17);
      expect(result.orderNumber, 'ORD-2026-000012');
      expect(result.payableAmount, 1859.98);
      expect(result.paymentMethod, 'cod');
      expect(result.paymentStatus, 'unpaid');
      expect(result.orderStatus, 'confirmed');
    });

    test('rejects a response without an order ID', () {
      expect(
        () => CheckoutResult.fromJson({
          'order_number': 'ORD-MISSING',
        }, fallbackAmount: 100),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('OrderModel', () {
    test('uses the backend order status, total, and product image', () {
      final order = OrderModel.fromJson({
        'id': 7,
        'order_number': 'ORD-2026-000002',
        'order_status': 'delivered',
        'status': 'pending',
        'total': '0.00',
        'grand_total': '1999.98',
        'payment_method': 'cod',
        'payment_status': 'unpaid',
        'items': [
          {
            'id': 19,
            'product_id': 1,
            'quantity': 2,
            'price': '949.99',
            'product': {
              'id': 1,
              'name': 'iPhone 15 Pro',
              'primary_image':
                  'http://127.0.0.1:8000/storage/products/phone.png',
            },
          },
        ],
      });

      expect(order.status, 'delivered');
      expect(order.total, 1999.98);
      expect(order.items.single.name, 'iPhone 15 Pro');
      expect(
        order.items.single.imageUrl,
        'https://shopease.sudamhub.com/storage/products/phone.png',
      );
    });
  });
}
