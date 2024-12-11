import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cocktails_jdgr/providers/drink_provider.dart';

class DrinkSlider extends StatelessWidget {
  final String title;
  final String search;
  final String searchCategory;
  final String searchValue;

  DrinkSlider(this.title, this.search, this.searchCategory, this.searchValue, {super.key});

  DrinkSlider.simple(this.title, this.search, {super.key})
      : searchCategory = '',
        searchValue = '';

  @override
  Widget build(BuildContext context) {
    final drinkProvider = Provider.of<DrinkProvider>(context, listen: false);

    return Container(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: drinkProvider.search(search, searchCategory, searchValue),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading drinks'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No drinks available'));
                }

                final drinks = snapshot.data!;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: drinks.length,
                  itemBuilder: (_, int index) {
                    final imageUrl = drinks[index]['strDrinkThumb'] ?? 'https://fakeimg.pl/300x400';
                    final id = drinks[index]['idDrink'];
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'details', arguments: id),
                      child: Container(
                        width: 130,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: FadeInImage(
                                placeholder: const AssetImage('assets/no-image.jpg'),
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                                height: 180,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              drinks[index]['strDrink'] ?? 'No title',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}