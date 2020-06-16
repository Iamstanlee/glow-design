class VerificationCodeResponse {
  String msg, code;
  int status;
  VerificationCodeResponse.fromMap(Map map) {
    this.status = map['status'];
    this.msg = map['msg'];
    this.code = map['code'];
  }
  VerificationCodeResponse.fromErrorMsg(Map map) {
    this.status = map['status'];
    this.msg = map['errorMsg'];
  }
}
