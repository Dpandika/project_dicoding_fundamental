import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigationDio = GlobalKey<NavigatorState>();

class DioNavigation {
  static inMyData(String myNamesDioRoute, Object arguments) {
    navigationDio.currentState?.pushNamed(myNamesDioRoute, arguments: arguments);
  }

  static come() => navigationDio.currentState?.pop();
}
