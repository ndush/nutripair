import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DietaryPreferences extends StatefulWidget {
  @override
  _DietaryPreferencesState createState() => _DietaryPreferencesState();
}

class _DietaryPreferencesState extends State<DietaryPreferences> {
  bool isVegan = false;
  bool isKeto = false;
  bool isGlutenFree = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isVegan = prefs.getBool('isVegan') ?? false;
      isKeto = prefs.getBool('isKeto') ?? false;
      isGlutenFree = prefs.getBool('isGlutenFree') ?? false;
    });
  }

  _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isVegan', isVegan);
    prefs.setBool('isKeto', isKeto);
    prefs.setBool('isGlutenFree', isGlutenFree);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Preferences saved!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dietary Preferences')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              title: Text("Vegan"),
              value: isVegan,
              onChanged: (bool? value) {
                setState(() {
                  isVegan = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Keto"),
              value: isKeto,
              onChanged: (bool? value) {
                setState(() {
                  isKeto = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Gluten-Free"),
              value: isGlutenFree,
              onChanged: (bool? value) {
                setState(() {
                  isGlutenFree = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: _savePreferences,
              child: Text('Save Preferences'),
            ),
          ],
        ),
      ),
    );
  }
}
