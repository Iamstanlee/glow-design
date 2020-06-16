import 'package:flutter/material.dart';
import 'package:glow/data/message.dart';
import 'package:glow/helpers/functions.dart';

class MessageInputPad extends StatefulWidget {
  final Function(Message) onSendMsg;
  MessageInputPad({this.onSendMsg});
  @override
  _MessageInputPadState createState() => _MessageInputPadState();
}

class _MessageInputPadState extends State<MessageInputPad> {
  final messageCTR = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
              width: getWidth(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: TextField(
                            controller: messageCTR,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type a message'),
                          ))),
                  Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: InkWell(
                          onTap: () {
                            widget.onSendMsg(Message(msg: messageCTR.text));
                            messageCTR.clear();
                          },
                          child: ImageIcon(assetImage('send'))))
                ],
              )),
        ],
      ),
    );
  }
}
