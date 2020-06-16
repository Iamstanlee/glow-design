import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/// return a random a from range 0 to [max] params
int getRandomInt(int max) {
  return new Random().nextInt(max);
}

String generateCode({int length = 4}) {
  String code = '';
  for (int i = 0; i < length; i++) {
    code += getRandomInt(9).toString();
  }
  return code;
}

String getIntPhoneFormat(String phone) {
  if (phone.length != 11) return throw new Exception("Invalid Phonenumber");
  String intFormat = phone.substring(1).padLeft(11, '+234');
  return intFormat;
}

String getIntPhoneFormatIn9(String phone) {
  if (phone.length != 11) return throw new Exception("Invalid Phonenumber");
  String intFormat = phone.substring(1);
  return intFormat;
}

/// return the int value of a String
int parseInt(String integer) {
  if (int == null) throw new Exception("$int isn't a valid String");
  return int.parse(integer);
}

/// return the double value of a String
double parseFloat(String float) {
  if (float == null) throw new Exception("$float isn't a valid String");
  return double.parse(float);
}

String getReference() {
  String timestamp = DateTime.now().toString().split('.').last;
  return '#' + timestamp;
}

/// takes a percentage of the screens width and return a double of current width
double getWidth(context, {width}) {
  if (width == null) return MediaQuery.of(context).size.width;
  return ((width / 100) * MediaQuery.of(context).size.width);
}

/// takes a percentage of the screens height and return a double of screen height.
double getHeight(context, {height}) {
  if (height == null) return MediaQuery.of(context).size.height;
  return ((height / 100) * MediaQuery.of(context).size.height);
}

String getImage(String image) {
  return 'assets/pngs/$image';
}

AssetImage assetImage(String image) {
  return AssetImage(getPng('$image'));
}

Widget loadImage(String image, {double width, double height}) {
  return Image.asset(
    getImage(image),
    width: width,
    height: height,
  );
}

Future<File> pickImage() async {
  File img = await ImagePicker.pickImage(source: ImageSource.gallery);
  if (img == null) return null;
  return img;
}

Widget loadPng(String image, {double width, double height}) {
  return Image.asset(
    getPng(image),
    width: width,
    height: height,
  );
}

String getPng(String png) {
  return 'assets/pngs/$png.png';
}

String formatDate(DateTime date, [String formatter]) {
  if (formatter == null) return new DateFormat.jm().format(date);
  return DateFormat(formatter).format(date);
}

void scrollToBottom(ScrollController controller) {
  controller.animateTo(controller.position.maxScrollExtent + 100,
      curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

/// Navigate to a new route by passing a route widget
dynamic push(context, Widget to) {
  return Navigator.push(context, CupertinoPageRoute(builder: (context) => to));
}

/// replace the current widget with a new route by passing a route widget
void replace(context, Widget to) {
  Navigator.pushReplacement(
      context, CupertinoPageRoute(builder: (context) => to));
}

/// go back to the previous route
void pop(context, {dynamic result}) {
  Navigator.pop(context, result);
}

/// Navigate to a new route by passing a route widget
///  and dispose the previous routes
void pushToDispose(context, to, {Widget predicate}) {
  Navigator.pushAndRemoveUntil(
      context, CupertinoPageRoute(builder: (context) => to), (route) {
    if (predicate != null) if (route ==
        CupertinoPageRoute(builder: (context) => predicate)) return true;
    return false;
  });
}

// Directory
Future<Directory> getAppDirectory() async {
  return await getApplicationDocumentsDirectory();
}

Future<String> getAppPath() async {
  Directory directory = await getAppDirectory();
  return directory.path;
}

/// download file from url and save to device
Future<File> downloadFileFromURL(String url,
    {String fileName, String fileExtension}) async {
  try {
    http.Response response = await http.get(url);
    Uint8List fileBytes = response.bodyBytes;
    String path = await getAppPath();
    File downloadFilePath = File("$path/$fileName.$fileExtension");
    File file = await downloadFilePath.writeAsBytes(fileBytes);
    return file;
  } catch (exception) {
    return throw new Exception(exception);
  }
}

Future<bool> checkFileExistence(String file) async {
  String path = await getAppPath();
  File filePath = File("$path/$file");
  if (await filePath.exists()) return true;
  return false;
}

String getFormattedDuration(double d, {Duration duration}) {
  String formattedDuration;
  if (duration == null) {
    var tmp = Duration(milliseconds: d.toInt());
    if (tmp.inHours >= 1) {
      formattedDuration =
          "${tmp.inHours.toString().padLeft(2, '0')}:${tmp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(tmp.inSeconds.remainder(60).toString().padLeft(2, '0'))}";
    } else {
      formattedDuration =
          "${tmp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(tmp.inSeconds.remainder(60).toString().padLeft(2, '0'))}";
    }
  } else {
    var tmp = duration;
    if (tmp.inHours >= 1) {
      formattedDuration =
          "${tmp.inHours.toString().padLeft(2, '0')}:${tmp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(tmp.inSeconds.remainder(60).toString().padLeft(2, '0'))}";
    } else {
      formattedDuration =
          "${tmp.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(tmp.inSeconds.remainder(60).toString().padLeft(2, '0'))}";
    }
  }
  return formattedDuration;
}

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context);
}
