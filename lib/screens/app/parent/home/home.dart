import 'package:flutter/material.dart';

class ParentHomePage extends StatefulWidget {
  @override
  _ParentHomePageState createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<ParentHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Parent HomePage')),
    );
  }
}
