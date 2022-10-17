import 'package:flutter/foundation.dart';

import 'package:project_dicoding_fundamental/data/model/dio_model.dart';
import 'package:project_dicoding_fundamental/data/db/dio_database.dart';
import 'package:project_dicoding_fundamental/utils/dio_result.dart';

class DioProviderFavorite extends ChangeNotifier {
  DioProviderFavorite({required this.myDatabase}) {
    _dioGetFavorite();
  }
  DioDatabase myDatabase;

  List<DioModel> _myFavorites = [];
  List<DioModel> get favorite => _myFavorites;

  late DioResult _state;
  DioResult get state => _state;

  String _message = '';
  String get message => _message;

  Future<bool> isFavoriteRestaurants(String id) async {
    final favoriteRestaurant = await myDatabase.getFavoriteByUrl(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void _dioGetFavorite() async {
    await myDatabase.getFavorites().then((value) => _myFavorites = value);
    if (_myFavorites.isNotEmpty) {
      _state = DioResult.hasData;
    } else {
      _state = DioResult.noData;
      _message = 'EMPETY DATA';
    }
    notifyListeners();
  }

  void dioAddFavorite(DioModel restaurant) async {
    try {
      await myDatabase.insertFavorite(restaurant);
      _dioGetFavorite();
    } catch (e) {
      _state = DioResult.error;
      _message = 'ERROR: $e';
      notifyListeners();
    }
  }

  void dioNotFavorite(String id) async {
    try {
      await myDatabase.dioNotFavorite(id);
      _dioGetFavorite();
    } catch (e) {
      _state = DioResult.error;
      _message = 'ERROR: $e';
      notifyListeners();
    }
  }
}
