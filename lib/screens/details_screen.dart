import 'package:cocktails_jdgr/providers/drink_provider.dart';
import 'package:cocktails_jdgr/providers/favorite_provider.dart';
import 'package:cocktails_jdgr/widgets/casting_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context)!.settings.arguments.toString();
    final drinkProvider = Provider.of<DrinkProvider>(context, listen: false);

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: drinkProvider.getDrinkById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading drink details'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No drink details available'));
          }

          final drink = snapshot.data!;

          return CustomScrollView(
            slivers: [
              _CustomAppBar(drink: drink),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _PosterAndTitle(drink: drink),
                    _Overview(drink: drink),
                    CastingCards(drink: drink),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Map<String, dynamic> drink;

  const _CustomAppBar({required this.drink});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              drink['strDrink'] ?? 'No title',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(
              drink['strDrinkThumb'] ?? 'https://fakeimg.pl/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Map<String, dynamic> drink;

  const _PosterAndTitle({required this.drink});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFavorite = favoriteProvider.isFavorite(drink['idDrink']);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: 150,
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(
                  drink['strDrinkThumb'] ?? 'https://fakeimg.pl/500x300'),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        drink['strDrink'] ?? 'No title',
                        style: textTheme.headlineMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        favoriteProvider.toggleFavorite(drink);
                      },
                    ),
                  ],
                ),
                Text(
                  drink['strAlcoholic'] ?? 'No category',
                  style: textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Map<String, dynamic> drink;

  const _Overview({required this.drink});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        drink['strInstructionsES'] ??
            drink['strInstructions'] ??
            'No instructions',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}