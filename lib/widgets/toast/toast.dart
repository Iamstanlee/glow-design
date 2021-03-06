import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glow/theme.dart';

enum ToastType { Error, Success, Info }

class Toast {
  static void show(BuildContext context, String msg,
      {int duration,
      int gravity = 2,
      bool timed = true,
      ToastType toastType,
      Color textColor = Colors.white,
      double backgroundRadius = 20}) {
    ToastView.dismiss();
    Color bgColor;
    switch (toastType) {
      case ToastType.Success:
        bgColor = Colors.green;
        break;
      case ToastType.Info:
        bgColor = primaryColor;
        break;
      case ToastType.Error:
        bgColor = Colors.red;
        break;
      default:
        bgColor = Color(0xAA000000);
    }
    ToastView.createView(
        msg, context, timed, duration, gravity, bgColor, textColor);
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

  static void createView(String msg, BuildContext context, bool timed,
      int duration, int gravity, Color background, Color textColor) async {
    overlayState = Overlay.of(context);

    Paint paint = Paint();
    paint.strokeCap = StrokeCap.square;
    paint.color = background;

    _overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => ToastWidget(
          widget: Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.zero,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                  child: Text(msg,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 13,
                          color: textColor,
                          fontFamily: primaryFont)),
                )),
          ),
          gravity: gravity),
    );
    _isVisible = true;
    overlayState.insert(_overlayEntry);
    await Future.delayed(Duration(seconds: duration == null ? 4 : duration));
    if (timed) dismiss();
  }
}

class ToastWidget extends StatelessWidget {
  ToastWidget({
    Key key,
    @required this.widget,
    @required this.gravity,
  }) : super(key: key);

  final Widget widget;
  final int gravity;

  @override
  Widget build(BuildContext context) {
    return new Positioned(
        top: gravity == 2 ? 50 : null,
        bottom: gravity == 0 ? 80 : null,
        child: Material(
          color: Colors.transparent,
          child: widget,
        ));
  }
}
