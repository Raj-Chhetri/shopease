import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopease/controller/cart_controller.dart';
import 'package:shopease/models/get_address_model.dart';
import 'package:shopease/services/profile_service.dart';
import 'package:shopease/views/address_setup_screen.dart';
import 'package:shopease/views/cartScreen_view.dart';
import 'package:shopease/views/category_view.dart';
import 'package:shopease/views/homescreen.dart';
import 'package:shopease/views/profile_view.dart';
import 'package:shopease/views/wishlist_view.dart';
import 'package:shopease/widgets/bottomNavigationBar.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;
  late final CartController _cartController;
  late final List<Widget?> _pages;
  final ProfileService _profileService = ProfileService();
  bool _isCheckingAddress = true;
  bool _hasDeliveryAddress = false;
  String? _addressError;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _cartController = Get.find<CartController>();
    _pages = List<Widget?>.filled(5, null);
    _pages[_currentIndex] = _createPage(_currentIndex);
    _checkDeliveryAddress();
  }

  Widget _createPage(int index) => switch (index) {
    0 => const HomeScreen(),
    1 => const CategoryPage(),
    2 => const WishlistView(),
    3 => const Cartscreenview(),
    _ => const ProfileScreen(),
  };

  void _selectTab(int index) {
    if (index < 0 || index >= _pages.length) return;
    setState(() {
      _pages[index] ??= _createPage(index);
      _currentIndex = index;
    });

    if (index == 3) {
      _cartController.refreshCart();
    }
  }

  Future<void> _checkDeliveryAddress() async {
    setState(() {
      _isCheckingAddress = true;
      _addressError = null;
    });

    try {
      final response = await _profileService.getAddresses();
      final address = selectCurrentDeliveryAddress(response.data);

      if (!mounted) return;
      setState(() {
        _hasDeliveryAddress = address != null;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _addressError = error.toString().replaceFirst('Exception: ', '').trim();
      });
    } finally {
      if (mounted) {
        setState(() => _isCheckingAddress = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingAddress) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_addressError != null) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off_rounded, size: 62),
                  const SizedBox(height: 16),
                  Text(_addressError!, textAlign: TextAlign.center),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    onPressed: _checkDeliveryAddress,
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text('try_again'.tr),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (!_hasDeliveryAddress) {
      return AddressSetupScreen(
        onAddressSaved: () {
          setState(() => _hasDeliveryAddress = true);
        },
      );
    }

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: List<Widget>.generate(
          _pages.length,
          (index) => _pages[index] ?? const SizedBox.shrink(),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBarWidget(
          currentIndex: _currentIndex,
          cartItemCount: _cartController.totalItemCount,
          onTap: _selectTab,
        ),
      ),
    );
  }
}
