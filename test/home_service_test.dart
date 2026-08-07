import 'package:flutter_test/flutter_test.dart';
import 'package:shopease/models/home_product.dart';

void
main() {
  group(
    'HomeProduct API mapping',
    () {
      test(
        'maps product payload into home product model',
        () {
          final product = HomeProduct.fromApiJson(
            {
              'id': 10,
              'name': 'Wireless Earbuds',
              'price': '1200.00',
              'discount_percent': '10.00',
              'primary_image': 'https://example.com/earbuds.jpg',
              'images': [
                'https://example.com/earbuds.jpg',
              ],
            },
          );

          expect(
            product.id,
            10,
          );
          expect(
            product.title,
            'Wireless Earbuds',
          );
          expect(
            product.imageUrl,
            'https://example.com/earbuds.jpg',
          );
          expect(
            product.oldPrice,
            '1333.33',
          );
          expect(
            product.newPrice,
            '1200',
          );
        },
      );
    },
  );
}
