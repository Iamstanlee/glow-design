import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glow/data/network/request/staff_signup_request.dart';
import 'package:glow/data/sch.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/helpers/validators.dart';
import 'package:glow/providers/auth_provider.dart';
import 'package:glow/screens/authentication/sch/sch.dart';
import 'package:glow/screens/authentication/sch/sch_classes.dart';
import 'package:glow/screens/authentication/sch/sch_subjects.dart';
import 'package:glow/theme.dart';
import 'package:glow/widgets/button/raised_button.dart';
import 'package:glow/widgets/textField.dart';
import 'package:glow/widgets/toast/toast.dart';
import 'package:provider/provider.dart';

class StaffSignup extends StatefulWidget {
  @override
  _StaffSignupState createState() => _StaffSignupState();
}

enum StaffSignupState { Student, Sch }

class _StaffSignupState extends State<StaffSignup>
    with SingleTickerProviderStateMixin<StaffSignup> {
  AnimationController controller;
  Animation animation;
  StaffSignupState signupState = StaffSignupState.Student;
  final formKey = GlobalKey<FormState>();
  final kSpacing = SizedBox(height: 16);
  List<String> selectedclasses = [];
  List<String> selectedsubjects = [];
  Sch selectedSch;
  StaffSignupReq staffSignupReq = new StaffSignupReq();
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

  Widget firstForm() {
    return Form(
      key: formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Center(
                child: Text('Signup as a Staff',
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              ),
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Fullname',
              initialValue: staffSignupReq.fullname,
              hintText: staffSignupReq.fullname == null
                  ? 'fullname'
                  : staffSignupReq.fullname,
              prefix: ImageIcon(assetImage('user')),
              focusNode: fullnameFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(usernameFN);
              },
              textInputAction: TextInputAction.next,
              validator: validateFname,
              onSaved: (value) {
                staffSignupReq.fullname = value;
              },
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Username',
              initialValue: staffSignupReq.username,
              hintText: staffSignupReq.username == null
                  ? 'username'
                  : staffSignupReq.username,
              prefix: ImageIcon(assetImage('user')),
              focusNode: usernameFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(emailFN);
              },
              textInputAction: TextInputAction.next,
              validator: validateUname,
              onSaved: (value) {
                staffSignupReq.username = value;
              },
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Email',
              initialValue: staffSignupReq.email,
              hintText: staffSignupReq.email == null
                  ? 'email address'
                  : staffSignupReq.email,
              isRequired: false,
              prefix: ImageIcon(assetImage('mail')),
              focusNode: emailFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(phoneNumberFN);
              },
              textInputAction: TextInputAction.next,
              validator: validateEmail,
              onSaved: (value) {
                staffSignupReq.email = value;
              },
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Phone number',
              hintText: staffSignupReq.phoneNumber == null
                  ? 'phonenumber'
                  : staffSignupReq.phoneNumber,
              isRequired: false,
              initialValue: staffSignupReq.phoneNumber,
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
                staffSignupReq.phoneNumber = value;
              },
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Password',
              hintText: staffSignupReq.password == null
                  ? 'password'
                  : staffSignupReq.password,
              initialValue: staffSignupReq.password,
              obscureText: true,
              prefix: ImageIcon(assetImage('lock')),
              focusNode: passwordFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(confirmPasswordFN);
              },
              onChanged: (value) {
                staffSignupReq.password = value;
              },
              onSaved: (value) {},
              validator: validatePassword,
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Confirm Password',
              hintText: staffSignupReq.password == null
                  ? 'password'
                  : staffSignupReq.password,
              obscureText: true,
              initialValue: staffSignupReq.password,
              prefix: ImageIcon(assetImage('lock')),
              focusNode: confirmPasswordFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).unfocus();
              },
              onSaved: (value) {},
              validator: (value) {
                return validateConfirmPassword(value, staffSignupReq.password);
              },
            ),
            SizedBox(height: getHeight(context, height: 4)),
            raisedButton(() {
              validateForm(formKey, () {
                controller.forward();
                setState(() {
                  signupState = StaffSignupState.Sch;
                });
              });
            }, 'continue'),
          ]),
    );
  }

  Widget secondForm() {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Form(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        controller.reset();
                        setState(() {
                          signupState = StaffSignupState.Student;
                        });
                      },
                      child: Icon(Icons.arrow_back)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text('School Details',
                          style: TextStyle(
                              fontSize: 21, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Classes',
              hintText: selectedclasses.isEmpty
                  ? 'classes'
                  : selectedclasses.join(","),
              readOnly: true,
              prefix: ImageIcon(assetImage('icon-clipboard')),
              onTap: () async {
                List<String> classes = await push(context, SchClassesPage());
                if (classes != null) {
                  setState(() {
                    selectedclasses = classes;
                  });
                }
              },
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Subjects',
              hintText: selectedclasses.isEmpty
                  ? 'subjects'
                  : selectedsubjects.join(","),
              readOnly: true,
              prefix: ImageIcon(assetImage('icon-clipboard')),
              onTap: () async {
                List<String> subjects = await push(context, SchSubjectsPage());
                if (subjects != null) {
                  setState(() {
                    selectedsubjects = subjects;
                  });
                }
              },
            ),
            kSpacing,
            kSpacing,
            TextFieldWidget(
              label: 'School',
              hintText: selectedSch == null ? 'school' : selectedSch.name,
              readOnly: true,
              onTap: () async {
                Sch sch = await push(context, SchPage());
                if (sch != null) {
                  setState(() {
                    selectedSch = sch;
                  });
                }
              },
              prefix: ImageIcon(assetImage('icon-building')),
            ),
            SizedBox(height: getHeight(context, height: 4)),
            raisedButton(() {
              if (selectedSch != null &&
                  selectedclasses.isNotEmpty &&
                  selectedsubjects.isNotEmpty) {
                staffSignupReq.schName = selectedSch.name;
                staffSignupReq.schAddress = selectedSch.address;
                staffSignupReq.classes = selectedclasses;
                staffSignupReq.subjects = selectedsubjects;
                authProvider.signupStaff(context, staffSignupReq);
              } else {
                Toast.show(context, 'All fields are required');
              }
            }, 'register'),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget form;
    switch (signupState) {
      case StaffSignupState.Student:
        form = firstForm();
        break;
      case StaffSignupState.Sch:
        form = Transform.scale(scale: animation.value, child: secondForm());
        break;
      default:
        throw new Exception('$signupState not found');
    }
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
                            child: form)))))
      ],
    );
  }
}
