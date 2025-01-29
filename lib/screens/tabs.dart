import 'package:flutter/material.dart';
import 'package:mool/screens/cart.dart';
import 'package:mool/screens/categories.dart';
import 'package:mool/screens/discover.dart';
import 'package:mool/screens/home.dart';
import 'package:mool/screens/my_account.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _activeScreenIndex = 0;
  bool _showBottomNav = true;

  final List<Widget> _screens = [
    Home(),
    Categories(),
    Discover(),
    CartScreen(),
    MyAccount(),
  ];

  void _selectScreen(int index) {
    setState(() {
      _activeScreenIndex = index;
      _showBottomNav = index != 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_activeScreenIndex],
      bottomNavigationBar: _showBottomNav ? _bottomNavBar() : null,
    );
  }

  Widget _bottomNavBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 4),
      decoration: BoxDecoration(
        color: Color(0xff292D32),
        borderRadius: BorderRadius.circular(20),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 12,
        selectedItemColor: Color(0xff33CCCC),
        unselectedItemColor: Colors.white,
        currentIndex: _activeScreenIndex,
        onTap: _selectScreen,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '',
          ),
        ],
      ),
    );
  }
}
