import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'drinks.dart';

class DrinkProvider extends ChangeNotifier {
  final String _baseUrl = 'www.thecocktaildb.com';
  final String _path = 'api/json/v1/1/';
  final String _search = 'random';
  final String _searchCategory = '';
  final String _searchValue = '';
  List<Map<String, dynamic>> drinksList = [];

  DrinkProvider() {
    print('DrinkProvider');
  }

  Future<List<Map<String, dynamic>>> search(
      search, searchCategory, searchValue) async {
    print('DrinkProvider.search');
    List<Map<String, dynamic>> drinks = [];

    try {
      var url = Uri.https(_baseUrl, '$_path$search.php', {
        searchCategory: searchValue,
      });
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        drinks = Drink.fromMap(body).drinks;
      } else {
        throw Exception('Failed to load drinks');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load drinks');
    }

    return drinks;
  }

  Future<List<Map<String, dynamic>>> randomSelection(int selection) async {
    print('DrinkProvider.randomSelection');
    List<Map<String, dynamic>> drinks = [];

    try {
      for (var i = 0; i < selection; i++) {
        var url = Uri.https(_baseUrl, '$_path$_search.php', {
          _searchCategory: _searchValue,
        });
        var response = await http.get(url);
        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);
          List<Map<String, dynamic>> drinksListRandom =
              Drink.fromMap(body).drinks;
          if (drinksListRandom.isNotEmpty) {
            drinks.add(drinksListRandom[0]); //se repite a veces
          }
        } else {
          throw Exception('Failed to load drinks');
        }
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load drinks');
    }

    return drinks;
  }

  Future<Map<String, dynamic>> getDrinkById(id) async {
    print('DrinkProvider.getDrinkById');
    Map<String, dynamic> drink = {};

    try {
      var url = Uri.https(_baseUrl, '$_path/lookup.php', {
        'i': id,
      });
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        drink = Drink.fromMap(body).drinks[0];
      } else {
        throw Exception('Failed to load drink');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load drink');
    }

    return drink;
  }
}
