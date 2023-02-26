import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tosik/common/styles.dart';
import 'package:tosik/data/model/restaurant_list_model.dart';
import 'package:tosik/data/preferences/preferences_helper.dart';
import 'package:tosik/provider/database_provider.dart';
import 'package:tosik/provider/preferences_provider.dart';
import 'package:tosik/provider/restaurant_list_provider.dart';
import 'package:tosik/provider/restaurant_search_provider.dart';
import 'package:tosik/ui/restaurant_detail_screen.dart';
import 'package:tosik/ui/restaurant_screen.dart';
import 'package:tosik/ui/search_screen.dart';
import 'package:tosik/ui/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'common/navigation.dart';
import 'data/api/api_service.dart';
import 'data/db/database_helper.dart';
import 'ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(
            apiService: ApiService(http.Client()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantSearchProvider(
            apiService: ApiService(http.Client()),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        )
      ],
      child: MaterialApp(
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
        navigatorKey: navigatorKey,
        initialRoute: HomeScreen.routeName,
        // initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (_) => const SplashScreen(),
          HomeScreen.routeName: (_) => const HomeScreen(),
          RestaurantScreen.routeName: (_) => const RestaurantScreen(),
          RestaurantDetailScreen.routeName: (context) => RestaurantDetailScreen(
              restaurant: ModalRoute.of(context)?.settings.arguments
                  as RestaurantModel),
          SearchScreen.routeName: (_) => const SearchScreen(),
        },
      ),
    );
  }
}
