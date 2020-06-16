import 'package:flutter/material.dart';
import 'package:glow/data/message.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/theme.dart';

class ChatBubble extends StatefulWidget {
  ChatBubble({this.msg});
  final Message msg;

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble>
    with AfterLayoutMixin<ChatBubble> {
  @override
  void afterFirstLayout(BuildContext context) {
    // Future.delayed(Duration(seconds: 2), () {
    //   setState(() {
    //     widget.msg.isDelivered = true;
    //   });
    // });
    setState(() {
      widget.msg.isDelivered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bg = widget.msg.isMe ? primaryColor : Colors.white;
    final align =
        widget.msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final icon = widget.msg.isDelivered ? Icons.done : Icons.access_time;
    final double paddingRight = widget.msg.isMe ? 12 : 0;
    final double paddingLeft = widget.msg.isMe ? 12 : 0;
    final radius = widget.msg.isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(8.0),
          constraints: BoxConstraints(maxWidth: getWidth(context, width: 80)),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 70.0),
                child: Text(widget.msg.msg,
                    style: TextStyle(
                        color: widget.msg.isMe ? Colors.white : Colors.black,
                        fontSize: 14.0)),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(widget.msg.timeStamp,
                        style: TextStyle(
                            color: widget.msg.isMe
                                ? Colors.white70
                                : Colors.black87,
                            fontSize: 10.0)),
                    SizedBox(width: 3.0),
                    widget.msg.isMe
                        ? Icon(icon, size: 14.0, color: Colors.white)
                        : Container()
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
