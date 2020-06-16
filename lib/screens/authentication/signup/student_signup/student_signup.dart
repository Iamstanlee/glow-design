import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class StudentSignup extends StatefulWidget {
  @override
  _StudentSignupState createState() => _StudentSignupState();
}

enum StudentSignupState { Student, Sch }

class _StudentSignupState extends State<StudentSignup>
    with SingleTickerProviderStateMixin<StudentSignup> {
  AnimationController controller;
  Animation animation;
  StudentSignupState signupState = StudentSignupState.Student;
  final formKey = GlobalKey<FormState>();
  final kSpacing = SizedBox(height: 16);
  static List<String> classes = [
    'JSS 1',
    'JSS 2',
    'JSS 3',
    'SS 1',
    'SS 2',
    'SS 3'
  ];
  String selectedclass = '';
  Sch selectedSch;
  DateTime dob;
  StudentSignupReq studentSignupReq = new StudentSignupReq();
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
                child: Text('Signup as a Student',
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              ),
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Fullname',
              initialValue: studentSignupReq.fullname,
              hintText: studentSignupReq.fullname == null
                  ? 'fullname'
                  : studentSignupReq.fullname,
              prefix: ImageIcon(assetImage('user')),
              focusNode: fullnameFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(usernameFN);
              },
              textInputAction: TextInputAction.next,
              validator: validateFname,
              onSaved: (value) {
                studentSignupReq.fullname = value;
              },
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Username',
              initialValue: studentSignupReq.username,
              hintText: studentSignupReq.username == null
                  ? 'username'
                  : studentSignupReq.username,
              prefix: ImageIcon(assetImage('user')),
              focusNode: usernameFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(emailFN);
              },
              textInputAction: TextInputAction.next,
              validator: validateUname,
              onSaved: (value) {
                studentSignupReq.username = value;
              },
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Email',
              initialValue: studentSignupReq.email,
              hintText: studentSignupReq.email == null
                  ? 'email address'
                  : studentSignupReq.email,
              isRequired: false,
              prefix: ImageIcon(assetImage('mail')),
              focusNode: emailFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(phoneNumberFN);
              },
              textInputAction: TextInputAction.next,
              validator: validateEmail,
              onSaved: (value) {
                studentSignupReq.email = value;
              },
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Phone number',
              hintText: studentSignupReq.phoneNumber == null
                  ? 'phonenumber'
                  : studentSignupReq.phoneNumber,
              isRequired: false,
              initialValue: studentSignupReq.phoneNumber,
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
                studentSignupReq.phoneNumber = value;
              },
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Date of birth',
              hintText:
                  dob != null ? "${formatDate(dob, 'yyyy-MM-dd')}" : 'dob',
              prefix: ImageIcon(assetImage('icon-calander')),
              readOnly: true,
              onTap: () async {
                DateTime d = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2002),
                    firstDate: DateTime(1980),
                    lastDate: DateTime.now());
                if (d != null) {
                  setState(() {
                    dob = d;
                    studentSignupReq.dob = formatDate(dob, 'yyyy-MM-dd');
                  });
                }
              },
              onSaved: (value) {},
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Password',
              hintText: studentSignupReq.password == null
                  ? 'password'
                  : studentSignupReq.password,
              initialValue: studentSignupReq.password,
              obscureText: true,
              prefix: ImageIcon(assetImage('lock')),
              focusNode: passwordFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(confirmPasswordFN);
              },
              onChanged: (value) {
                studentSignupReq.password = value;
              },
              onSaved: (value) {},
              validator: validatePassword,
            ),
            kSpacing,
            TextFieldWidget(
              label: 'Confirm Password',
              hintText: studentSignupReq.password == null
                  ? 'password'
                  : studentSignupReq.password,
              obscureText: true,
              initialValue: studentSignupReq.password,
              prefix: ImageIcon(assetImage('lock')),
              focusNode: confirmPasswordFN,
              onFieldSubmitted: (value) {
                FocusScope.of(context).unfocus();
              },
              onSaved: (value) {},
              validator: (value) {
                return validateConfirmPassword(
                    value, studentSignupReq.password);
              },
            ),
            SizedBox(height: getHeight(context, height: 4)),
            raisedButton(() {
              validateForm(formKey, () {
                controller.forward();
                setState(() {
                  signupState = StudentSignupState.Sch;
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
                          signupState = StudentSignupState.Student;
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
            kSpacing,
            TextFieldWidget(
              label: 'Class',
              hintText: selectedclass.isEmpty ? 'class' : selectedclass,
              readOnly: true,
              prefix: ImageIcon(assetImage('icon-clipboard')),
              onTap: () {
                showPicker(context, btnString: 'select', onChange: (int i) {
                  setState(() {
                    selectedclass = classes[i];
                  });
                }, onSelect: () {
                  if (selectedclass.isEmpty)
                    setState(() {
                      selectedclass = classes[0];
                    });
                },
                    children: classes.map((item) {
                      return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text('$item',
                              style: TextStyle(
                                  fontFamily: primaryFont, fontSize: 16)));
                    }).toList());
              },
            ),
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
              if (selectedSch != null && selectedclass.isNotEmpty) {
                studentSignupReq.schName = selectedSch.name;
                studentSignupReq.schAddress = selectedSch.address;
                studentSignupReq.schClass = selectedclass;
                authProvider.signupStudent(context, studentSignupReq);
              }
            }, 'register'),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget form;
    switch (signupState) {
      case StudentSignupState.Student:
        form = firstForm();
        break;
      case StudentSignupState.Sch:
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
