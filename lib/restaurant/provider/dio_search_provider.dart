import 'package:flutter/foundation.dart';

import 'package:project_dicoding_fundamental/data/api/dio_api.dart';
import 'package:project_dicoding_fundamental/data/model/dio_response.dart';
import 'package:project_dicoding_fundamental/utils/dio_result.dart';

class DioProviderRestaurantSearch extends ChangeNotifier {
  DioProviderRestaurantSearch(this.apiService);

  final DioAPI apiService;

  late DioToResponse _restaurantsSearch;
  DioToResponse get restaurantsSearch => _restaurantsSearch;

  late DioResult _state;
  DioResult get state => _state;

  String _message = '';
  String get message => _message;

  Future<dynamic> searchingRestaurants(String query) async {
    try {
      _state = DioResult.loading;
      final restaurant = await apiService.getRestaurantQuery(query);
      if (restaurant.restaurant.isEmpty) {
        _state = DioResult.noData;
        notifyListeners();
        return _message = 'DATA IS EMPTY';
      } else {
        _state = DioResult.hasData;
        notifyListeners();
        return _restaurantsSearch = restaurant;
      }
    } catch (e) {
      _state = DioResult.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}