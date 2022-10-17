import 'package:flutter/material.dart';

import 'package:project_dicoding_fundamental/common/dio_style.dart';

class DioCardsMenu extends StatelessWidget {
  const DioCardsMenu({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  final String imageUrl;
  final String name;
  final String description;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(14),
      color: dioColorPrime,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          height: 180,
          padding: const EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 105,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: dioColorWhite2,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                ),
                child: Image.asset(imageUrl),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: dioBodyText2,
                    ),
                    Text(
                      description,
                      maxLines: 2,
                      style: dioLine.copyWith(color: dioColorWhite2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
