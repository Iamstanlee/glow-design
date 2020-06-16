class SigninRes {
  int status;
  SigninRes.fromMap(Map<String, dynamic> map) {
    this.status = map['status'];
  }
}
