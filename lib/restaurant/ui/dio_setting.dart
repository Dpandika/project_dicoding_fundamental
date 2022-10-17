// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project_dicoding_fundamental/common/dio_style.dart';
import 'package:project_dicoding_fundamental/data/preferences/dio_preferences.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_scheduling_provider.dart';

class DioSettings extends StatefulWidget {
  static const DIO_NAME = '/Dio_Settings';
  static const dioMySettingTitle = 'PENGATURAN';
  const DioSettings({Key? key}) : super(key: key);

  @override
  State<DioSettings> createState() => _DioHomes();
}

class _DioHomes extends State<DioSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "PENGATURANKU",
          style: dioHeading4.copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: ListTile(
          title: Text(
            'Notification Switch',
            style: dioHeading4,
          ),
          subtitle: Text(
            'Active notification',
            style: dioBodyText1,
          ),
          trailing: Consumer2<DioProviderScheduling, DioPreferences>(
            builder: (context, schedule, notifSwitch, child) {
              notifSwitch.dioLoadNotification();
              return Switch(
                activeColor: dioColorSecond,
                inactiveThumbColor: dioColorPrime,
                value: notifSwitch.isDioNotification,
                onChanged: (value) {
                  schedule.schedulingRestaurants(value);
                  notifSwitch.enableNotification(value);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
