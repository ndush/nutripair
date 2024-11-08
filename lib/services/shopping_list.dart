class ShoppingListService {
  List<String> generateShoppingList(List<Map<String, dynamic>> meals) {
    final ingredients = <String>{};
    for (var meal in meals) {
      ingredients.addAll(meal['ingredients']);
    }
    return ingredients.toList();
  }
}
