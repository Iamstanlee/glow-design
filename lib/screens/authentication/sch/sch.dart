import 'package:flutter/material.dart';
import 'package:glow/data/sch.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/providers/sch_provider.dart';
import 'package:glow/theme.dart';
import 'package:glow/widgets/button/raised_button.dart';
import 'package:provider/provider.dart';

class SchPage extends StatefulWidget {
  @override
  _SchPageState createState() => _SchPageState();
}

class _SchPageState extends State<SchPage> with AfterLayoutMixin<SchPage> {
  List<Sch> searchItems = [];
  Sch selectedSch;
  bool selected = false;
  @override
  void afterFirstLayout(BuildContext context) {
    final SchProvider schProvider =
        Provider.of<SchProvider>(context, listen: false);
    if (schProvider.schs.length == 0) {
      schProvider.getSchs(context);
    }
  }

  void search(String query) {
    final SchProvider schProvider =
        Provider.of<SchProvider>(context, listen: false);
    setState(() {
      searchItems = schProvider.schs.where((sch) {
        return sch.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final SchProvider schProvider = Provider.of<SchProvider>(context);
    final schs = schProvider.schs;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: TextField(
          onChanged: search,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Tap to search for school...'),
        ),
      ),
      body: schProvider.loadingError != null
          ? Center(
              child: Column(children: <Widget>[
                Text(
                  '${schProvider.loadingError}',
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    schProvider.getSchs(context);
                  },
                  child: Text('RETRY',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ]),
            )
          : searchItems.length == 0
              ? Padding(
                  padding:
                      EdgeInsets.only(bottom: getHeight(context, height: 15)),
                  child: ListView(
                      children: schs.map((sch) {
                    return schWidget(sch, onTap: () {
                      setState(() {
                        selectedSch = sch;
                        schs.forEach((s) {
                          if (s.name == selectedSch.name) {
                            if (s.selected) {
                              s.selected = false;
                            } else {
                              s.selected = true;
                            }
                          } else {
                            s.selected = false;
                          }
                        });
                      });
                    });
                  }).toList()),
                )
              : Padding(
                  padding:
                      EdgeInsets.only(bottom: getHeight(context, height: 15)),
                  child: ListView(
                      children: searchItems.map((sch) {
                    return schWidget(sch, onTap: () {
                      setState(() {
                        selectedSch = sch;
                        schs.forEach((s) {
                          if (s.name == selectedSch.name) {
                            if (s.selected) {
                              s.selected = false;
                            } else {
                              s.selected = true;
                            }
                          } else {
                            s.selected = false;
                          }
                        });
                      });
                    });
                  }).toList()),
                ),
      bottomSheet: Container(
        width: getWidth(context),
        padding: EdgeInsets.all(kHorizontalPadding),
        child: raisedButton(() {
          pop(context, result: selectedSch);
          schs.forEach((s) {
            s.selected = false;
          });
        }, 'select'),
      ),
    );
  }
}

Widget schWidget(Sch sch, {VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: ListTile(
        title: Text('${sch.name}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Row(
          children: <Widget>[
            ImageIcon(assetImage('pin'), size: 14),
            SizedBox(width: 8),
            Expanded(child: Text('${sch.address}'))
          ],
        ),
        onTap: onTap,
        trailing: sch.selected
            ? ImageIcon(assetImage('icon-check-circle'),
                color: primaryColor, size: 20)
            : null),
  );
}
