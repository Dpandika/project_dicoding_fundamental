import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:project_dicoding_fundamental/common/dio_style.dart';
import 'package:project_dicoding_fundamental/restaurant/ui/dio_main.dart';

class DioCoding extends StatefulWidget {
  const DioCoding({Key? key}) : super(key: key);

  @override
  State<DioCoding> createState() => _DioCodingState();
}

class _DioCodingState extends State<DioCoding> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 6),
          () => Navigator.pushReplacementNamed(context, DioMain.DIO_NAME),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dioColorPrime,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/diocoding.png'),
              ),
              const SizedBox(height: 20),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'DIO CODING',
                    textStyle: dioBodyText2.copyWith(
                      fontSize: 32,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 400),
                  ),
                ],
                totalRepeatCount: 5,
                pause: const Duration(milliseconds: 100),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
