import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cocktails_jdgr/providers/drink_provider.dart';

class DrinkSlider extends StatelessWidget {
  final String title;
  late final DrinkProvider drinkProvider;

  DrinkSlider(this.title, search, searchCategory, searchValue, {super.key}) {
    drinkProvider = DrinkProvider.search(search, searchCategory, searchValue);
  }

  DrinkSlider.simple(this.title, search, {super.key}) {
    drinkProvider = DrinkProvider.search(search, '', '');
  }

  @override
  Widget build(BuildContext context) {
    //Provider.of<DrinkProvider>(context)
    return ChangeNotifierProvider.value(
      value: drinkProvider,
      child: SizedBox(
        width: double.infinity,
        height: 280,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Consumer<DrinkProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.drinksList.length,
                    itemBuilder: (_, int index) => DrinkPoster(index: index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrinkPoster extends StatelessWidget {
  final int index;

  const DrinkPoster({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final drinks = Provider.of<DrinkProvider>(context).drinksList;
    final imageUrl = drinks.isNotEmpty && drinks[index]['strDrinkThumb'] != null
        ? drinks[index]['strDrinkThumb']
        : 'https://via.placeholder.com/300x400';
    final String title = drinks.isNotEmpty && drinks[index]['strDrink'] != null
        ? drinks[index]['strDrink']
        : 'No title';

    return Container(
      width: 130,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ajusta el tamaño del Column al contenido
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: 'detalls peli'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(imageUrl),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5), // Espacio entre la imagen y el texto
          Flexible(
            child: Text(
              title,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}