import 'dart:convert';
import 'package:glow/apis/api.dart';
import 'package:glow/data/network/request/parent_signup_request.dart';
import 'package:glow/data/network/request/signin_request.dart';
import 'package:glow/data/network/request/staff_signup_request.dart';
import 'package:glow/data/network/request/student_signup_request.dart';
import 'package:glow/data/network/response/parent_signup_response.dart';
import 'package:glow/data/network/response/signin_response.dart';
import 'package:glow/data/network/response/staff_signup_response.dart';
import 'package:glow/data/network/response/student_signup_response.dart';
import 'package:glow/data/network/response/verificationcode_response.dart';
import 'package:glow/helpers/preferences.dart';
import 'package:glow/main.dart';
import 'package:glow/providers/auth_provider.dart';

class AuthAPI extends API {
  Future<dynamic> getCurrentUser() async {
    try {
      var res = await get("users/me", headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token ${getIt<Preference>().token}'
      });
      print(json.decode(res.body));
      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
    } catch (exception) {
      print(exception);
      throw new Exception(exception);
    }
  }

  Future<dynamic> signIn(SigninReq req, String endpoint) async {
    try {
      var res = await post('$endpoint/login', body: SigninReq.toMap(req));
      var response = json.decode(res.body);
      switch (getIt<AuthProvider>().accountType) {
        case AccountType.Student:
          Map<String, dynamic> map = {};
          if (res.statusCode == 200) {
            map['status'] = res.statusCode;
            map['token'] = response['token'];
            map['student'] = response['data']['user'];
            return StudentSignupRes.fromMap(map);
          } else {
            map['status'] = res.statusCode;
            map['errorMsg'] = response['message'];
            return StudentSignupRes.fromErrorMsg(map);
          }
          break;
        case AccountType.Parent:
          Map<String, dynamic> map = {};
          if (res.statusCode == 200) {
            map['status'] = res.statusCode;
            map['token'] = response['token'];
            map['parent'] = response['data']['user'];
            return ParentSignupRes.fromMap(map);
          } else {
            map['status'] = res.statusCode;
            map['errorMsg'] = response['message'];
            return ParentSignupRes.fromErrorMsg(map);
          }
          break;
        case AccountType.Staff:
          Map<String, dynamic> map = {};
          if (res.statusCode == 200) {
            map['status'] = res.statusCode;
            map['token'] = response['token'];
            map['staff'] = response['data']['user'];
            return StaffSignupRes.fromMap(map);
          } else {
            map['status'] = res.statusCode;
            map['errorMsg'] = response['message'];
            return StaffSignupRes.fromErrorMsg(map);
          }
          break;
        case AccountType.Administrator:
          break;
        default:
          throw new Exception('${getIt<AuthProvider>().accountType} not found');
      }
      return SigninRes.fromMap(response);
    } catch (exception) {
      return throw new Exception(exception);
    }
  }

  Future<StudentSignupRes> signupStudent(StudentSignupReq req) async {
    try {
      var res =
          await post('student/register', body: StudentSignupReq.toMap(req));
      var response = json.decode(res.body);
      Map<String, dynamic> map = {};
      if (res.statusCode == 201) {
        map['status'] = res.statusCode;
        map['token'] = response['token'];
        map['student'] = response['data']['user'];
        return StudentSignupRes.fromMap(map);
      } else {
        map['status'] = res.statusCode;
        map['errorMsg'] = response['message'];
        return StudentSignupRes.fromErrorMsg(map);
      }
    } catch (exception) {
      return throw new Exception(exception);
    }
  }

  Future<ParentSignupRes> signupParent(ParentSignupReq req) async {
    try {
      var res = await post('parent/register', body: ParentSignupReq.toMap(req));
      var response = json.decode(res.body);
      Map<String, dynamic> map = {};
      if (res.statusCode == 201) {
        map['status'] = res.statusCode;
        map['token'] = response['token'];
        map['parent'] = response['data']['user'];
        return ParentSignupRes.fromMap(map);
      } else {
        map['status'] = res.statusCode;
        map['errorMsg'] = response['message'];
        return ParentSignupRes.fromErrorMsg(map);
      }
    } catch (exception) {
      return throw new Exception(exception);
    }
  }

  Future<StaffSignupRes> signupStaff(StaffSignupReq req) async {
    try {
      var res = await post('staff/register', body: StaffSignupReq.toMap(req));
      var response = json.decode(res.body);
      Map<String, dynamic> map = {};
      if (res.statusCode == 201) {
        map['status'] = res.statusCode;
        map['token'] = response['token'];
        map['staff'] = response['data']['user'];
        return StaffSignupRes.fromMap(map);
      } else {
        map['status'] = res.statusCode;
        map['errorMsg'] = response['message'];
        return StaffSignupRes.fromErrorMsg(map);
      }
    } catch (exception) {
      return throw new Exception(exception);
    }
  }

  Future<VerificationCodeResponse> sendVerificationCode() async {
    try {
      var res = await get('users/me/verification_code', headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getIt<Preference>().token}'
      });
      var response = json.decode(res.body);
      Map<String, dynamic> map = {};
      print(response);
      if (res.statusCode == 200) {
        map['status'] = res.statusCode;
        map['msg'] = response['message'];
        map['code'] = response['verificationCode'];
        return VerificationCodeResponse.fromMap(map);
      } else {
        map['status'] = res.statusCode;
        map['errorMsg'] = response['message'];
        return VerificationCodeResponse.fromErrorMsg(map);
      }
    } catch (exception) {
      return throw new Exception(exception);
    }
  }

  Future<bool> verifyUser(String vc) async {
    // vc -> verification code to the users phone
    try {
      var res = await post('users/me/verify_my_account', body: {
        'verificationCode': vc
      }, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getIt<Preference>().token}'
      });
      if (res.statusCode == 200) {
        return true;
      }
      return false;
    } catch (exception) {
      return throw new Exception(exception);
    }
  }

  Future<Null> logout() async {
    await get('logout', headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${getIt<Preference>().token}'
    });
  }
}
