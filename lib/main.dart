import 'package:flutter/material.dart';
import 'package:tosik/common/styles.dart';
import 'package:tosik/data/model/restaurant_list_model.dart';
import 'package:tosik/ui/restaurant_detail.dart';
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
              onPrimary: Colors.black,
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
        SplashScreen.routeName: (context) => const SplashScreen(),
        RestaurantScreen.routeName: (context) => const RestaurantScreen(),
        RestaurantDetail.routeName: (context) => RestaurantDetail(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as RestaurantModel),
        SearchScreen.routeName: (_) => const SearchScreen(),
      },
    );
  }
}
