import 'package:equatable/equatable.dart';
import 'package:project_dicoding_fundamental/data/model/dio_model.dart';

//RESPONSE CLASS
class DioToResponse extends Equatable {
  final List<DioModel> restaurant;

  const DioToResponse({required this.restaurant});

  factory DioToResponse.fromJson(Map<String, dynamic> json) =>
      DioToResponse(
        restaurant: List<DioModel>.from((json["restaurants"] as List)
            .map((x) => DioModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "restaurants": List<dynamic>.from(restaurant.map((x) => x.toJson())),
  };

  @override
  List<Object?> get props => [restaurant];
}