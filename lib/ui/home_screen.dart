import 'package:flutter/material.dart';

import '../common/styles.dart';

import 'restaurant_favorites_screen.dart';
import 'restaurant_screen.dart';
import 'setting_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_page';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottonNavIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      label: 'Restoran',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorit',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Pengaturan',
    ),
  ];

  final List<Widget> _listWidget = [
    const RestaurantScreen(),
    const RestaurantFavoritesScreen(),
    const SettingScreen(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottonNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottonNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottonNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
