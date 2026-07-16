import 'package:flutter/material.dart';
import 'package:shopease/views/cartScreen_view.dart';
import 'package:shopease/views/category_view.dart';
import 'package:shopease/views/homescreen.dart';
import 'package:shopease/views/profile_view.dart';
import 'package:shopease/views/wishlist_view.dart';
import 'package:shopease/widgets/bottomNavigationBar.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          CategoryPage(),
          Wishlistview(),
          Cartscreenview(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
