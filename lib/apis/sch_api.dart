import 'dart:convert';

import 'package:glow/apis/api.dart';
import 'package:glow/data/network/response/sch_response.dart';

class SchAPI extends API {
  Future<SchRes> getSchs() async {
    try {
      var res = await get('schools');
      var response = json.decode(res.body);
      Map<String, dynamic> map = {};
      map['status'] = res.statusCode;
      map['response'] = response;
      return SchRes.fromMap(map);
    } catch (exception) {
      return throw new Exception(exception);
    }
  }
}
