import 'package:flutter/material.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/providers/auth_provider.dart';
import 'package:glow/screens/app/student/chat/messaging/messaging.dart';
import 'package:glow/theme.dart';
import 'package:provider/provider.dart';

class StudentChatPage extends StatefulWidget {
  @override
  _StudentChatPageState createState() => _StudentChatPageState();
}

class _StudentChatPageState extends State<StudentChatPage> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Chats', style: TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
        actions: <Widget>[
          IconButton(icon: ImageIcon(assetImage('search')), onPressed: () {}),
          IconButton(
              icon: ImageIcon(assetImage('user_plus')), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: <Widget>[
          chatCardWidget(context,
              time: '12:00 PM', title: 'John Doe', subtitle: 'alright'),
          chatCardWidget(context,
              time: '8:34 AM', title: 'May Hampton', subtitle: 'okay dear'),
          chatCardWidget(context,
              time: '10:23 PM', title: 'Foo Bar', subtitle: 'thank you'),
        ],
      ),
    );
  }
}

Widget chatCardWidget(BuildContext context,
    {String iconName,
    String actionType,
    String title,
    String subtitle,
    String time}) {
  return Card(
    elevation: 0.4,
    margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.2),
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
    child: InkWell(
      onTap: () {
        push(context, MessagingPage());
      },
      child: Container(
        height: getHeight(context, height: 8),
        color: Colors.white,
        padding: EdgeInsets.only(right: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 24),
            CircleAvatar(
              backgroundColor: primaryColor,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('$title',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  Text('$subtitle',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('$time',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10, color: Colors.grey)),
                Container(
                  padding: EdgeInsets.all(6),
                  child: Text('4',
                      style: TextStyle(color: Colors.white, fontSize: 8)),
                  decoration: BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
