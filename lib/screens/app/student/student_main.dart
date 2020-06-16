import 'package:flutter/material.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/providers/student_provider/student_home_provider.dart';
import 'package:glow/theme.dart';
import 'package:provider/provider.dart';

class StudentMainPage extends StatefulWidget {
  @override
  _StudentMainPageState createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<StudentMainProvider>(context);
    return Scaffold(
        body: provider.currentWidget,
        bottomNavigationBar: bottomNavbar(
            onTap: (newIndex) {
              provider.changeWidget(newIndex);
            },
            currentIndex: provider.index));
  }
}

Widget bottomNavbar({@required onTap, @required currentIndex}) {
  return BottomNavigationBar(
    onTap: onTap,
    currentIndex: currentIndex,
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    selectedItemColor: primaryColor,
    unselectedItemColor: Colors.black38,
    type: BottomNavigationBarType.fixed,
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(getPng('home'))),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(getPng('icon-clipboard'))),
        title: Text('Bookshelf'),
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(getPng('icon-chat'))),
        title: Text('Chat'),
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(getPng('user'))),
        title: Text('Me'),
      ),
    ],
  );
}
