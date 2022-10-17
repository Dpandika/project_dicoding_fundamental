import 'package:equatable/equatable.dart';

//CATEGORY CLASS
class DioCategory extends Equatable {
  final String? name;

  const DioCategory({this.name});

  factory DioCategory.fromJson(Map<String, dynamic> json) => DioCategory(
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
  };

  @override
  List<Object?> get props => [name];
}