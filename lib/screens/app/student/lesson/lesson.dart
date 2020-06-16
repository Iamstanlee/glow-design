import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/providers/student_provider/student_lesson_provider.dart';
import 'package:glow/theme.dart';
import 'package:glow/widgets/button/raised_button.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class StudentLessonPage extends StatefulWidget {
  @override
  _StudentLessonPageState createState() => _StudentLessonPageState();
}

class _StudentLessonPageState extends State<StudentLessonPage>
    with AfterLayoutMixin<StudentLessonPage> {
  @override
  void afterFirstLayout(BuildContext context) {
    final lessonProvider = Provider.of<StudentLessonProvider>(context);
    lessonProvider.play(context);
  }

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<StudentLessonProvider>(context);
    final _controller = lessonProvider.controller;
    final double duration =
        _controller.value.duration?.inMilliseconds?.toDouble();
    final double position =
        _controller.value.position?.inMilliseconds?.toDouble();
    final double playerHeight = getHeight(context, height: 28);
    return SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _controller == null
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _controller.value.initialized
                        ? Stack(
                            children: <Widget>[
                              Container(
                                  height: playerHeight,
                                  color: Colors.red,
                                  child: VideoPlayer(_controller)),
                              Positioned(
                                  top: 8.0,
                                  left: 8.0,
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    color: Colors.white60,
                                    onPressed: () {},
                                  )),
                              Positioned(
                                top: (playerHeight / 2) - 24,
                                right: 0.0,
                                left: 0.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kHorizontalPadding),
                                      child: IconButton(
                                          icon: ImageIcon(
                                            assetImage(
                                                _controller.value.isPlaying
                                                    ? 'pause'
                                                    : 'play'),
                                            size: 24,
                                            color: primaryColor,
                                          ),
                                          onPressed: () {
                                            _controller.value.isPlaying
                                                ? _controller.pause()
                                                : _controller.play();
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 0.0,
                                right: 0.0,
                                left: 16.0,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text('${getFormattedDuration(position)}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)),
                                    Expanded(
                                        child: Slider(
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.white38,
                                      value: position,
                                      max: duration,
                                      onChanged: (value) {
                                        _controller.seekTo(Duration(
                                            milliseconds: value.toInt()));
                                      },
                                    )),
                                    Text('${getFormattedDuration(duration)}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      child: IconButton(
                                        icon: Icon(Icons.crop_free),
                                        color: Colors.white,
                                        onPressed: () {},
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        : lessonProvider.videoHasError
                            ? Container(
                                height: getHeight(context, height: 28),
                                child: Center(
                                  child: Text('Playback Error',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ),
                                color: Colors.black)
                            : Container(
                                height: getHeight(context, height: 28),
                                child: Center(
                                  child: CupertinoTheme(
                                    data: CupertinoTheme.of(context)
                                        .copyWith(brightness: Brightness.dark),
                                    child:
                                        CupertinoActivityIndicator(radius: 15),
                                  ),
                                ),
                                color: Colors.black),
                    metadataWidget(),
                    Divider(height: 24, thickness: 1)
                  ],
                ),
          bottomSheet: Container(
            width: getWidth(context),
            padding: EdgeInsets.all(kHorizontalPadding),
            child: raisedButton(() {}, 'next lesson'),
          ),
        ));
  }
}

Widget metadataWidget() {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding, vertical: 12),
                  child: Text('Implementation of surd',
                      style: TextStyle(fontSize: 21),
                      textAlign: TextAlign.left))),
          IconButton(
              icon: ImageIcon(
                assetImage('download'),
                size: 18,
                color: primaryColor,
              ),
              onPressed: () {})
        ],
      ),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Text(
              ' It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.left)),
    ],
  );
}
