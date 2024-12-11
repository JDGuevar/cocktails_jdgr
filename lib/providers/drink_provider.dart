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

  DrinkProvider() {
    print('DrinkProvider');
    getDrinks();
  }

  DrinkProvider.search(this._search, this._searchCategory, this._searchValue) {
    print('DrinkProvider.search');
    getDrinks();
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