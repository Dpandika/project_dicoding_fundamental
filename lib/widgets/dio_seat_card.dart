import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:project_dicoding_fundamental/common/dio_style.dart';

class DioSeatCard extends StatelessWidget {
  final String pictureId;
  final String name;
  final String description;
  final double rating;
  final Function() onTap;

  const DioSeatCard({
    required this.name,
    required this.description,
    required this.pictureId,
    required this.rating,
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: dioColorWhite2,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          height: 110,
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(
                      '$BASE_IMAGE_URL/$pictureId',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        name,
                        style: dioStyleSub1,
                        maxLines: 1,
                      ),
                      Text(
                        description,
                        style: dioLine,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RatingBarIndicator(
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            rating: rating,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "$rating",
                            style: dioLine,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
