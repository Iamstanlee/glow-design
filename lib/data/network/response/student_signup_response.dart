import 'package:glow/data/student.dart';

class StudentSignupRes {
  int status;
  String token, errorMsg;
  Student student;
  StudentSignupRes.fromMap(Map<String, dynamic> map) {
    this.status = map['status'];
    this.token = map['token'];
    this.student = Student.fromMap(map['student']);
  }
  StudentSignupRes.fromErrorMsg(Map<String, dynamic> map) {
    this.status = map['status'];
    this.errorMsg = map['errorMsg'];
  }
}
