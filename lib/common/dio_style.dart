import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: constant_identifier_names
const String BASE_IMAGE_URL =
    'https://restaurant-api.dicoding.dev/images/medium';

// colors
const Color dioColorPrime = Color(0xFF212F3C);
const Color dioColorSecond = Color(0xFFC0392B);
const Color dioColorWhite1 = Color(0xFFF2F5FD);
const Color dioColorWhite2 = Color(0xffFFFFFF);
const Color dioColorGrey1 = Color(0xFF303030);
const Color dioColorBlack1 = Color(0xFF1C2833);

// text style
final TextStyle dioHeading1 = GoogleFonts.poppins(
  color: dioColorBlack1,
  fontSize: 30,
  fontWeight: FontWeight.w600,
);
final TextStyle dioHeading2 = GoogleFonts.poppins(
  color: dioColorWhite2,
  fontSize: 25,
  fontWeight: FontWeight.w600,
);
final TextStyle dioHeading3 = GoogleFonts.poppins(
  color: dioColorBlack1,
  fontSize: 20,
  fontWeight: FontWeight.w600,
);
final TextStyle dioHeading4 = GoogleFonts.poppins(
  color: dioColorSecond,
  fontSize: 18,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
);
final TextStyle dioStyleSub1 = GoogleFonts.poppins(
  color: dioColorBlack1,
  fontSize: 15,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
);

final TextStyle dioStyleSub2 = GoogleFonts.poppins(
  color: dioColorWhite2,
  fontSize: 15,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.15,
);
final TextStyle dioBodyText1 = GoogleFonts.poppins(
  color: dioColorBlack1,
  fontSize: 12,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);
final TextStyle dioBodyText2 = GoogleFonts.poppins(
  color: dioColorWhite2,
  fontSize: 12,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);
final TextStyle dioLine = GoogleFonts.poppins(
  color: dioColorBlack1,
  fontSize: 12,
  fontWeight: FontWeight.w300,
  letterSpacing: 0.25,
);

// text theme
final dioTextTheme = TextTheme(
  headline1: dioHeading1,
  headline2: dioHeading2,
  headline3: dioHeading3,
  headline4: dioHeading4,
  subtitle1: dioStyleSub1,
  subtitle2: dioStyleSub2,
  bodyText1: dioBodyText1,
  bodyText2: dioBodyText2,
  overline: dioLine,
);

const dioColorScheme = ColorScheme(
  primary: dioColorSecond,
  primaryContainer: dioColorSecond,
  secondary: dioColorSecond,
  secondaryContainer: dioColorSecond,
  surface: dioColorBlack1,
  background: dioColorBlack1,
  error: Colors.red,
  onPrimary: dioColorBlack1,
  onSecondary: dioColorBlack1,
  onSurface: dioColorBlack1,
  onBackground: dioColorBlack1,
  onError: dioColorBlack1,
  brightness: Brightness.light,
);