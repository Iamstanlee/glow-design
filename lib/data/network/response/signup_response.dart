class SignupRes {
  int status;
  SignupRes.fromMap(Map<String, dynamic> map) {
    this.status = map['status'];
  }
}
