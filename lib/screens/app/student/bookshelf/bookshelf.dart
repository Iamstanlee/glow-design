import 'package:flutter/material.dart';
import 'package:glow/data/book.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/providers/auth_provider.dart';
import 'package:glow/screens/app/student/book_reader/book_reader.dart';
import 'package:glow/theme.dart';
import 'package:provider/provider.dart';

class StudentHBookshelf extends StatefulWidget {
  @override
  _StudentHBookshelfState createState() => _StudentHBookshelfState();
}

class _StudentHBookshelfState extends State<StudentHBookshelf> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Bookshelf',
                style: TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
        actions: <Widget>[
          IconButton(icon: ImageIcon(assetImage('search')), onPressed: () {})
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding, vertical: 12),
              child: Text('Available books '.toUpperCase(),
                  style: TextStyle(color: Colors.black, fontSize: 12))),
          cardWidget(
              context, Book(title: 'Principle of chemistry', rating: 3.9)),
          cardWidget(context, Book(title: 'Use of english', rating: 5.0)),
          cardWidget(context, Book(title: 'Fundamental physics', rating: 4.8)),
          cardWidget(
              context, Book(title: 'New school mathematics', rating: 4.0)),
          cardWidget(context,
              Book(title: 'Principle of chemistry 3rd edition', rating: 3.4)),
          cardWidget(context, Book(title: 'Essential biology', rating: 3.0)),
          cardWidget(
              context, Book(title: 'Further Mathematics 3', rating: 2.2)),
          cardWidget(context, Book(title: 'Essential Physics', rating: 4.3))
        ],
      ),
    );
  }
}

Widget cardWidget(BuildContext context, Book book) {
  return Card(
    elevation: 0.4,
    margin: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
    child: InkWell(
      onTap: () {
        push(context, StudentBookReader(book));
      },
      child: Container(
        height: getHeight(context, height: 8),
        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            loadPng('pdf', width: 24),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${book.title ?? 'Unknown'}',
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Abibio Igwe',
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[900])),
                      SizedBox(width: 8),
                      loadPng('star', width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Text('${book.rating}'.toUpperCase(),
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey[900])),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
