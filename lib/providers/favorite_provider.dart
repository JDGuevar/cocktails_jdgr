import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoriteProvider extends ChangeNotifier {
  final Set<String> _favoriteDrinkIds = {};
  final List<Map<String, dynamic>> _favoriteDrinks = [];

  FavoriteProvider() {
    _loadFavorites();
  }

  bool isFavorite(String id) => _favoriteDrinkIds.contains(id);

  List<Map<String, dynamic>> get favoriteDrinks => _favoriteDrinks;

  void toggleFavorite(Map<String, dynamic> drink) async {
    String id = drink['idDrink'];
    if (_favoriteDrinkIds.contains(id)) {
      _favoriteDrinkIds.remove(id);
      _favoriteDrinks.removeWhere((d) => d['idDrink'] == id);
    } else {
      _favoriteDrinkIds.add(id);
      _favoriteDrinks.add(drink);
    }
    await _saveFavorites();
    notifyListeners();
  }

  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteDrinkIds = prefs.getStringList('favoriteDrinkIds') ?? [];
    final favoriteDrinks = prefs.getString('favoriteDrinks') ?? '[]';

    _favoriteDrinkIds.addAll(favoriteDrinkIds);
    _favoriteDrinks.addAll(List<Map<String, dynamic>>.from(json.decode(favoriteDrinks)));
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteDrinkIds', _favoriteDrinkIds.toList());
    await prefs.setString('favoriteDrinks', json.encode(_favoriteDrinks));
  }
}