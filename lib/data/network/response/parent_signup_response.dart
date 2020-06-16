import 'package:glow/data/parent.dart';

class ParentSignupRes {
  int status;
  String token, errorMsg;
  Parent parent;
  ParentSignupRes.fromMap(Map<String, dynamic> map) {
    this.status = map['status'];
    this.token = map['token'];
    this.parent = Parent.fromMap(map['parent']);
  }
  ParentSignupRes.fromErrorMsg(Map<String, dynamic> map) {
    this.status = map['status'];
    this.errorMsg = map['errorMsg'];
  }
}
