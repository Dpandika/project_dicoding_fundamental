import 'package:equatable/equatable.dart';

//CUSTOMER REVIEW CLASS
class DioCustomerReviews extends Equatable {
  final String? name;
  final String? review;
  final String? date;

  const DioCustomerReviews({this.name, this.review, this.date});

  factory DioCustomerReviews.fromJson(Map<String, dynamic> json) {
    return DioCustomerReviews(
      name: json['name'] as String?,
      review: json['review'] as String?,
      date: json['date'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'review': review,
    'date': date,
  };

  @override
  List<Object?> get props => [name, review, date];
}
