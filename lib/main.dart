import 'package:cocktails_jdgr/providers/drink_provider.dart';
import 'package:cocktails_jdgr/screens/favorite_screen.dart';
import 'package:cocktails_jdgr/screens/screens.dart';
import 'package:cocktails_jdgr/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DrinkProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cocktails JDGR',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomeScreen(),
        'details': (BuildContext context) => DetailsScreen(),
        'favorites': (BuildContext context) => FavoriteScreen(),
      },
      theme: ThemeData.light()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.indigo)),
    );
  }
}
