import 'package:flutter/material.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/theme.dart';
import 'package:glow/widgets/button/raised_button.dart';

class SchClass {
  bool selected;
  String clas;
  SchClass({this.selected = false, this.clas});
}

class SchClassesPage extends StatefulWidget {
  @override
  _SchClassesPageState createState() => _SchClassesPageState();
}

class _SchClassesPageState extends State<SchClassesPage> {
  List<SchClass> classes = [
    SchClass(clas: 'JSS 1'),
    SchClass(clas: 'JSS 2'),
    SchClass(clas: 'JSS 3'),
    SchClass(clas: 'SS 1'),
    SchClass(clas: 'SS 2'),
    SchClass(clas: 'SS 3'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text('Select the classes you teach',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black)),
        ),
        body: ListView(
            children: classes.map((c) {
          return schClassWidget(c, onTap: () {
            setState(() {
              c.selected = true;
            });
          });
        }).toList()),
        bottomSheet: Container(
            width: getWidth(context),
            padding: EdgeInsets.all(kHorizontalPadding),
            child: raisedButton(() {
              List<String> selected = [];
              classes.forEach((c) {
                if (c.selected) selected.add(c.clas);
              });
              pop(context, result: selected);
              classes.forEach((c) {
                c.selected = false;
              });
            }, 'select')));
  }
}

Widget schClassWidget(SchClass schClass, {VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: ListTile(
        leading: ImageIcon(assetImage('icon-clipboard')),
        title: Text('${schClass.clas}', style: TextStyle(fontSize: 14)),
        onTap: onTap,
        trailing: schClass.selected
            ? ImageIcon(assetImage('icon-check-circle'),
                color: primaryColor, size: 20)
            : null),
  );
}
