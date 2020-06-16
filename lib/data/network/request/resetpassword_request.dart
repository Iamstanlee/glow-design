class ResetPwRequest {
  String _email, _code;
  String get email => _email;
  String get code => _code;
  set email(String email) => this._email = email;
  set code(String code) => this._code = code;
  static toMap(ResetPwRequest resetPwRequest) {
    return {'email': resetPwRequest.email, 'code': resetPwRequest.code};
  }
}
