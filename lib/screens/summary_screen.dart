import 'package:flutter/material.dart';
import 'package:nutripair/database/database_helper.dart';

class MealSummaryScreen extends StatefulWidget {
  @override
  _MealSummaryScreenState createState() => _MealSummaryScreenState();
}

class _MealSummaryScreenState extends State<MealSummaryScreen> {
  late Future<List<Map<String, dynamic>>> _loggedMeals;

  @override
  void initState() {
    super.initState();
    _loggedMeals = DatabaseHelper().getLoggedMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Logged Meals')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loggedMeals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching meals'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No meals logged'));
          }

          final meals = snapshot.data!;
          return ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return ListTile(
                title: Text(meal['title']),
                subtitle: Text(meal['nutritionalInfo']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await DatabaseHelper().deleteMeal(meal['id']);
                    setState(() {
                      _loggedMeals = DatabaseHelper().getLoggedMeals();
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
