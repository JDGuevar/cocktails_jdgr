import 'package:card_swiper/card_swiper.dart';
import 'package:cocktails_jdgr/providers/drink_provider.dart';
import 'package:cocktails_jdgr/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardSwiper extends StatelessWidget {
  final int selection;

  CardSwiper(this.selection, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final drinkProvider = Provider.of<DrinkProvider>(context);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: drinkProvider.randomSelection(selection),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading drinks'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No drinks available'));
          }

          final drinks = snapshot.data!;

          return Swiper(
            itemCount: drinks.length,
            layout: SwiperLayout.STACK,
            itemWidth: size.width * 0.6,
            itemHeight: size.height * 0.4,
            itemBuilder: (BuildContext context, int index) {
              if (index >= drinks.length) {
                return const Center(child: Text('No more items'));
              }

              final imageUrl = drinks[index]['strDrinkThumb'] ?? 'https://fakeimg.pl/300x400';
              final id = drinks[index]['idDrink'];
              final isFavorite = favoriteProvider.isFavorite(id);

              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'details', arguments: id),
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/no-image.jpg'),
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (isFavorite)
                      const Positioned(
                        top: 10,
                        right: 20,
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 24,
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}