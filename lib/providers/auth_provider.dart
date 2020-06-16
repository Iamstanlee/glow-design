import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glow/apis/auth_api.dart';
import 'package:glow/data/network/request/parent_signup_request.dart';
import 'package:glow/data/network/request/signin_request.dart';
import 'package:glow/data/network/request/staff_signup_request.dart';
import 'package:glow/data/network/request/student_signup_request.dart';
import 'package:glow/data/network/response/parent_signup_response.dart';
import 'package:glow/data/network/response/signin_response.dart';
import 'package:glow/data/network/response/staff_signup_response.dart';
import 'package:glow/data/network/response/student_signup_response.dart';
import 'package:glow/data/network/response/verificationcode_response.dart';
import 'package:glow/data/parent.dart';
import 'package:glow/data/staff.dart';
import 'package:glow/data/student.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/helpers/preferences.dart';
import 'package:glow/main.dart';
import 'package:glow/screens/app/parent/home/home.dart';
import 'package:glow/screens/app/student/student_main.dart';
import 'package:glow/screens/authentication/phone/phone.dart';
import 'package:glow/screens/authentication/signup/parent_signup/parent_signup.dart';
import 'package:glow/screens/authentication/signup/staff_siginup/staff_signup.dart';
import 'package:glow/screens/authentication/signup/student_signup/student_signup.dart';
import 'package:glow/screens/onboarding/onboarding.dart';
import 'package:glow/widgets/toast/loading_toast.dart';
import 'package:glow/widgets/toast/toast.dart';

enum AccountType { Student, Parent, Staff, Administrator }

class AuthProvider with ChangeNotifier {
  AuthAPI authAPI = new AuthAPI();
  Student _student;
  Parent _parent;
  Staff _staff;

  Student get student => _student;
  Parent get parent => _parent;
  Staff get staff => _staff;

  AccountType _accountType;
  AccountType get accountType => _accountType;
  // list of account types
  List<AccountType> accountTypes = [
    AccountType.Student,
    AccountType.Staff,
    // AccountType.Parent,
    // AccountType.Administrator
  ];
  List<String> accountTypeValues = [
    'a Student',
    'a Staff',
    // 'a Parent',
    // 'an Administrator'
  ];
  set student(Student student) {
    this._student = student;
    notifyListeners();
  }

  set parent(Parent parent) {
    this._parent = parent;
    notifyListeners();
  }

  set staff(Staff staff) {
    this._staff = staff;
    notifyListeners();
  }

  set accountType(AccountType type) {
    this._accountType = type;
    notifyListeners();
  }

  void getCurrentUser() async {
    switch (getIt<Preference>().accountType) {
      case 'student':
        student = await Student.fromLocalStorage();
        var res = await authAPI.getCurrentUser();
        // student = Student.fromMap(res['data']);
        // await Student.toLocalStorage(student);
        break;
      case 'staff':
        staff = await Staff.fromLocalStorage();
        break;
      case 'parent':
        parent = await Parent.fromLocalStorage();
        break;
      default:
    }
  }

  /// signin the user \
  /// each user signin response is same as the
  /// users signup response, so we'll use the [signup response] as the [signin response]
  void signIn(BuildContext context, SigninReq req) async {
    LoadingToast.show(context, msg: "Please wait...");
    try {
      switch (accountType) {
        case AccountType.Student:
          StudentSignupRes studentSignupRes =
              await authAPI.signIn(req, 'student');
          LoadingToast.dismiss();
          if (studentSignupRes.status == 200) {
            getIt<Preference>().token = studentSignupRes.token;
            getIt<Preference>().accountType = 'student';
            student = studentSignupRes.student;
            await Student.toLocalStorage(studentSignupRes.student);
            pushToDispose(context, StudentMainPage());
          } else {
            Toast.show(context, 'Error ${studentSignupRes.errorMsg}',
                toastType: ToastType.Error);
          }
          break;
        case AccountType.Staff:
          StaffSignupRes staffSignupRes = await authAPI.signIn(req, 'staff');
          LoadingToast.dismiss();
          // if (staffSignupRes.status == 200) {
          //   getIt<Preference>().token = staffSignupRes.token;
          //   getIt<Preference>().accountType = 'staff';
          //   staff = staffSignupRes.staff;
          //   await Staff.toLocalStorage(staffSignupRes.staff);
          //   pushToDispose(context, StaffMainPage());
          // } else {
          //   Toast.show(context, 'Error: ${staffSignupRes.errorMsg}',
          //       toastType: ToastType.Error);
          // }
          break;
        case AccountType.Parent:
          ParentSignupRes parentSignupRes = await authAPI.signIn(req, 'parent');
          LoadingToast.dismiss();
          if (parentSignupRes.status == 200) {
            getIt<Preference>().token = parentSignupRes.token;
            getIt<Preference>().accountType = 'parent';
            parent = parentSignupRes.parent;
            await Parent.toLocalStorage(parentSignupRes.parent);
            pushToDispose(context, ParentHomePage());
          } else {
            Toast.show(context, 'Error: ${parentSignupRes.errorMsg}',
                toastType: ToastType.Error);
          }
          break;
        case AccountType.Administrator:
          break;
        default:
          throw new Exception("$accountType not found");
      }
    } catch (exception) {
      LoadingToast.dismiss();
      Toast.show(context, 'Error: $exception', toastType: ToastType.Error);
    }
  }

