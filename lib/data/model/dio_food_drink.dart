import 'package:equatable/equatable.dart';

//FOOD AND DRINK CLASS
class DioFoodAndDrink extends Equatable {
final String? name;

const DioFoodAndDrink({this.name});

factory DioFoodAndDrink.fromJson(Map<String, dynamic> json) => DioFoodAndDrink(
name: json['name'] as String?,
);

Map<String, dynamic> toJson() => {
'name': name,
};

@override
List<Object?> get props => [name];
}