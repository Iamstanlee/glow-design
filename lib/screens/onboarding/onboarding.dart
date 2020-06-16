import 'package:flutter/material.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/providers/auth_provider.dart';
import 'package:glow/screens/authentication/signin/signin.dart';
import 'package:glow/theme.dart';
import 'package:glow/widgets/picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  ItemListBuilder itemListBuilder = new ItemListBuilder();
  int acctIndex = 0;

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: DefaultTabController(
          length: itemListBuilder.itemList.length,
          child: TabBarView(
              children: itemListBuilder.itemList.map((item) {
            int tabIndex = itemListBuilder.itemList.indexOf(item);
            return Scaffold(
              backgroundColor: item.color,
              body: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: getHeight(context, height: 10)),
                      Lottie.asset('assets/lotties/$tabIndex.json'),
                      Padding(
                          padding: EdgeInsets.only(
                              left: kHorizontalPadding, right: 20),
                          child: Text('${item.title}',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                      Padding(
                          padding: EdgeInsets.only(
                              left: kHorizontalPadding,
                              right: kHorizontalPadding),
                          child: Text('${item.description}',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[50])))
                    ],
                  ),
                  Positioned(
                      bottom: 24,
                      left: 40,
                      right: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TabPageSelector(
                            indicatorSize: 6,
                            selectedColor: Colors.white,
                          ),
                          InkWell(
                            onTap: () {
                              showPicker(context,
                                  btnString: 'continue',
                                  title: 'Continue as:', onChange: (int i) {
                                acctIndex = i;
                              }, onSelect: () {
                                authProvider.accountType =
                                    authProvider.accountTypes[acctIndex];
                                pushToDispose(context, Signin());
                              },
                                  children: authProvider.accountTypeValues
                                      .map((item) {
                                    return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text('$item',
                                            style: TextStyle(
                                                fontFamily: primaryFont,
                                                fontSize: 16)));
                                  }).toList(),
                                  btnColor: item.color);
                            },
                            child: Text(tabIndex == 2 ? 'Get Started' : 'Skip',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: tabIndex == 2
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: Colors.white)),
                          ),
                        ],
                      ))
                ],
              ),
            );
          }).toList())),
    );
  }
}

class Item {
  String title, description;
  Color color;
  Item({this.title, this.description, this.color});
}

class ItemListBuilder {
  static String description =
      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. - Lorem Ipsum';
  List<Item> itemList = new List();

  Item i = new Item(
      title: "Welcome to Glow E-learning",
      description: description,
      color: Color(0xFFEC6401));
  Item j = new Item(
      title: "Track your students performance",
      description: description,
      color: Color(0xFFFFAB38));
  Item k = new Item(
      title: "Monitor your ward's academic performance",
      description: description,
      color: Color(0xFF466BFF));

  ItemListBuilder() {
    itemList.add(i);
    itemList.add(j);
    itemList.add(k);
  }
}
