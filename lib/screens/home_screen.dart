import 'package:flutter/material.dart';
import 'package:cocktails_jdgr/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('El rincón del bebedor'),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Flexible(
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(10),

              // Slider de pel·licules
              DrinkSlider('Hecho con vodka', 'filter', 'i', 'vodka'),
              DrinkSlider('Hecho con ron', 'filter', 'i', 'rum'),
              DrinkSlider('Hecho con ginebra', 'filter', 'i', 'gin'),
              DrinkSlider.simple('Random', 'random'),
            ],
          ),
        ),
      ),
    );
  }
}
