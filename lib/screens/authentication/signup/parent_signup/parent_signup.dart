import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glow/data/network/request/parent_signup_request.dart';
import 'package:glow/data/network/request/student_signup_request.dart';
import 'package:glow/data/sch.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/helpers/validators.dart';
import 'package:glow/providers/auth_provider.dart';
import 'package:glow/screens/authentication/sch/sch.dart';
import 'package:glow/theme.dart';
import 'package:glow/widgets/button/raised_button.dart';
import 'package:glow/widgets/picker.dart';
import 'package:glow/widgets/textField.dart';
import 'package:provider/provider.dart';

class ParentSignup extends StatefulWidget {
  @override
  _ParentSignupState createState() => _ParentSignupState();
}

class _ParentSignupState extends State<ParentSignup>
    with SingleTickerProviderStateMixin<ParentSignup> {
  AnimationController controller;
  Animation animation;
  final formKey = GlobalKey<FormState>();
  final kSpacing = SizedBox(height: 16);

  ParentSignupReq parentSignupReq = new ParentSignupReq();
  FocusNode usernameFN = new FocusNode();
  FocusNode passwordFN = new FocusNode();
  FocusNode fullnameFN = new FocusNode();
  FocusNode phoneNumberFN = new FocusNode();
  FocusNode confirmPasswordFN = new FocusNode();
  FocusNode emailFN = new FocusNode();
  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
        duration: new Duration(milliseconds: 600), vsync: this)
      ..addListener(() {
        setState(() {});
      });
    animation = new Tween(
      begin: 0.2,
      end: 1.0,
    ).animate(
        new CurvedAnimation(parent: controller, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Widget form() {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Form(
      key: formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Center(
                child: Text('Signup as a Parent',
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              ),
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Fullname',
              initialValue: parentSignupReq.fullname,
              hintText: 'fullname',
              prefix: ImageIcon(assetImage('user')),
              focusNode: fullnameFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(usernameFN);
              },
              textInputAction: TextInputAction.next,
              validator: validateFname,
              onSaved: (value) {
                parentSignupReq.fullname = value;
              },
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Username',
              initialValue: parentSignupReq.username,
              hintText: 'username',
              prefix: ImageIcon(assetImage('user')),
              focusNode: usernameFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(emailFN);
              },
              textInputAction: TextInputAction.next,
              validator: validateUname,
              onSaved: (value) {
                parentSignupReq.username = value;
              },
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Email',
              initialValue: parentSignupReq.email,
              hintText: 'email address',
              isRequired: false,
              prefix: ImageIcon(assetImage('mail')),
              focusNode: emailFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(phoneNumberFN);
              },
              textInputAction: TextInputAction.next,
              validator: validateEmail,
              onSaved: (value) {
                parentSignupReq.email = value;
              },
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Phone number',
              hintText: 'phonenumber',
              isRequired: false,
              initialValue: parentSignupReq.phoneNumber,
              prefix: ImageIcon(assetImage('phone')),
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11)
              ],
              focusNode: phoneNumberFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).unfocus();
              },
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: validatePhoneNumber,
              onSaved: (value) {
                parentSignupReq.phoneNumber = value;
              },
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Password',
              hintText: 'password',
              initialValue: parentSignupReq.password,
              obscureText: true,
              prefix: ImageIcon(assetImage('lock')),
              focusNode: passwordFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(confirmPasswordFN);
              },
              onChanged: (value) {
                parentSignupReq.password = value;
              },
              onSaved: (value) {},
              validator: validatePassword,
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Confirm Password',
              hintText: 'password',
              obscureText: true,
              initialValue: parentSignupReq.password,
              prefix: ImageIcon(assetImage('lock')),
              focusNode: confirmPasswordFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).unfocus();
              },
              onSaved: (value) {},
              validator: (value) {
                return validateConfirmPassword(value, parentSignupReq.password);
              },
            ),
            SizedBox(height: getHeight(context, height: 4)),
            raisedButton(() {
              validateForm(formKey, () {
                authProvider.signupParent(context, parentSignupReq);
              });
            }, 'register'),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Scaffold(
            body: SingleChildScrollView(
                child: Center(
                    child: Container(
                        margin: EdgeInsets.all(kHorizontalPadding),
                        child: Padding(
                            padding: EdgeInsets.all(kHorizontalPadding),
                            child: form())))))
      ],
    );
  }
}
