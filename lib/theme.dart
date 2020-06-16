import 'package:flutter/material.dart';

const String primaryFont = 'Overpass-Regular';
const String font2 = '';
const double kHorizontalPadding = 25.0;
const primaryColor = Color(0xFFEC6401);
// const scaffoldColor = Color(0xFFF9F9FA);
var scaffoldColor = Colors.grey[100];
ThemeData theme = ThemeData(
  fontFamily: primaryFont,
  primaryTextTheme: TextTheme(),
  accentColor: primaryColor,
  sliderTheme: SliderThemeData(
      trackHeight: 1.5,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6)),
  scaffoldBackgroundColor: scaffoldColor,
  accentIconTheme: IconThemeData(color: primaryColor),
  primaryIconTheme: IconThemeData(color: primaryColor),
  appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: scaffoldColor,
      iconTheme: IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.grey[600])),
  cardTheme: CardTheme(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
);
