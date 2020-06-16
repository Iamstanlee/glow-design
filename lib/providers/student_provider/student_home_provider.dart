import 'package:flutter/material.dart';
import 'package:glow/screens/app/student/bookshelf/bookshelf.dart';
import 'package:glow/screens/app/student/chat/chat.dart';
import 'package:glow/screens/app/student/home/home.dart';
import 'package:glow/screens/app/student/profile/profile.dart';

class StudentMainProvider with ChangeNotifier {
  int _index = 0;
  int get index => _index;
  List<Widget> _widgets = [
    StudentHomePage(),
    StudentHBookshelf(),
    StudentChatPage(),
    StudentProfilePage()
  ];
  Widget get currentWidget => widgets[index];
  List<Widget> get widgets => _widgets;
  set index(int i) {
    this._index = i;
    notifyListeners();
  }

  void changeWidget(int newIndex) => index = newIndex;
}
