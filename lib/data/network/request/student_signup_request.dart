import 'package:glow/helpers/functions.dart';

class StudentSignupReq {
  String fullname,
      email,
      username,
      phoneNumber,
      dob,
      schName,
      schAddress,
      schClass,
      password;
  static Map<String, dynamic> toMap(StudentSignupReq req) {
    return {
      "fullname": req.fullname,
      "email": req.email,
      "username": req.username,
      "phoneNumber": getIntPhoneFormatIn9(req.phoneNumber),
      "dateOfBirth": req.dob,
      "schoolName": req.schName,
      "schoolAddress": req.schAddress,
      "class": req.schClass,
      "password": req.password,
      "confirmPassword": req.password
    };
  }
}
