import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'package:project_dicoding_fundamental/common/dio_style.dart';

class DioConnection extends StatelessWidget {
  const DioConnection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/internet_gagal.json",
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          const SizedBox(height: 24),
          DelayedDisplay(
            delay: const Duration(seconds: 2),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  color: dioColorSecond,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "TIDAK ADA INTERNET!",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    color: dioColorPrime.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
