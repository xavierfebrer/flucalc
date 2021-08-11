import 'dart:ui';

import 'package:flutter/material.dart';

class FlucalcConstant {
  static const String APP_NAME = "Flucalc";
  static const String LOG_TAG = APP_NAME + " Log";
  static const Color COLOR_PRIMARY = Color(0xFF795548);
  static const Color COLOR_SECONDARY = Color(0xFFD7CCC8);
  static Color COLOR_TEXT([bool darkMode = false]) => !darkMode ? Color(0xFF212121) : Color(0xFFFFFFFF);
  static Color COLOR_TEXT_2([bool darkMode = false]) => !darkMode ? Color(0xFF757575) : Color(0xFFD1D1D1);
  static const double TEXT_PRIMARY_FONT_SIZE = 18;
  static const double TEXT_SECONDARY_FONT_SIZE = 16;
  static const FontWeight TEXT_FONT_WEIGHT_LIGHT = FontWeight.w300;
  static const FontWeight TEXT_FONT_WEIGHT = FontWeight.w400;
  static const FontWeight TEXT_FONT_WEIGHT_MEDIUM = FontWeight.w500;
  static const FontWeight TEXT_FONT_WEIGHT_SEMI_BOLD = FontWeight.w600;
  static const FontWeight TEXT_FONT_WEIGHT_BOLD = FontWeight.w700;
  static const double TEXT_LETTER_SPACING = -0.0;




  static const String EMPTY_STRING = "";
  static const int DELAY_SPLASH_SCREEN = 1600;
  static const String DECIMAL_SEPARATOR = ".";
  static const int INTEGER_STARTING_OPTIONAL = 0;
  static const int DECIMAL_ENDING_OPTIONAL = 0;
  static const int DEFAULT_EMPTY_VALUE = 0;
  static const double PERCENT_DIVISOR = 100.0;
  static const String SYMBOL_NUMBER_0 = "0";
  static const String SYMBOL_NUMBER_1 = "1";
  static const String SYMBOL_NUMBER_2 = "2";
  static const String SYMBOL_NUMBER_3 = "3";
  static const String SYMBOL_NUMBER_4 = "4";
  static const String SYMBOL_NUMBER_5 = "5";
  static const String SYMBOL_NUMBER_6 = "6";
  static const String SYMBOL_NUMBER_7 = "7";
  static const String SYMBOL_NUMBER_8 = "8";
  static const String SYMBOL_NUMBER_9 = "9";
  static const String SYMBOL_ADDITION = "+";
  static const String SYMBOL_SUBSTRACTION = "-";
  static const String SYMBOL_MULTIPLICATION = "*";
  static const String SYMBOL_DIVISION = "/";
  static const String SYMBOL_RESULT = "=";
  static const String SYMBOL_INVERT = "+/-";
  static const String SYMBOL_CLEAR = "C";
  static const String SYMBOL_BACK = "<";
  static const Color COLOR_DISABLED = Color(0xFFBDBDBD);
  static const Color COLOR_EXTRA = Color(0xFF2196F3);
  static const Color COLOR_EXTRA_SELECTED = Color(0xFF1976D2);
  static const Color COLOR_EXTRA_2 = Color(0xFF4CAF50);
  static const Color COLOR_EXTRA_2_SELECTED = Color(0xFF388E3C);
  static const Color COLOR_TEXT_LIGHT = Color(0xFFF2F2F2);
  static const Color COLOR_TEXT_DARK = Color(0xFF212121);
  static const double PADDING_CALC_BORDER = 7.0;
  static const double PADDING_CALC_ITEMS = 5.0;
}

enum MathOperation { ADDITION, SUBSTRACTION, MULTIPLICATION, DIVISION }
