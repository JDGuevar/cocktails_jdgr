import 'dart:convert';

class Drink {
  List<Map<String, dynamic>> drinks;

  Drink({
    required this.drinks,
  });

  factory Drink.fromJson(String str) => Drink.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Drink.fromMap(Map<String, dynamic> json) {
    if (json.containsKey('drinks') && json['drinks'] is List) {
      return Drink(
        drinks: List<Map<String, dynamic>>.from(
          (json['drinks'] as List).map(
            (x) => Map<String, dynamic>.from(x as Map<String, dynamic>),
          ),
        ),
      );
    } else {
      return Drink(drinks: []);
    }
  }

  Map<String, dynamic> toMap() => {
        'drinks': List<dynamic>.from(
          drinks.map(
            (x) => Map<String, dynamic>.from(x),
          ),
        ),
      };
}