import 'dart:convert';
import 'dart:math';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project_dicoding_fundamental/data/model/dio_response.dart';
import 'package:project_dicoding_fundamental/utils/dio_navigation.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class DioNotify {
  Random myRandom = Random();
  late int myRandomsIndex;

  static DioNotify? _instance;

  DioNotify._internal() {
    _instance = this;
  }

  factory DioNotify() => _instance ?? DioNotify._internal();

  Future<void> initialMyNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('app_icon');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
          selectNotificationSubject.add(
            payload ?? 'empty',
          );
        });
  }

  Future<void> showMyNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      DioToResponse restaurants,
      ) async {
    var channelId = '1';
    var channelName = 'channel_1';
    var channelDesc = 'Restaurant Channel';
    myRandomsIndex = myRandom.nextInt(restaurants.restaurant.length);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );
    var platformChannelSpecific =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    var titleNotification = '<b>My Trend</b>';
    var titleNews = restaurants.restaurant[myRandomsIndex].name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleNews,
      platformChannelSpecific,
      payload: json.encode(
        restaurants.toJson(),
      ),
    );
  }

  void configureMyNotification(String route) {
    selectNotificationSubject.stream.listen((event) {
          (String payload) async {
        var data = DioToResponse.fromJson(jsonDecode(payload));
        var restaurant = data.restaurant[myRandomsIndex];
        DioNavigation.inMyData(route, restaurant.id.toString());
      };
    });
  }
}
