import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
String loggedin;

class ScreenChat extends StatefulWidget {
  // static const String id = "ChatScreen";
  @override
  _ScreenChatState createState() => _ScreenChatState();
}

class _ScreenChatState extends State<ScreenChat> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();

  String messageText;

  @override
  Void initState() {
    super.initState();
    getCurentUser();
  }

  void getCurentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        print(user);
        loggedin = user.email;
      }
    } catch (e) {
      print(e);
    }
  }

  void messageLive() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff3A6EFF),
          title: Text("Chat Familly Group"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //write your code here
                // messageLive();
                _auth.signOut();
                Navigator.pop(context);
              },
            ),
          ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamMessages(),
          Row(
            children: [
              Expanded(
                  // width: 320,
                  // padding: EdgeInsets.all(10.0),
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: TextField(
                  controller: messageTextController,
                  onChanged: (value) {
                    //your code here
                    messageText = value;
                  },
                  autocorrect: true,
                  decoration: InputDecoration(
                    hintText: 'type a message',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide:
                          BorderSide(color: Color(0xff24439A), width: 2.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide:
                          BorderSide(color: Color(0xff3A6EFF), width: 2.5),
                    ),
                  ),
                ),
              )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () {
                      //your code here
                      messageTextController.clear();
                      _firestore.collection('messages').add(
                        {
                          'text': messageText,
                          'sender': loggedin,
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      // margin: EdgeInsets.all(10.0),

                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff24439A),
                      ),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class StreamMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data.docs.reversed;
          List<MessageBubles> messageBubles = [];
          for (var message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final currentUser = loggedin;
            final messageBuble = MessageBubles(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
            );
            messageBubles.add(messageBuble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: messageBubles,
            ),
          );
        }
        return Column(
            // children: messageWidgets,
            );
      },
    );
  }
}

class MessageBubles extends StatelessWidget {
  MessageBubles({this.sender, this.text, this.isMe});
  final String text;
  final String sender;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender, style: TextStyle(fontSize: 10.0, color: Colors.black54)),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.green[700] : Colors.lightBlueAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
