import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'injection.dart' as restaurant;
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:project_dicoding_fundamental/utils/dio_background.dart';
import 'package:project_dicoding_fundamental/utils/dio_notify.dart';
import 'package:project_dicoding_fundamental/data/preferences/dio_preferences.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_detail_provider.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_search_provider.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_main.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_coding_page.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_detail.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_favorite.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_search.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_home.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_setting.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_favorite_provider.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_restaurant_provider.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_scheduling_provider.dart';
import 'package:project_dicoding_fundamental/common/dio_style.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  restaurant.init();
  WidgetsFlutterBinding.ensureInitialized();
  final DioNotify notificationHelper = DioNotify();
  final DioBackground service = DioBackground();

  service.initializeLate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initialMyNotification(flutterLocalNotificationsPlugin);

  runApp(
    const DioApp(),
  );
}

class DioApp extends StatelessWidget {
  const DioApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => restaurant.getLocator<DioProviderRestaurant>(),
        ),
        ChangeNotifierProvider(
          create: (_) => restaurant.getLocator<DioProviderRestaurantDetail>(),
        ),
        ChangeNotifierProvider(
          create: (_) => restaurant.getLocator<DioProviderRestaurantSearch>(),
        ),
        ChangeNotifierProvider(
          create: (_) => restaurant.getLocator<DioProviderFavorite>(),
        ),
        ChangeNotifierProvider(
          create: (_) => restaurant.getLocator<DioProviderScheduling>(),
        ),
        ChangeNotifierProvider(
          create: (_) => restaurant.getLocator<DioPreferences>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          colorScheme: dioColorScheme,
          primaryColor: dioColorBlack1,
          scaffoldBackgroundColor: Colors.grey.shade200,
          textTheme: dioTextTheme,
        ),
        home: const DioCoding(),
        onGenerateRoute: (RouteSettings mySettings) {
          switch (mySettings.name) {
            case DioMain.DIO_NAME:
              return MaterialPageRoute(
                builder: (_) => const DioMain(),
              );
            case DioHome.DIO_NAME:
              return MaterialPageRoute(
                builder: (_) => const DioHome(),
              );
            case DioDetail.DIO_NAME:
              final id = mySettings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => DioDetail(id: id),
              );
            case DioFavorite.DIO_NAME:
              return MaterialPageRoute(
                builder: (_) => const DioFavorite(),
              );
            case DioSearch.DIO_NAME:
              return MaterialPageRoute(
                builder: (_) => const DioSearch(),
              );
            case DioSettings.DIO_NAME:
              return MaterialPageRoute(
                builder: (_) => const DioSettings(),
              );
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('HALAMAN TIDAK DITEMUKAN!'),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}