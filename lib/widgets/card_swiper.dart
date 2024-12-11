import 'package:card_swiper/card_swiper.dart';
import 'package:cocktails_jdgr/providers/drink_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardSwiper extends StatelessWidget {
  final DrinkProvider drinkProvider;
  final int selection;

  CardSwiper(this.selection, {super.key}) : drinkProvider = DrinkProvider.randomSelection(selection);

  @override
  Widget build(BuildContext context) {
    //Provider.of<DrinkProvider>(context)
    final size = MediaQuery.of(context).size;

    return ChangeNotifierProvider.value(
      value: drinkProvider,
      child: Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Consumer<DrinkProvider>(
          builder: (context, provider, child) {
            if (provider.drinksList.length < selection) {
              return const Center(child: CircularProgressIndicator());
            }

            return Swiper(
              itemCount: provider.drinksList.length,
              layout: SwiperLayout.STACK,
              itemWidth: size.width * 0.6,
              itemHeight: size.height * 0.4,
              itemBuilder: (BuildContext context, int index) {
                if (index >= provider.drinksList.length) {
                  return const Center(child: Text('No more items'));
                }

                final imageUrl = provider.drinksList[index]['strDrinkThumb'] ?? 'https://via.placeholder.com/300x400';
                final id = provider.drinksList[index]['idDrink'];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'details', arguments: id),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/no-image.jpg'),
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}