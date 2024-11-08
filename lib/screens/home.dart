import 'package:flutter/material.dart';
import 'package:nutripair/screens/preferences.dart';
import 'package:nutripair/screens/meal_logging.dart';
import 'package:nutripair/widgets/meal_chart.dart';
import 'package:nutripair/widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DietaryPreferences(),
    MealLogging(),
    MealChart(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
