import 'package:equatable/equatable.dart';
import 'package:project_dicoding_fundamental/data/model/dio_category.dart';
import 'package:project_dicoding_fundamental/data/model/dio_menus.dart';
import 'package:project_dicoding_fundamental/data/model/dio_review.dart';

//MODEL CLASS
class DioModel extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final String? city;
  final String? address;
  final String? pictureId;
  final double? rating;
  final List<DioCategory>? categories;
  final DioMenus? menus;
  final List<DioCustomerReviews>? customerReviews;

  const DioModel({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.rating,
    this.categories,
    this.menus,
    this.customerReviews,
  });

  factory DioModel.fromJson(Map<String, dynamic> json) =>
      DioModel(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        city: json['city'] as String?,
        address: json['address'] as String?,
        pictureId: json['pictureId'] as String?,
        rating: (json['rating'] as num?)?.toDouble(),
        categories: (json['categories'] as List<dynamic>?)
            ?.map((e) => DioCategory.fromJson(e as Map<String, dynamic>))
            .toList(),
        menus: json['menus'] == null
            ? null
            : DioMenus.fromJson(json['menus'] as Map<String, dynamic>),
        customerReviews: (json['customerReviews'] as List<dynamic>?)
            ?.map((e) => DioCustomerReviews.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'city': city,
    'pictureId': pictureId,
    'rating': rating,
  };

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    city,
    address,
    pictureId,
    rating,
    categories,
    menus,
    customerReviews,
  ];
}