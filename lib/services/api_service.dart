import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String _baseUrl = 'https://api.spoonacular.com';
  final String _apiKey = dotenv.env['API_KEY'] ?? '';

  Future<List<dynamic>> searchRecipes(String query, String preference) async {
    final response = await http.get(Uri.parse('$_baseUrl/recipes/complexSearch?query=$query&diet=$preference&apiKey=$_apiKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<Map<String, dynamic>> getRecipeInformation(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/recipes/$id/information?apiKey=$_apiKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load recipe information');
    }
  }

  Future<Map<String, dynamic>> getMealPlan() async {
    final response = await http.get(Uri.parse('$_baseUrl/mealplanner/generate?apiKey=$_apiKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to generate meal plan');
    }
  }
}
