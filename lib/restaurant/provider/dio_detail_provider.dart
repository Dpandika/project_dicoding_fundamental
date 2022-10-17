import 'package:flutter/foundation.dart';

import 'package:project_dicoding_fundamental/data/api/dio_api.dart';
import 'package:project_dicoding_fundamental/data/model/dio_model.dart';
import 'package:project_dicoding_fundamental/utils/dio_result.dart';

class DioProviderRestaurantDetail extends ChangeNotifier {
  DioProviderRestaurantDetail({required this.apiService});

  final DioAPI apiService;

  late DioModel _restaurantsDetail;
  DioModel get restaurantsDetail => _restaurantsDetail;

  late DioResult _state;
  DioResult get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> getDetailsRestaurants(String id) async {
    try {
      _state = DioResult.loading;
      final restaurant = await apiService.getRestaurantDetail(id);
      if (restaurant.id!.isEmpty) {
        _state = DioResult.noData;
        notifyListeners();
        return _message = 'DATA IS EMPTY';
      } else {
        _state = DioResult.hasData;
        notifyListeners();
        return _restaurantsDetail = restaurant;
      }
    } catch (e) {
      _state = DioResult.error;
      notifyListeners();
      return _message = 'ERROR: $e';
    }
  }
}