import 'package:flutter/material.dart';
import 'colors.dart';

class CustomTheme {
  ThemeData appTheme() {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        foregroundColor: primaryBackgroundColor,
        toolbarTextStyle: TextStyle(color: primaryComponentColor),
        actionsIconTheme: IconThemeData(
          color: primaryComponentColor,
        ),
        elevation: 0,
        centerTitle: true,
        color: Colors.white,
        iconTheme: IconThemeData(
          color: primaryComponentColor,
        ),
      ),
      scaffoldBackgroundColor: primaryBackgroundColor,
    );
  }
}
