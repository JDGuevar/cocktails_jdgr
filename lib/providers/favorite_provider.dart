import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final Set<String> _favoriteDrinkIds = {};
  final List<Map<String, dynamic>> _favoriteDrinks = [];

  bool isFavorite(String id) => _favoriteDrinkIds.contains(id);

  List<Map<String, dynamic>> get favoriteDrinks => _favoriteDrinks;

  void toggleFavorite(Map<String, dynamic> drink) {
    String id = drink['idDrink'];
    if (_favoriteDrinkIds.contains(id)) {
      _favoriteDrinkIds.remove(id);
      _favoriteDrinks.removeWhere((d) => d['idDrink'] == id);
    } else {
      _favoriteDrinkIds.add(id);
      _favoriteDrinks.add(drink);
    }
    notifyListeners();
  }
}