import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glow/theme.dart';

class LoadingToast {
  static void show(BuildContext context,
      {int duration = 2,
      bool timed = true,
      String msg = "Loading...",
      Color backgroundColor = const Color(0xAA000000),
      Color textColor = Colors.white}) {
    ToastView.dismiss();
    ToastView.createView(
        context, timed, msg, duration, backgroundColor, textColor);
  }

  static void dismiss() {
    ToastView.dismiss();
  }
}

class ToastView {
  static final ToastView _singleton = new ToastView._internal();

  factory ToastView() {
    return _singleton;
  }

  ToastView._internal();

  static OverlayState overlayState;
  static OverlayEntry _overlayEntry;
  static bool _isVisible = false;
  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }

  static void createView(BuildContext context, bool timed, String msg,
      int duration, Color background, Color textColor) async {
    overlayState = Overlay.of(context);

    _overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => ToastWidget(
          widget: Container(
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.zero,
        ),
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTheme(
                  data: CupertinoTheme.of(context)
                      .copyWith(brightness: Brightness.dark),
                  child: CupertinoActivityIndicator(radius: 18),
                ),
              ),
            ),
            Center(
              child: Text("$msg",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14, color: textColor, fontFamily: primaryFont)),
            )
          ],
        ),
      )),
    );
    _isVisible = true;
    overlayState.insert(_overlayEntry);
    await new Future.delayed(Duration(seconds: duration));
    if (timed) dismiss();
  }
}

class ToastWidget extends StatelessWidget {
  ToastWidget({
    Key key,
    @required this.widget,
  });
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: Material(
      color: Colors.transparent,
      child: widget,
    ));
  }
}
