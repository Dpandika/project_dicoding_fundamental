// ignore_for_file: constant_identifier_names

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:project_dicoding_fundamental/common/dio_style.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_detail.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_favorite.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_home.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_setting.dart';
import 'package:project_dicoding_fundamental/utils/dio_connection.dart';
import 'package:project_dicoding_fundamental/utils/dio_notify.dart';

class DioMain extends StatefulWidget {
  static const DIO_NAME = '/Dio_Main';
  const DioMain({Key? key}) : super(key: key);

  @override
  State<DioMain> createState() => _MyDioMain();
}

class _MyDioMain extends State<DioMain> {
  int indexDioButtom = 0;
  static const String dioMyHomeTitle = 'BERANDA';
  final DioNotify _myDioNotification = DioNotify();

  final List<Widget> _listDioPage = [
    const DioHome(),
    const DioFavorite(),
    const DioSettings(),
  ];

  final List<BottomNavigationBarItem> _dioBottomNavigationBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_filled),
      label: dioMyHomeTitle,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_rounded),
      label: DioFavorite.dioMyFavoriteTitle,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: DioSettings.dioMySettingTitle,
    ),
  ];

  void _dioBottomNavigation(int index) {
    setState(() {
      indexDioButtom = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _myDioNotification.configureMyNotification(
      DioDetail.DIO_NAME,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Connectivity connectivity = Connectivity();
    ConnectivityResult isNone = ConnectivityResult.none;
    return StreamBuilder<ConnectivityResult>(
      stream: connectivity.onConnectivityChanged,
      builder: (context, snapshot) {
        if (snapshot.data != isNone) {
          return Scaffold(
            body: _listDioPage[indexDioButtom],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: indexDioButtom,
              items: _dioBottomNavigationBarItem,
              onTap: _dioBottomNavigation,
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: dioColorPrime,
            body: DioConnection(),
          );
        }
      },
    );
  }
}
