import 'package:glow/data/staff.dart';

class StaffSignupRes {
  int status;
  String token, errorMsg;
  Staff staff;
  StaffSignupRes.fromMap(Map<String, dynamic> map) {
    this.status = map['status'];
    this.token = map['token'];
    this.staff = Staff.fromMap(map['staff']);
  }
  StaffSignupRes.fromErrorMsg(Map<String, dynamic> map) {
    this.status = map['status'];
    this.errorMsg = map['errorMsg'];
  }
}
