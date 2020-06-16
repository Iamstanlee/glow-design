import 'package:flutter/material.dart';
import 'package:glow/theme.dart';

Widget outlineButton(VoidCallback callback, String label) {
  return OutlineButton(
    onPressed: callback,
    borderSide: BorderSide(color: primaryColor),
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontFamily: primaryFont),
    ),
  );
}

Widget outlineButtonWithIcon(VoidCallback callback, String label, Widget icon) {
  return OutlineButton.icon(
    onPressed: callback,
    icon: icon,
    splashColor: Colors.black12,
    highlightColor: Colors.white10,
    highlightedBorderColor: Colors.grey,
    padding: EdgeInsets.symmetric(vertical: 10),
    label: Text(
      label,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: primaryFont),
    ),
  );
}
