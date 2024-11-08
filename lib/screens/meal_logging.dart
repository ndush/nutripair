import 'package:flutter/material.dart';
import 'package:nutripair/screens/recipe%20details.dart';
import 'package:nutripair/services/api_service.dart';

class MealLogging extends StatefulWidget {
  final String? selectedPreference;

  MealLogging({Key? key, this.selectedPreference}) : super(key: key);

  @override
  _MealLoggingState createState() => _MealLoggingState();
}

class _MealLoggingState extends State<MealLogging> {
  final ApiService _apiService = ApiService();
  List<dynamic> _recipes = [];
  String _query = '';
  late String _selectedDiet;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedDiet = widget.selectedPreference?.toLowerCase() ?? 'vegan';
  }

  void _searchRecipes() async {
    if (_query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a search term.')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final recipes = await _apiService.searchRecipes(_query, _selectedDiet);
      setState(() {
        _recipes = recipes;
      });
    } catch (e) {
      print("Error fetching recipes: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching recipes. Please try again.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _clearSearch() {
    setState(() {
      _query = '';
      _recipes = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meal Logging')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Search for recipes'),
              onChanged: (value) {
                _query = value;
              },
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedDiet,
              items: <String>['vegan', 'vegetarian', 'gluten-free', 'paleo']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDiet = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _searchRecipes,
                  child: Text('Search'),
                ),
                ElevatedButton(
                  onPressed: _clearSearch,
                  child: Text('Clear'),
                ),
              ],
            ),
            if (isLoading)
              Center(child: CircularProgressIndicator()),
            Expanded(
              child: _recipes.isEmpty && !isLoading
                  ? Center(child: Text('No recipes found.'))
                  : ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_recipes[index]['title']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(recipeId: _recipes[index]['id'].toString()),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
