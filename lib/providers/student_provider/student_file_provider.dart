import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/widgets/toast/loading_toast.dart';

class StudentFileProvider with ChangeNotifier {
  File _file;
  File get file => _file;
  set file(File file) {
    this._file = file;
    notifyListeners();
  }

  /// download pdf from url and save to device
  /// if the pdf has already been downloaded or exists on the device
  /// just read the pdf file
  void downloadPDFFromURL(BuildContext context, String url) async {
    file = null;
    LoadingToast.show(context, msg: "Please wait...", timed: false);
    bool fileExist = await checkFileExistence('pdfile2.pdf');
    if (fileExist) {
      String path = await getAppPath();
      file = File("$path/pdfile2.pdf");
    } else {
      File downloadedFile = await downloadFileFromURL(url,
          fileName: 'pdfile2', fileExtension: 'pdf');
      file = downloadedFile;
    }
    LoadingToast.dismiss();
  }
}
