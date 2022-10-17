import 'dart:ui';
import 'dart:isolate';

import 'package:project_dicoding_fundamental/data/api/dio_api.dart';
import 'package:project_dicoding_fundamental/utils/dio_notify.dart';
import 'package:project_dicoding_fundamental/main.dart';

final ReceivePort myPort = ReceivePort();

class DioBackground {
  static DioBackground? _inSend;

  static const String _lateName = 'myIsolates';
  static SendPort? _portSend;

  DioBackground._myInternal() {
    _inSend = this;
  }

  factory DioBackground() => _inSend ?? DioBackground._myInternal();

  void initializeLate() {
    IsolateNameServer.registerPortWithName(myPort.sendPort, _lateName);
  }

  static Future<void> callback() async {
    final DioNotify notificationService = DioNotify();
    var meResult = await DioAPI().getRestaurantList();
    await notificationService.showMyNotification(
      flutterLocalNotificationsPlugin,
      meResult,
    );

    _portSend ??= IsolateNameServer.lookupPortByName(_lateName);
    _portSend?.send(null);
  }
}
