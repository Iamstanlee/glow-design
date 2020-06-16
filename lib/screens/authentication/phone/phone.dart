import 'dart:async';
import 'package:flutter/material.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/providers/auth_provider.dart';
import 'package:glow/theme.dart';
import 'package:glow/widgets/toast/loading_toast.dart';
import 'package:glow/widgets/toast/toast.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

class PhonePage extends StatefulWidget {
  final String phoneNumber;
  PhonePage(this.phoneNumber);
  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage>
    with AfterLayoutMixin<PhonePage> {
  Timer timer;
  int resend;
  @override
  void afterFirstLayout(BuildContext context) {
    sendsms();
  }

  void sendsms() {
    resend = 60;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (resend == 0) {
          timer.cancel();
        } else {
          resend--;
        }
      });
    });
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.getCode(context);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void verifyCode(String smsCode) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    authProvider.verifyUser(context, smsCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: getHeight(context, height: 24),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text('Verify Phone',
                  style:
                      TextStyle(fontSize: 36.0, fontWeight: FontWeight.w800)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Enter the verification code sent to',
                    style: TextStyle().copyWith(fontWeight: FontWeight.w800),
                  ),
                  Text('${getIntPhoneFormat('09038622012')}',
                      style: TextStyle().copyWith(
                          color: primaryColor, fontWeight: FontWeight.w800))
                ],
              ),
            ),
            SizedBox(
              height: getHeight(context, height: 4),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 44.0),
                child: Center(
                  child: PinPut(
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    fieldsCount: 6,
                    inputDecoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 10, right: 10, top: 8.0, bottom: 8.0),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.5)),
                      counterText: '',
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.5)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 1.0)),
                    ),
                    textStyle: TextStyle(fontSize: 18),
                    onSubmit: (String smsCode) => verifyCode(smsCode),
                  ),
                )),
            SizedBox(
              height: getHeight(context, height: 4),
            ),
            resend == 0
                ? Center(
                    child: InkWell(
                    onTap: () {
                      sendsms();
                    },
                    child: Text.rich(
                        TextSpan(children: <TextSpan>[
                          TextSpan(text: 'Didn\'t get code?'),
                          TextSpan(
                              text: ' RESEND',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold)),
                        ]),
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: primaryFont,
                        )),
                  ))
                : Center(
                    child: Text(
                    resend == null
                        ? '00:00'
                        : '00:${resend.toString().padLeft(2, '0')}',
                    style: TextStyle().copyWith(
                        fontFamily: primaryFont,
                        fontWeight: FontWeight.w800,
                        fontSize: 27),
                  ))
          ],
        ),
      ),
    );
  }
}
