import 'package:glow/helpers/functions.dart';

class StaffSignupReq {
  String fullname,
      email,
      username,
      role,
      phoneNumber,
      password,
      schName,
      schAddress;
  List<String> subjects, classes;

  static Map<String, dynamic> toMap(StaffSignupReq req) {
    return {
      "fullname": req.fullname,
      "email": req.email,
      // 'role': req.role,
      "username": req.username,
      "phoneNumber": getIntPhoneFormatIn9(req.phoneNumber),
      "password": req.password,
      "confirmPassword": req.password,
      "schoolName": req.schName,
      "schoolAddress": req.schAddress,
      "subjects": req.subjects,
      "classes": req.classes,
    };
  }
}
