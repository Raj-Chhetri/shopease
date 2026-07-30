import 'package:flutter/material.dart';
import 'package:shopease/models/featured_item.dart';
import 'package:shopease/models/home_category.dart';
import 'package:shopease/models/home_product.dart';

class HomeService {
  static const List<HomeCategory> categories = [
    HomeCategory(
      id: null,
      label: 'All',
      icon: Icons.travel_explore_rounded,
    ),
    HomeCategory(
      id: 1,
      label: 'Fashion',
      icon: Icons.checkroom_rounded,
    ),
    HomeCategory(
      id: 2,
      label: 'Wearables',
      icon: Icons.watch_rounded,
    ),
    HomeCategory(
      id: 3,
      label: 'Shoes',
      icon: Icons.directions_run_rounded,
    ),
    HomeCategory(
      id: 4,
      label: 'Smartphones',
      icon: Icons.smartphone_rounded,
    ),
  ];

  static const List<FeaturedItem> featuredItems = [
    FeaturedItem(
      productId: 1,
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e'
          '?auto=format&fit=crop&w=1200&q=80',
      title: 'Premium Headphones',
      subtitle: 'Clear sound, comfortable design',
    ),
    FeaturedItem(
      productId: 2,
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff'
          '?auto=format&fit=crop&w=1200&q=80',
      title: 'Running Shoes',
      subtitle: 'Built for comfort and performance',
    ),
    FeaturedItem(
      productId: 3,
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30'
          '?auto=format&fit=crop&w=1200&q=80',
      title: 'Smart Wearables',
      subtitle: 'Stay connected throughout your day',
    ),
  ];

  static const List<HomeProduct> topPicks = [
    HomeProduct(
      id: 1,
      title: 'Wireless Headphones',
      imageUrl:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '1700',
      newPrice: '1200',
    ),
    HomeProduct(
      id: 2,
      title: 'Running Shoes',
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '5500',
      newPrice: '4200',
    ),
    HomeProduct(
      id: 3,
      title: 'Smart Watch',
      imageUrl:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '4300',
      newPrice: '3500',
    ),
    HomeProduct(
      id: 4,
      title: 'Smartphone',
      imageUrl:
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '35000',
      newPrice: '31999',
    ),
  ];

  static const List<HomeProduct> _allForYouProducts = [
    HomeProduct(
      id: 5,
      title: 'Classic Sneakers',
      imageUrl:
          'https://images.unsplash.com/photo-1549298916-b41d501d3772'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '4200',
      newPrice: '3499',
    ),
    HomeProduct(
      id: 6,
      title: 'Premium Headset',
      imageUrl:
          'https://images.unsplash.com/photo-1583394838336-acd977736f90'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '6800',
      newPrice: '5799',
    ),
    HomeProduct(
      id: 7,
      title: 'Smart Watch',
      imageUrl:
          'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '5200',
      newPrice: '4499',
    ),
    HomeProduct(
      id: 8,
      title: 'Travel Backpack',
      imageUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '3600',
      newPrice: '2999',
    ),
    HomeProduct(
      id: 9,
      title: 'Casual Shirt',
      imageUrl:
          'https://images.unsplash.com/photo-1603252109303-2751441dd157'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '2500',
      newPrice: '1999',
    ),
    HomeProduct(
      id: 10,
      title: 'Smartphone',
      imageUrl:
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '45000',
      newPrice: '41999',
    ),
    HomeProduct(
      id: 11,
      title: 'Leather Wallet',
      imageUrl:
          'https://images.unsplash.com/photo-1627123424574-724758594e93'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '1800',
      newPrice: '1399',
    ),
    HomeProduct(
      id: 12,
      title: 'Sunglasses',
      imageUrl:
          'https://images.unsplash.com/photo-1572635196237-14b3f281503f'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '2200',
      newPrice: '1699',
    ),
    HomeProduct(
      id: 13,
      title: 'Denim Jacket',
      imageUrl:
          'https://images.unsplash.com/photo-1551028719-00167b16eac5'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '4800',
      newPrice: '3999',
    ),
    HomeProduct(
      id: 14,
      title: 'Bluetooth Speaker',
      imageUrl:
          'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '3200',
      newPrice: '2599',
    ),
    HomeProduct(
      id: 15,
      title: 'Formal Shoes',
      imageUrl:
          'https://images.unsplash.com/photo-1614252369475-531eba835eb1'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '5200',
      newPrice: '4299',
    ),
    HomeProduct(
      id: 16,
      title: 'Fitness Tracker',
      imageUrl:
          'https://images.unsplash.com/photo-1576243345690-4e4b79b63288'
          '?auto=format&fit=crop&w=600&q=80',
      oldPrice: '3900',
      newPrice: '2999',
    ),
  ];

  Future<List<HomeProduct>> fetchForYouProducts({
    required int page,
    required int pageSize,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final start = (page - 1) * pageSize;
    if (start >= _allForYouProducts.length) {
      return const [];
    }

    final end = (start + pageSize).clamp(0, _allForYouProducts.length);
    return _allForYouProducts.sublist(start, end);
  }
}
