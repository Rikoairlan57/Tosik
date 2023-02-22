import 'package:flutter/material.dart';
import 'package:tosik/common/styles.dart';
import 'package:tosik/data/model/restaurant_list_model.dart';
import 'package:tosik/ui/restaurant_detail_screen.dart';
import 'package:tosik/ui/restaurant_screen.dart';
import 'package:tosik/ui/search_screen.dart';
import 'package:tosik/ui/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tosik',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.white,
              secondary: secondaryColor,
            ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: myTextTheme,
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        RestaurantScreen.routeName: (_) => const RestaurantScreen(),
        RestaurantDetailScreen.routeName: (context) => RestaurantDetailScreen(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as RestaurantModel),
        SearchScreen.routeName: (_) => const SearchScreen(),
      },
    );
  }
}
