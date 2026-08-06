import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopease/controller/cart_controller.dart';
import 'package:shopease/controller/order_controller.dart';
import 'package:shopease/models/cart_item_model.dart';
import 'package:shopease/models/get_address_model.dart';
import 'package:shopease/models/order_model.dart';
import 'package:shopease/services/cart_service.dart';
import 'package:shopease/services/payment_service.dart';
import 'package:shopease/translation/app_translation.dart';
import 'package:shopease/widgets/product_card.dart';

void main() {
  group('Localization', () {
    test('keeps English and Nepali translation keys aligned', () {
      final translations = AppTranslations().keys;
      final englishKeys = translations['en_US']!.keys.toSet();
      final nepaliKeys = translations['ne_NP']!.keys.toSet();

      expect(nepaliKeys, englishKeys);
      expect(translations['ne_NP']!['cart'], 'कार्ट');
      expect(translations['ne_NP']!['order_history'], 'अर्डर इतिहास');
    });
  });

  group('Cart badge', () {
    test('reflects the total quantity and clears when the cart is empty', () {
      final controller = CartController(
        service: CartService(
          dio: Dio(BaseOptions(baseUrl: 'https://example.test/api/')),
        ),
      );

      controller.items.addAll(const [
        CartItemModel(
          id: 1,
          productId: 11,
          name: 'First product',
          shopName: 'ShopEase',
          imageUrl: '',
          price: 100,
          quantity: 2,
          stockQuantity: 10,
        ),
        CartItemModel(
          id: 2,
          productId: 12,
          name: 'Second product',
          shopName: 'ShopEase',
          imageUrl: '',
          price: 200,
          quantity: 3,
          stockQuantity: 10,
        ),
      ]);

      expect(controller.totalItemCount, 5);

      controller.items.clear();
      expect(controller.totalItemCount, 0);
    });
  });

  group('Responsive product card', () {
    testWidgets('fits a narrow two-column phone grid without overflowing', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 158,
                height: 310,
                child: ProductCard(
                  productId: 1,
                  productTitle: 'Reusable Gloves for Dishwashing and Gardening',
                  image: null,
                  newPrice: '199.00',
                  oldPrice: '299.00',
                  rating: 0,
                  ratingCount: 0,
                ),
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });
  });

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

  group('Delivery address selection', () {
    test('uses the most recently saved non-deleted address everywhere', () {
      final olderDefault = Datum.fromJson({
        'id': '4',
        'is_default': 1,
        'address_line1': 'Old address',
        'updated_at': '2026-01-01T00:00:00Z',
      });
      final latest = Datum.fromJson({
        'id': 9,
        'is_default': false,
        'address_line1': 'Latest address',
        'updated_at': '2026-08-01T00:00:00Z',
      });
      final deleted = Datum.fromJson({
        'id': 10,
        'address_line1': 'Deleted address',
        'deleted_at': '2026-08-02T00:00:00Z',
        'updated_at': '2026-08-02T00:00:00Z',
      });

      expect(
        selectCurrentDeliveryAddress([olderDefault, latest, deleted])?.id,
        9,
      );
    });
  });

  group('Order history tabs', () {
    OrderModel order({
      required String status,
      String paymentMethod = 'cod',
      String paymentStatus = 'unpaid',
    }) => OrderModel(
      id: 1,
      orderNumber: 'ORD-1',
      status: status,
      paymentMethod: paymentMethod,
      paymentStatus: paymentStatus,
      total: 100,
      items: const [],
    );

    test('puts a confirmed COD order in To Ship, not To Pay', () {
      final codOrder = order(status: 'confirmed');

      expect(
        const OrderTab(
          label: 'To Ship',
          filter: OrderFilter.toShip,
        ).matches(codOrder),
        isTrue,
      );
      expect(
        const OrderTab(
          label: 'To Pay',
          filter: OrderFilter.toPay,
        ).matches(codOrder),
        isFalse,
      );
    });

    test('maps shipped, delivered, and returned statuses to their tabs', () {
      expect(
        const OrderTab(
          label: 'Receive',
          filter: OrderFilter.toReceive,
        ).matches(order(status: 'out_for_delivery')),
        isTrue,
      );
      expect(
        const OrderTab(
          label: 'Review',
          filter: OrderFilter.toReview,
        ).matches(order(status: 'delivered')),
        isTrue,
      );
      expect(
        const OrderTab(
          label: 'Return',
          filter: OrderFilter.returnOrRefund,
        ).matches(order(status: 'refund_requested')),
        isTrue,
      );
    });
  });

  group('Buy Now checkout preparation', () {
    test('adds the product to an empty backend cart before checkout', () async {
      SharedPreferences.setMockInitialValues({'token': 'test-token'});
      final dio = Dio(BaseOptions(baseUrl: 'https://example.test/api/'));
      var productAdded = false;

      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            if (options.method == 'POST' && options.path == 'cart/add') {
              productAdded = true;
              handler.resolve(
                Response(
                  requestOptions: options,
                  statusCode: 200,
                  data: {'success': true},
                ),
              );
              return;
            }

            if (options.method == 'GET' && options.path == 'cart') {
              handler.resolve(
                Response(
                  requestOptions: options,
                  statusCode: 200,
                  data: {
                    'success': true,
                    'data': {
                      'items': productAdded
                          ? [
                              {
                                'id': 31,
                                'product_id': 7,
                                'quantity': 1,
                                'price': '500.00',
                                'product': {
                                  'id': 7,
                                  'name': 'Test product',
                                  'stock_quantity': 4,
                                },
                              },
                            ]
                          : <dynamic>[],
                    },
                  },
                ),
              );
              return;
            }

            handler.reject(
              DioException(
                requestOptions: options,
                message: 'Unexpected request ${options.method} ${options.path}',
              ),
            );
          },
        ),
      );

      final controller = CartController(service: CartService(dio: dio));
      final preparation = await controller.prepareBuyNow(7);

      expect(productAdded, isTrue);
      expect(controller.items.single.productId, 7);
      expect(controller.areAllSelected, isTrue);
      expect(preparation.amount, 600);
      expect(preparation.hasOtherProducts, isFalse);
    });
  });
}
