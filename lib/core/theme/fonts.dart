import 'dart:ui';
import '../core.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class Fonts {
  TextStyle primaryFont(double size, FontWeight fontWeight) {
    return GoogleFonts.poppins(
        color: primaryTextColor, fontSize: size, fontWeight: fontWeight);
  }

  TextStyle secondFont(double size, FontWeight fontWeight) {
    return GoogleFonts.poppins(
        color: secondTextColor, fontSize: size, fontWeight: fontWeight);
  }

  TextStyle textButtonFont(double size, FontWeight fontWeight) {
    return GoogleFonts.poppins(
        color: primaryTextColor,
        fontSize: size,
        decoration: TextDecoration.underline,
        fontWeight: fontWeight);
  }

  TextStyle secondComponentFont(double size, FontWeight fontWeight) {
    return GoogleFonts.poppins(
        color: secondComponentColor, fontSize: size, fontWeight: fontWeight);
  }

  TextStyle whiteFont(double size, FontWeight fontWeight) {
    return GoogleFonts.poppins(
        color: primaryBackgroundColor, fontSize: size, fontWeight: fontWeight);
  }

  TextStyle thirdFontPrimaryComColor(double size, FontWeight fontWeight) {
    return GoogleFonts.poppins(
        color: primaryComponentColor, fontSize: size, fontWeight: fontWeight);
  }

  TextStyle titleFont(double size, FontWeight fontWeight) {
    return GoogleFonts.poppins(
        color: titleTextColor, fontSize: size, fontWeight: fontWeight);
  }

  TextStyle positiveStokeFont(double size, FontWeight fontWeight) {
    return GoogleFonts.poppins(
        color: positiveStokeColor, fontSize: size, fontWeight: fontWeight);
  }

  TextStyle negitiveStokeFont(double size, FontWeight fontWeight) {
    return GoogleFonts.poppins(
        color: negitiveStokeColor, fontSize: size, fontWeight: fontWeight);
  }

  TextStyle secondNegitiveStokeFont(double size, FontWeight fontWeight) {
    return GoogleFonts.poppins(
        color: negitiveStokeColor, fontSize: size, fontWeight: fontWeight);
  }
}
