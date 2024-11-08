import 'package:flutter/material.dart';
import 'package:nutripair/screens/meal_logging.dart';

class DietaryPreferences extends StatefulWidget {
  @override
  _DietaryPreferencesState createState() => _DietaryPreferencesState();
}

class _DietaryPreferencesState extends State<DietaryPreferences> {
  final List<String> _preferences = [
    'Select',
    'Vegan',
    'Vegetarian',
    'Gluten-Free',
    'Paleo',
  ];
  String? _selectedPreference = 'Select';

  void _savePreferences() {
    if (_selectedPreference != null && _selectedPreference != 'Select') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preference saved: $_selectedPreference')),
      );

      Navigator.pushReplacement(
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(AssetImage('assets/images/a.jpg'), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/a.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.6), BlendMode.colorBurn),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Select Your Favorite Diet',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: _selectedPreference,
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePreferences,
                child: Text(
                  'Save Preference',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
