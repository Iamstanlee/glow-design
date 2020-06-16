import 'package:flutter/material.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/theme.dart';
import 'package:glow/widgets/button/raised_button.dart';

class SchSubjects {
  bool selected;
  String subject;
  SchSubjects({this.selected = false, this.subject});
}

class SchSubjectsPage extends StatefulWidget {
  @override
  _SchSubjectsPageState createState() => _SchSubjectsPageState();
}

class _SchSubjectsPageState extends State<SchSubjectsPage> {
  List<SchSubjects> subjects = [
    SchSubjects(subject: 'Mathematics'),
    SchSubjects(subject: 'Use of english'),
    SchSubjects(subject: 'Geography'),
    SchSubjects(subject: 'Business studies'),
    SchSubjects(subject: 'Economics'),
    SchSubjects(subject: 'History'),
    SchSubjects(subject: 'Government'),
    SchSubjects(subject: 'Fine art'),
    SchSubjects(subject: 'Further mathematics'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text('Select the subjects you teach',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black)),
        ),
        body: ListView(
            children: subjects.map((c) {
          return schSUbjectsWidget(c, onTap: () {
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
              subjects.forEach((s) {
                if (s.selected) selected.add(s.subject);
              });
              pop(context, result: selected);
              subjects.forEach((s) {
                s.selected = false;
              });
            }, 'select')));
  }
}

Widget schSUbjectsWidget(SchSubjects schSubjects, {VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: ListTile(
        leading: ImageIcon(assetImage('icon-clipboard')),
        title: Text('${schSubjects.subject}', style: TextStyle(fontSize: 14)),
        onTap: onTap,
        trailing: schSubjects.selected
            ? ImageIcon(assetImage('icon-check-circle'),
                color: primaryColor, size: 20)
            : null),
  );
}