  /// signup the student and save the accountType on the device
  void signupStudent(BuildContext context, StudentSignupReq req) async {
    LoadingToast.show(context, msg: "Signing up...", timed: false);
    try {
      StudentSignupRes studentSignupRes = await authAPI.signupStudent(req);
      LoadingToast.dismiss();
      if (studentSignupRes.status == 201) {
        getIt<Preference>().token = studentSignupRes.token;
        getIt<Preference>().accountType = 'student';
        student = studentSignupRes.student;
        getIt<Preference>().verified = false;
        await Student.toLocalStorage(studentSignupRes.student);
        pushToDispose(context, PhonePage(req.phoneNumber));
      } else {
        Toast.show(context, 'Error ${studentSignupRes.errorMsg}',
            toastType: ToastType.Error);
      }
    } catch (exception) {
      LoadingToast.dismiss();
      Toast.show(context, 'Error: $exception', toastType: ToastType.Error);
    }
  }

  void signupParent(BuildContext context, ParentSignupReq req) async {
    LoadingToast.show(context, msg: "Signing up...", timed: false);
    try {
      ParentSignupRes parentSignupRes = await authAPI.signupParent(req);
      LoadingToast.dismiss();
      if (parentSignupRes.status == 201) {
        getIt<Preference>().token = parentSignupRes.token;
        getIt<Preference>().accountType = 'parent';
        parent = parentSignupRes.parent;
        await Parent.toLocalStorage(parentSignupRes.parent);
        getIt<Preference>().verified = false;
        pushToDispose(context, PhonePage(req.phoneNumber));
      } else {
        Toast.show(context, 'Error: ${parentSignupRes.errorMsg}',
            toastType: ToastType.Error);
      }
    } catch (exception) {
      LoadingToast.dismiss();
      Toast.show(context, 'Error: $exception', toastType: ToastType.Error);
    }
  }

  void signupStaff(BuildContext context, StaffSignupReq req) async {
    LoadingToast.show(context, msg: "Signing up...", timed: false);
    try {
      StaffSignupRes staffSignupRes = await authAPI.signupStaff(req);
      LoadingToast.dismiss();
      if (staffSignupRes.status == 201) {
        getIt<Preference>().token = staffSignupRes.token;
        getIt<Preference>().accountType = 'staff';
        staff = staffSignupRes.staff;
        await Staff.toLocalStorage(staffSignupRes.staff);
        getIt<Preference>().verified = false;
        pushToDispose(context, PhonePage(req.phoneNumber));
      } else {
        Toast.show(context, 'Error: ${staffSignupRes.errorMsg}',
            toastType: ToastType.Error);
      }
    } catch (exception) {
      LoadingToast.dismiss();
      Toast.show(context, 'Error: $exception', toastType: ToastType.Error);
    }
  }

  /// send verification code
  void getCode(BuildContext context) async {
    try {
      VerificationCodeResponse codeResponse =
          await authAPI.sendVerificationCode();
      if (codeResponse.status == 200) {
        Toast.show(context, '${codeResponse.msg}');
      } else {
        Toast.show(context, '${codeResponse.msg}', toastType: ToastType.Error);
      }
    } catch (exception) {
      Toast.show(context, '$exception', toastType: ToastType.Error);
    }
  }

  void verifyUser(BuildContext context, String code) async {
    LoadingToast.show(context, msg: 'Please wait');
    bool verificationRes = await authAPI.verifyUser(code);
    if (verificationRes) {
      getIt<Preference>().verified = true;
      switch (getIt<Preference>().accountType) {
        case 'parent':
          // return ParentHomePage();
          break;
        case 'student':
          pushToDispose(context, StudentMainPage());
          break;
        case 'staff':
          // pushToDispose(context, StaffMainPage());
          break;
        // case 'sch_admin':
        //   return ParentHomePage();
        //   break;
        default:
          throw new Exception("${getIt<Preference>().accountType} not found");
      }
    } else {
      Toast.show(context, 'Error: Invalid verification code',
          toastType: ToastType.Error);
    }
  }

  pushSignupRoute(BuildContext context) {
    switch (accountType) {
      case AccountType.Student:
        push(context, StudentSignup());
        break;
      case AccountType.Staff:
        push(context, StaffSignup());
        break;
      case AccountType.Parent:
        push(context, ParentSignup());
        break;
      default:
        throw new Exception("$accountType not found");
    }
  }

  ///log the current user out of the app
  void logout(BuildContext context) async {
    authAPI.logout();
    getIt<Preference>().token = null;
    getIt<Preference>().accountType = null;
    pushToDispose(context, OnboardingPage());
  }
}
