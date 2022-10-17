import 'package:flutter/foundation.dart';

import 'package:project_dicoding_fundamental/data/api/dio_api.dart';
import 'package:project_dicoding_fundamental/data/model/dio_response.dart';
import 'package:project_dicoding_fundamental/utils/dio_result.dart';

class DioProviderRestaurant extends ChangeNotifier {
  DioProviderRestaurant({required this.myDioAPI}) {
    getListRestaurants();
  }
  final DioAPI myDioAPI;

  late DioToResponse _restaurantsList;
  DioToResponse get restaurantsList => _restaurantsList;

  String _message = '';
  String get message => _message;

  DioResult get state => _state;
  late DioResult _state;

  Future<dynamic> getListRestaurants() async {
    try {
      _state = DioResult.loading;
      notifyListeners();
      final restaurant = await myDioAPI.getRestaurantList();
      if (restaurant.restaurant.isEmpty) {
        _state = DioResult.noData;
        notifyListeners();
        return _message = 'DATA Kosong';
      } else {
        _state = DioResult.hasData;
        notifyListeners();
        return _restaurantsList = restaurant;
      }
    } catch (e) {
      _state = DioResult.error;
      notifyListeners();
      return _message = 'ERROR: Data Gagal Di Muat!';
    }
  }
}