import 'package:flutter/material.dart';
import 'package:glow/data/message.dart';
import 'package:glow/helpers/functions.dart';
import 'package:glow/widgets/message_bubble.dart';
import 'package:glow/widgets/messageinput_pad.dart';

class MessagingPage extends StatefulWidget {
  @override
  _MessagingPageState createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage>
    with AfterLayoutMixin<MessagingPage> {
  List<Widget> widgets = [];
  Widget messagePad;
  double messagePadHeight;

  @override
  void afterFirstLayout(BuildContext context) {
    messagePadHeight = getHeight(context, height: 7);
    messagePad = Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: .5,
            spreadRadius: 1.0,
            color: Colors.white.withOpacity(.12))
      ]),
      height: messagePadHeight,
      child: MessageInputPad(
        onSendMsg: (message) {
          setState(() {
            if (message.msg.isNotEmpty)
              widgets.add(ChatBubble(
                msg: Message(
                    msg: message.msg,
                    timeStamp: "12:00 pm",
                    isMe: true,
                    isDelivered: true),
              ));
          });
        },
      ),
    );
    setState(() {
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'Hello World',
            timeStamp: "12:00 pm",
            isMe: false,
            isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'Hi', timeStamp: "6:23 pm", isMe: false, isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'How\'re you doing??',
            timeStamp: "4:40 pm",
            isMe: true,
            isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'Hello World',
            timeStamp: "12:00 pm",
            isMe: true,
            isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'Hi', timeStamp: "6:23 pm", isMe: false, isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'How\'re you doing??',
            timeStamp: "4:40 pm",
            isMe: true,
            isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'Hello World',
            timeStamp: "12:00 pm",
            isMe: false,
            isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'Hi', timeStamp: "6:23 pm", isMe: false, isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'How\'re you doing??',
            timeStamp: "4:40 pm",
            isMe: false,
            isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'Hello World',
            timeStamp: "12:00 pm",
            isMe: false,
            isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'Hi', timeStamp: "6:23 pm", isMe: false, isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'How\'re you doing??',
            timeStamp: "4:40 pm",
            isMe: true,
            isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'Hello World',
            timeStamp: "12:00 pm",
            isMe: true,
            isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'Hi', timeStamp: "6:23 pm", isMe: false, isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'How\'re you doing??',
            timeStamp: "4:40 pm",
            isMe: true,
            isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'Hello World',
            timeStamp: "12:00 pm",
            isMe: false,
            isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'Hi', timeStamp: "6:23 pm", isMe: false, isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'How\'re you doing??',
            timeStamp: "4:40 pm",
            isMe: false,
            isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg:
                'A list of helpful front-end related questions you can use to interview potential candidates, test yourself or completely ignore. ',
            timeStamp: "12:00 pm",
            isMe: false,
            isDelivered: false),
      ));
      widgets.add(ChatBubble(
        msg: Message(
            msg: 'Alright',
            timeStamp: "12:00 pm",
            isMe: true,
            isDelivered: false),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Lendly',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              Text('online',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        body: widgets.isEmpty
            ? Center(
                child: Text('Loading...',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              )
            : ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: Padding(
                    padding:
                        EdgeInsets.only(top: 8, bottom: messagePadHeight + 12),
                    child: ListView(
                      reverse: true,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: widgets,
                          ),
                        )
                      ],
                    )),
              ),
        bottomSheet: messagePad);
  }
}
