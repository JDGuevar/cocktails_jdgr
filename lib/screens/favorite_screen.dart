import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cocktails_jdgr/providers/favorite_provider.dart';
import 'package:cocktails_jdgr/widgets/card_holder.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favoriteDrinks = favoriteProvider.favoriteDrinks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Drinks'),
      ),
      body: favoriteDrinks.isEmpty
          ? const Center(child: Text('No favorite drinks'))
          : CardHolder(drinks: favoriteDrinks),
    );
  }
}