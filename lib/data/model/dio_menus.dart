import 'package:equatable/equatable.dart';
import 'package:project_dicoding_fundamental/data/model/dio_food_drink.dart';

//MENUS CLASS
class DioMenus extends Equatable {
  final List<DioFoodAndDrink>? foods;
  final List<DioFoodAndDrink>? drinks;

  const DioMenus({this.foods, this.drinks});

  factory DioMenus.fromJson(Map<String, dynamic> json) => DioMenus(
    foods: (json['foods'] as List<dynamic>?)
        ?.map((e) => DioFoodAndDrink.fromJson(e as Map<String, dynamic>))
        .toList(),
    drinks: (json['drinks'] as List<dynamic>?)
        ?.map((e) => DioFoodAndDrink.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'foods': foods?.map((e) => e.toJson()).toList(),
    'drinks': drinks?.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [foods, drinks];
}
