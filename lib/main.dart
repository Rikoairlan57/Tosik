import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
import 'package:http/http.dart' as http;
import 'package:tosik/common/navigation.dart';
import 'package:tosik/data/api/api_service.dart';
import 'package:tosik/data/db/database_helper.dart';
import 'package:tosik/provider/scheduling_provider.dart';
import 'package:tosik/ui/home_screen.dart';
import 'package:tosik/utils/background_service.dart';
import 'package:tosik/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(
            apiService: ApiService(
              http.Client(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantSearchProvider(
            apiService: ApiService(
              http.Client(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
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
        routes: {
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
