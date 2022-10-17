import 'dart:ui';

import 'package:flutter/material.dart';

class DioGlassEffect extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const DioGlassEffect({
    Key? key,
    required this.child,
    this.width = 0,
    this.height = 0,
    this.padding,
    this.borderRadius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          height: height,
          width: width,
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.grey.shade100.withOpacity(0.2),
          ),
          child: child,
        ),
      ),
    );
  }
}
