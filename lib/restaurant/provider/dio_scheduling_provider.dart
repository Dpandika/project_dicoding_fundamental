import 'package:flutter/foundation.dart';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:project_dicoding_fundamental/utils/dio_background.dart';
import 'package:project_dicoding_fundamental/utils/dio_date_time.dart';

class DioProviderScheduling extends ChangeNotifier {
  bool _isMyScheduling = false;
  bool get isMyScheduling => _isMyScheduling;

  Future<bool> schedulingRestaurants(bool value) async {
    _isMyScheduling = value;
    if (_isMyScheduling) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        DioBackground.callback,
        startAt: DioDateTime.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      notifyListeners();

      return await AndroidAlarmManager.cancel(1);
    }
  }
}