import 'package:flutter/material.dart';
import 'package:glow/data/network/request/signin_request.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/helpers/validators.dart';
import 'package:glow/providers/auth_provider.dart';
import 'package:glow/screens/authentication/signup/parent_signup/parent_signup.dart';
import 'package:glow/screens/authentication/signup/staff_siginup/staff_signup.dart';
import 'package:glow/screens/authentication/signup/student_signup/student_signup.dart';
import 'package:glow/theme.dart';
import 'package:glow/widgets/button/raised_button.dart';
import 'package:glow/widgets/textField.dart';
import 'package:provider/provider.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final formKey = GlobalKey<FormState>();
  SigninReq signinReq = new SigninReq.isEmpty();
  FocusNode usernameFN = new FocusNode();
  FocusNode passwordFN = new FocusNode();

  void navigateToSignup() {
    Provider.of<AuthProvider>(context, listen: false).pushSignupRoute(context);
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // Image.asset(
        //   getPng('illustration here'),
        //   height: 100,
        //   color: Colors.grey,
        //   alignment: Alignment.bottomRight,
        // ),
        Scaffold(
            body: SingleChildScrollView(
                child: Center(
          child: Container(
            margin: EdgeInsets.all(kHorizontalPadding),
            child: Padding(
                padding: EdgeInsets.all(kHorizontalPadding),
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Center(
                            child: Text('Login',
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFieldWidget(
                          label: 'Username',
                          hintText: 'username',
                          prefix: ImageIcon(assetImage('user')),
                          focusNode: usernameFN,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(passwordFN);
                          },
                          textInputAction: TextInputAction.next,
                          validator: validateUname,
                          onSaved: (value) {
                            signinReq.username = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFieldWidget(
                          label: 'Password',
                          hintText: 'password',
                          obscureText: true,
                          suffix: Text('Forgot?',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),
                          prefix: ImageIcon(assetImage('lock')),
                          focusNode: passwordFN,
                          onFieldSubmitted: (value) {
                            passwordFN.unfocus();
                          },
                          validator: validatePassword,
                          onSaved: (value) {
                            signinReq.password = value;
                          },
                        ),
                        SizedBox(height: getHeight(context, height: 4)),
                        raisedButton(() {
                          validateForm(formKey, () {
                            authProvider.signIn(context, signinReq);
                          });
                        }, 'login'),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: navigateToSignup,
                          child: Center(
                              child: Text.rich(TextSpan(children: [
                            TextSpan(text: "Don\'t have an account?"),
                            TextSpan(
                                text: " Signup".toUpperCase(),
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold)),
                          ], style: TextStyle()))),
                        ),
                      ]),
                )),
          ),
        )))
      ],
    );
  }
}
