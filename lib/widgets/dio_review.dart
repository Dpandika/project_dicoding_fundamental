import 'package:flutter/material.dart';

import 'package:project_dicoding_fundamental/common/dio_style.dart';

class DioReview extends StatelessWidget {
  final String name;
  final String review;
  final String date;

  const DioReview({
    Key? key,
    required this.name,
    required this.review,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.toUpperCase(),
                  style: dioStyleSub1,
                ),
                const SizedBox(height: 4),
                Text(
                  review,
                  style: dioBodyText1,
                ),
                const SizedBox(height: 6),
                Text(
                  date,
                  style: dioLine,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
