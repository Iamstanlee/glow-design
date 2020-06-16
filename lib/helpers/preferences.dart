import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  SharedPreferences sharedPreferences;
  Future<Null> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  set token(String token) => sharedPreferences.setString('token', token);
  String get token => sharedPreferences.getString('token') ?? '';
  set verified(bool verify) => sharedPreferences.setBool('verified', verify);
  bool get verified => sharedPreferences.getBool('verified') ?? '';
  set accountType(String at) => sharedPreferences.setString('accountType', at);
  String get accountType => sharedPreferences.getString('accountType') ?? '';
}
