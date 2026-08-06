import 'package:get/get.dart';

String localizeCategoryName(String value) {
  final key = switch (value.trim().toLowerCase()) {
    'all' => 'all',
    'electronics' => 'electronics',
    'books' => 'books',
    'clothing' || 'fashion' => 'clothing',
    'home & garden' || 'home and garden' => 'home_garden',
    'sports' => 'sports',
    'general' => 'general',
    'wearables' => 'wearables',
    'shoes' => 'shoes',
    'smartphones' => 'smartphones',
    _ => null,
  };

  return key?.tr ?? value;
}
