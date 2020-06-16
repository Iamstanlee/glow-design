import 'package:glow/helpers/functions.dart';

class ParentSignupReq {
  String fullname, email, username, phoneNumber, password;

  static Map<String, dynamic> toMap(ParentSignupReq req) {
    return {
      "fullname": req.fullname,
      "email": req.email,
      "username": req.username,
      "phoneNumber": getIntPhoneFormatIn9(req.phoneNumber),
      "password": req.password,
      "confirmPassword": req.password,
    };
  }
}
