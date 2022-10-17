import 'package:flutter/material.dart';

import 'package:project_dicoding_fundamental/common/dio_style.dart';

class DioButton extends StatelessWidget {
  final String icon;
  final Color iconColor;
  final Function() onTap;
  const DioButton({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: iconColor,
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        hoverColor: Colors.white,
        onTap: onTap,
        child: Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(15),
          child: Image.asset(
            icon,
            color: dioColorWhite2,
          ),
        ),
      ),
    );
  }
}
