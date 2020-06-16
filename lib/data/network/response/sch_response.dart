import 'package:glow/data/sch.dart';

class SchRes {
  int status;
  String message, results;
  List<Sch> schs;
  SchRes.fromMap(Map<String, dynamic> map) {
    List<Sch> s = [];
    List<dynamic> schList = map['response']['data'];
    for (int i = 0; i < schList.length; i++) {
      s.add(Sch.fromMap(schList[i]));
    }
    this.schs = s;
    this.status = map['status'];
    this.message = map['message'];
    this.results = map["results"];
  }
}
