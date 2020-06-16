import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/providers/auth_provider.dart';
import 'package:glow/theme.dart';
import 'package:provider/provider.dart';

class StudentProfilePage extends StatefulWidget {
  @override
  _StudentProfilePageState createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final studentName = authProvider.student?.username ?? '';

    return SafeArea(
      top: true,
      child: Scaffold(
          body: ListView(
        children: <Widget>[
          buildHeaderWidget(name: studentName),
          SizedBox(height: 10),
          cardWidget(context,
              iconName: 'edit_user', actionType: 'Personal timetable'),
          cardWidget(context, iconName: 'users', actionType: 'Class timetable'),
          SizedBox(height: 10),
          cardWidget(context, iconName: 'share', actionType: 'Share this APP'),
          cardWidget(context,
              iconName: 'inbox', actionType: 'Contact and support'),
          cardWidget(context, iconName: 'settings', actionType: 'Settings'),
          cardWidget(context, iconName: 'logout', actionType: 'Logout',
              action: () {
            authProvider.logout(context);
          })
        ],
      )),
    );
  }
}

Widget buildHeaderWidget({String name, String studentClass}) {
  return Container(
    height: 180,
    color: Colors.white,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: primaryColor,
            radius: 36,
            child: Text('${name[0].toUpperCase() ?? ''}',
                style: TextStyle(color: Colors.white, fontSize: 27)),
          ),
          SizedBox(height: 8),
          Text('$name ( SS 3 )',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
        ],
      ),
    ),
  );
}

Widget cardWidget(BuildContext context,
    {String iconName, String actionType, VoidCallback action}) {
  return Card(
    elevation: 0.4,
    margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.2),
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
    child: InkWell(
      onTap: action,
      child: Container(
        height: getHeight(context, height: 8),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 24),
            ImageIcon(AssetImage(getPng('${iconName ?? 'video'}')),
                color: iconName == 'logout' ? Colors.red : Colors.grey[400],
                size: 24),
            SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${actionType ?? 'No action'}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            iconName == 'logout' ? FontWeight.bold : null,
                        color:
                            iconName == 'logout' ? Colors.red : Colors.black)),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
