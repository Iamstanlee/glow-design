import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glow/widgets/toast/toast.dart';
import 'package:video_player/video_player.dart';

class StudentLessonProvider with ChangeNotifier {
  VideoPlayerController _controller;
  VideoPlayerController get controller => _controller;
  bool _videoHasError = false;
  bool get videoHasError => _videoHasError;
  set videoHasError(bool error) {
    this._videoHasError = error;
    notifyListeners();
  }

  set controller(VideoPlayerController controller) {
    this._controller = controller;
    notifyListeners();
  }

  playListener() {
    notifyListeners();
  }

  // _controller.pause().then((pause) {
  //     new Timer(Duration(milliseconds: 100), () {
  //       _controller.dispose().then((dispose) {
  //         init(index);
  //       });
  //     });
  //   });
  play(BuildContext context) async {
    controller = VideoPlayerController.network(
        'https://file-examples.com/wp-content/uploads/2017/04/file_example_MP4_480_1_5MG.mp4');
    try {
      await controller.initialize();
      controller.addListener(playListener);
      controller.play();
    } catch (exception) {
      videoHasError = true;
      Toast.show(context, 'Error playing video', toastType: ToastType.Error);
    }
  }
}
