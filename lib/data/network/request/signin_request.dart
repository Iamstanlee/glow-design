class SigninReq {
  String username, password;
  SigninReq.isEmpty() {
    this.password = '';
    this.username = '';
  }
  static Map<String, dynamic> toMap(SigninReq req) {
    return {'username': req.username, 'password': req.password};
  }
}
