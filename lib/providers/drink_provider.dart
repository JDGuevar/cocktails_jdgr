import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'drinks.dart';

class DrinkProvider extends ChangeNotifier {
  final String _baseUrl = 'www.thecocktaildb.com';
  final String _path = 'api/json/v1/1/';
  String _search = 'random';
  String _searchCategory = '';
  String _searchValue = '';

  List<Map<String, dynamic>> drinksList = [];

  // un unico constructor, separar en métodos que hagan lo que estas clases, arreglar en drink slider y card swiper

  DrinkProvider() {
    print('DrinkProvider');
    getDrinks();
  }

  DrinkProvider.search(this._search, this._searchCategory, this._searchValue) {
    print('DrinkProvider.search');
    getDrinks();
  }

  DrinkProvider.randomSelection(int selection) {
    print('DrinkProvider.randomSelection');
    _search = 'random';
    getDrink(selection);
  }

  void getDrink(int selection) async {
    var url = Uri.https(_baseUrl, ("$_path$_search.php"), {
      _searchCategory: _searchValue,
    });

    // Await the http get response, then decode the json-formatted response.
    for (var i = 0; i < selection; i++) {
      var response = await http.get(url);
      final body = jsonDecode(response.body);
      List<Map<String, dynamic>> drinksListRandom = Drink.fromMap(body).drinks;
      if (drinksListRandom.isNotEmpty) {
        drinksList.add(drinksListRandom[0]);
      }
    }

    notifyListeners();
  }

  void getDrinks() async {
    var url = Uri.https(_baseUrl, ("$_path$_search.php"), {
      _searchCategory: _searchValue,
    });

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    final body = jsonDecode(response.body);
    drinksList = Drink.fromMap(body).drinks;
    notifyListeners();
  }
}
