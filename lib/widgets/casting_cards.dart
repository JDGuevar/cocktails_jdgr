import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {
  final Map<String, dynamic> drink;
  CastingCards({required this.drink});

  List<Map<String, dynamic>> ingredients = [];
 
  void getIngredients(){
    for (var i = 1; i < 16; i++) {
      if (drink['strIngredient$i'] != null && drink['strIngredient$i'] != '') {
        ingredients.add({
          'ingredient': drink['strIngredient$i'],
          'measure': drink['strMeasure$i'],
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getIngredients();
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 220,
      // color: Colors.red,
      child: ListView.builder(
          itemCount: ingredients.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) => _CastCard(ingredient: ingredients[index])),
    );
  }
}

class _CastCard extends StatelessWidget {

  final Map<String, dynamic> ingredient;

  _CastCard({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    final imgURL = 'https://www.thecocktaildb.com/images/ingredients/${ingredient['ingredient'].replaceAll(' ', '%20')}.png';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 120,
      // color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(imgURL),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            ingredient['measure']!= null && ingredient['measure']!=''
             ? ingredient['ingredient'] + '\n' + ingredient['measure'] : ingredient['ingredient'],
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
