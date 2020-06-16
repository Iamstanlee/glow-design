import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/theme.dart';
import 'package:glow/widgets/button/raised_button.dart';

void showPicker(BuildContext context,
    {@required String btnString,
    @required Function(int index) onChange,
    @required VoidCallback onSelect,
    @required List<Widget> children,
    Color btnColor = primaryColor,
    String title = ''}) {
  showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: getHeight(context),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              title.isEmpty
                  ? Container(height: 0)
                  : Material(
                      color: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: kHorizontalPadding * 2, top: 12),
                          child: Text(
                            '$title',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                    ),
              Container(
                  height: getHeight(context, height: 27),
                  child: CupertinoPicker(
                      useMagnifier: true,
                      magnification: 1.1,
                      backgroundColor: Colors.white,
                      itemExtent: 36,
                      onSelectedItemChanged: (index) {
                        onChange(index);
                      },
                      children: children)),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kHorizontalPadding * 2),
                child: raisedButton(() {
                  pop(context);
                  onSelect();
                }, btnString, color: btnColor),
              ),
              SizedBox(height: 27)
            ],
          ),
        );
      });
}
