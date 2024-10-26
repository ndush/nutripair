import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv

Future<List<dynamic>> fetchMeals() async {
  // Load the SharedPreferences instance
  final prefs = await SharedPreferences.getInstance();
  String diet = '';

  // Check user-selected dietary preferences
  if (prefs.getBool('isVegan') == true) diet += 'vegan,';
  if (prefs.getBool('isKeto') == true) diet += 'keto,';
  if (prefs.getBool('isGlutenFree') == true) diet += 'gluten-free,';

  // Remove trailing comma if any dietary preferences were added
  if (diet.isNotEmpty) diet = diet.substring(0, diet.length - 1);

  // Get API key from .env file
  final apiKey = dotenv.env['API_KEY'];

  // Make the API request to fetch meals based on dietary preferences
  final response = await http.get(Uri.parse(
      'https://api.spoonacular.com/recipes/complexSearch?diet=$diet&apiKey=$apiKey'));

  // Check for successful response
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['results']; // Return the meal suggestions
  } else {
    throw Exception('Failed to load meals: ${response.statusCode}');
  }
}
