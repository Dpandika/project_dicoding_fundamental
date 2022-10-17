import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioPreferences extends ChangeNotifier {
  static const String notificationDioPrefs = 'notification';
  bool _isDioNotification = true;
  bool get isDioNotification => _isDioNotification;

  void enableNotification(bool value) async {
    final dioPref = await SharedPreferences.getInstance();
    dioPref.setBool(notificationDioPrefs, value);
    _isDioNotification = value;
    notifyListeners();
  }

  void dioLoadNotification() async {
    final dioPrefs = await SharedPreferences.getInstance();
    _isDioNotification = dioPrefs.getBool(notificationDioPrefs) ?? true;
    notifyListeners();
  }
}
