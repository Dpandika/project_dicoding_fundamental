import 'package:get_it/get_it.dart';
import 'package:project_dicoding_fundamental/data/db/dio_database.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_favorite_provider.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_search_provider.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_detail_provider.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_restaurant_provider.dart';
import 'package:project_dicoding_fundamental/restaurant/provider/dio_scheduling_provider.dart';
import 'package:project_dicoding_fundamental/data/api/dio_api.dart';
import 'package:project_dicoding_fundamental/data/preferences/dio_preferences.dart';

final getLocator = GetIt.instance;

void init() {
  getLocator.registerFactory(
        () => DioProviderRestaurant(myDioAPI: DioAPI()),
  );
  getLocator.registerFactory(
        () => DioProviderRestaurantDetail(apiService: DioAPI()),
  );
  getLocator.registerFactory(
        () => DioProviderRestaurantSearch(DioAPI()),
  );
  getLocator.registerFactory(
        () => DioProviderFavorite(myDatabase: DioDatabase()),
  );
  getLocator.registerFactory(
        () => DioProviderScheduling(),
  );
  getLocator.registerFactory(
        () => DioPreferences(),
  );
}
