import 'package:flutter/material.dart';
import 'package:glow/theme.dart';

Widget raisedButton(Function onPressed, String child,
    {Color color = primaryColor, double horizontalPadding = 0.0}) {
  return FlatButton(
    onPressed: onPressed,
    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    color: color,
    child: Text("$child".toUpperCase(),
        style: TextStyle(
            fontFamily: primaryFont,
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600)),
    padding:
        EdgeInsets.symmetric(vertical: 14.0, horizontal: horizontalPadding),
  );
}
