import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glow/data/subject.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/screens/app/student/lesson/lesson.dart';
import 'package:glow/theme.dart';

class StudentSubjectPage extends StatefulWidget {
  final Subject subject;
  StudentSubjectPage(this.subject);
  @override
  _StudentSubjectPageState createState() => _StudentSubjectPageState();
}

class _StudentSubjectPageState extends State<StudentSubjectPage>
    with AfterLayoutMixin<StudentSubjectPage> {
  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final subject = widget.subject;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${subject.title}',
                style: TextStyle(fontSize: 16, color: Colors.black)),
            Text('${subject.lessonsCount} lessons',
                style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          ],
        ),
        actions: <Widget>[
          IconButton(icon: ImageIcon(assetImage('search')), onPressed: () {})
        ],
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: ListView(
              children: List.generate(12, (int i) {
                return subjectModuleWidget(context, i + 1);
              }),
            ),
          )),
    );
  }
}

Widget subjectModuleWidget(BuildContext context, int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kHorizontalPadding, vertical: 10),
          child: Text('$index.  Surd',
              style: TextStyle(fontSize: 18, color: Colors.black))),
      Container(
        height: getHeight(context, height: 21),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(10, (int i) {
            return subjectLessonWidget(context, i);
          }),
        ),
      )
    ],
  );
}

Widget subjectLessonWidget(BuildContext context, int i) {
  return Card(
    elevation: 0.5,
    margin: EdgeInsets.only(
        right: 12, bottom: 4, left: i == 0 ? kHorizontalPadding : 0),
    child: InkWell(
      onTap: () {
        push(context, StudentLessonPage());
      },
      child: Container(
        height: 50,
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageIcon(assetImage('video_large'), color: primaryColor, size: 46),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Implementation of surd',
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  textAlign: TextAlign.center,
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Lesson ${i + 1}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
    ),
  );
}
