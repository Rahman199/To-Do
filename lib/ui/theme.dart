import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color.fromARGB(218, 126, 2, 60);
const Color orangeClr = Color(0xCFFF8746);
const Color taskClr = Color.fromARGB(246, 48, 44, 45);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: Colors.teal,
    backgroundColor: Color.fromARGB(230, 248, 248, 248),
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: Color.fromARGB(255, 4, 113, 156),
    backgroundColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get subHheadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get titelStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get subTitelStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w300,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get bodyStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get body2Style {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: Get.isDarkMode ? Colors.grey[200] : Colors.black,
  ));
}
