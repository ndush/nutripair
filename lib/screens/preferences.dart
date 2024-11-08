import 'package:flutter/material.dart';
import 'package:nutripair/widgets/meal_chart.dart';
import 'meal_logging.dart';
import 'mealplan.dart';
import 'package:nutripair/bottom_nav_bar.dart';

class DietaryPreferences extends StatefulWidget {
  @override
  _DietaryPreferencesState createState() => _DietaryPreferencesState();
}

class _DietaryPreferencesState extends State<DietaryPreferences> {
  final List<String> _preferences = [
    'Vegan',
    'Vegetarian',
    'Gluten-Free',
    'Paleo',
  ];
  String? _selectedPreference;

  int _selectedIndex = 0;

  // List of screens accessible through the bottom nav bar
  final List<Widget> _widgetOptions = [
    MealChart(),          // "Trends" screen with MealChart
    MealPlanningScreen(), // "Meal Plan" screen
  ];

  void _savePreferences() {
    if (_selectedPreference != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preference saved: $_selectedPreference')),
      );

      // Navigate to MealLogging screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealLogging(selectedPreference: _selectedPreference),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a preference')),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dietary Preferences'),
      ),
      body: _selectedIndex == 0
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('This is the Dietary Preferences Screen'),
            DropdownButton<String>(
              items: _preferences.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPreference = newValue;
                });
              },
            ),
            ElevatedButton(
              onPressed: _savePreferences,
              child: Text('Save Preference'),
            ),
          ],
        ),
      )
          : _widgetOptions[_selectedIndex - 1], // Display selected screen (1 or 2)

      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
