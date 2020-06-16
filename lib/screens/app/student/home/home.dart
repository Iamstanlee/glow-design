import 'package:flutter/material.dart';
import 'package:glow/data/subject.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/providers/auth_provider.dart';
import 'package:glow/screens/app/student/subject/subject.dart';
import 'package:glow/theme.dart';
import 'package:provider/provider.dart';

class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final studentName = authProvider.student?.username ?? '';
    return Scaffold(
      body: ListView(
        children: <Widget>[
          buildHeaderWidget(context, '$studentName'),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding, vertical: 12),
              child: Text('Start learning '.toUpperCase(),
                  style: TextStyle(color: Colors.black, fontSize: 12))),
          cardWidget(
              context,
              Subject(
                  title: 'Mathematics',
                  percentageComplete: 10,
                  lessonsCount: 24)),
          cardWidget(
              context,
              Subject(
                  title: 'Use of english',
                  percentageComplete: 24,
                  lessonsCount: 18)),
          cardWidget(
              context,
              Subject(
                  title: 'Government',
                  percentageComplete: 94,
                  lessonsCount: 20)),
          cardWidget(
              context,
              Subject(
                  title: 'History', percentageComplete: 4, lessonsCount: 21)),
          cardWidget(
              context,
              Subject(
                  title: 'Business studies',
                  percentageComplete: 54,
                  lessonsCount: 15)),
          cardWidget(
              context,
              Subject(
                  title: 'Fine art', percentageComplete: 0, lessonsCount: 10)),
          cardWidget(context, Subject(title: 'CRS', lessonsCount: 10)),
          cardWidget(
              context, Subject(title: 'Social studies', lessonsCount: 24))
        ],
      ),
    );
  }
}

Widget buildHeaderWidget(BuildContext context, String myName) {
  return Container(
    child: Column(
      children: <Widget>[
        SizedBox(
          height: getHeight(context, height: 3),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Hello',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      )),
                  Text('$myName', style: TextStyle(fontSize: 27.0)),
                ],
              ),
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: primaryColor,
                    child: Text('${myName[0].toUpperCase() ?? ''}',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 25)
      ],
    ),
  );
}

Widget cardWidget(BuildContext context, Subject subject) {
  return Card(
    elevation: 0.4,
    margin: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
    child: InkWell(
      onTap: () {
        push(context, StudentSubjectPage(subject));
      },
      child: Container(
        height: getHeight(context, height: 8),
        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ImageIcon(AssetImage(getPng('video')),
                color: primaryColor, size: 24),
            SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${subject.title ?? 'Unknown'}',
                    style: TextStyle(fontSize: 15, color: Colors.black)),
                Text(
                    '${subject.percentageComplete ?? '45'}% complete'
                        .toUpperCase(),
                    style: TextStyle(fontSize: 10, color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
