import 'package:flutter/material.dart';

class ShoppingListScreen extends StatelessWidget {
  final List<String> ingredients;

  ShoppingListScreen({required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping List')),
      body: ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context, index) => ListTile(title: Text(ingredients[index])),
      ),
    );
  }
}
