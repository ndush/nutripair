import 'package:flutter/material.dart';
import 'package:nutripair/database/database_helper.dart';
import 'package:nutripair/screens/summary_screen.dart';
import 'package:nutripair/services/api_service.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;

  RecipeDetailScreen({Key? key, required this.recipeId}) : super(key: key);

  Future<Map<String, dynamic>?> _fetchRecipeDetails(String id) async {
    try {
      return await ApiService().getRecipeInformation(int.parse(id));
    } catch (e) {
      return null;
    }
  }

  Future<void> _logMeal(BuildContext context) async {
    final recipe = await _fetchRecipeDetails(recipeId);

    if (recipe == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load recipe details. Please try again.')),
      );
      return;
    }

    try {
      await DatabaseHelper().insertMeal({
        'title': recipe['title'] ?? 'Unknown',
        'nutritionalInfo': recipe['nutrition']?['nutrients']?.toString() ?? 'No nutrition info',
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MealSummaryScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log meal. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe Details')),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchRecipeDetails(recipeId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text('Error fetching recipe details.'));
          } else {
            final recipe = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe['title'] ?? 'No title available',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Nutritional Information:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ...(recipe['nutrition'] != null && recipe['nutrition']['nutrients'] != null
                        ? recipe['nutrition']['nutrients'].map<Widget>((nutrient) {
                      // Check for null values and format them properly
                      final nutrientName = nutrient['name'] ?? 'Unknown nutrient';
                      final nutrientAmount = nutrient['amount'] ?? 'N/A';
                      final nutrientUnit = nutrient['unit'] ?? '';
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          '$nutrientName: $nutrientAmount $nutrientUnit',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList()
                        : [Text('No nutritional information available')]),
                    SizedBox(height: 16),
                    Text(
                      'Ingredients:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ...(recipe['extendedIngredients'] != null
                        ? recipe['extendedIngredients']!
                        .map<Widget>((ingredient) => Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('- ${ingredient['original'] ?? 'Unknown ingredient'}', style: TextStyle(fontSize: 16)),
                    ))
                        .toList()
                        : [Text('No ingredients available')]),
                    SizedBox(height: 16),
                    Text(
                      'Instructions:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(recipe['instructions'] ?? 'No instructions available', style: TextStyle(fontSize: 16)),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _logMeal(context),
                      child: Text('Log Meal'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
