import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glow/apis/sch_api.dart';
import 'package:glow/data/network/response/sch_response.dart';
import 'package:glow/data/sch.dart';
import 'package:glow/widgets/toast/loading_toast.dart';
import 'package:glow/widgets/toast/toast.dart';

class SchProvider with ChangeNotifier {
  final SchAPI schAPI = new SchAPI();
  List<Sch> _schs = [];
  String _error;
  String get loadingError => _error;
  set loadingError(String error) {
    this._error = error;
    notifyListeners();
  }

  List<Sch> get schs => _schs;
  set schs(List<Sch> s) {
    this._schs = s;
    notifyListeners();
  }

  void getSchs(BuildContext context) async {
    loadingError = null;
    LoadingToast.show(context, msg: 'Loading Schools...', timed: false);
    try {
      SchRes schRes = await schAPI.getSchs();
      if (schRes.status == 200) {
        schs = schRes.schs;
      } else {
        loadingError = 'Error: Something went wrong, Try again.';
      }
    } catch (exception) {
      loadingError = 'Error: $exception';
    }
    LoadingToast.dismiss();
  }
}
