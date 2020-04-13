import 'package:flutter/material.dart';
import 'package:flashchat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final textEditingController = TextEditingController();
  FirebaseUser loginUser;
  String messagetext = '';
  String userid;

  @override
  void initState() {
    super.initState();
    getcurrentuser();
  }

  void getcurrentuser() async {
    try {
      final user = await _auth.currentUser();
      if (loginUser != null) loginUser = user;
      userid = user.email;
      print(userid);
    } catch (e) {
      print(e);
    }
  }
//  void getmessages() async {
//    final messages = await _firestore.collection('messsages').getDocuments();
//    for (var message in messages.documents) {
//      print(message.data);
//    }
//  }

  void messagestream() async {
    //stream function of data from firestone
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.documents) {
        print(message.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('⚡️Chat'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              messagestream();
//              _auth.signOut();
//              Navigator.pop(context);
//              getmessages();
            },
          ),
        ],
        backgroundColor: Color(0XFF4dd0e1).withOpacity(0.90),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                        controller: textEditingController,
                        onChanged: (value) {
                          setState(() {
                            messagetext = value;
                          });
                        },
                        decoration: kMessageTextFieldDecoration),
                  ),
                  FlatButton(
                    onPressed: () {
                      textEditingController.clear();
                      _firestore
                          .collection('messages')
                          .add({'sender': userid, 'text': messagetext});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .snapshots(), // assign the stream of data
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0XFF4dd0e1).withOpacity(0.90),
            ),
          );
        }
        final messages = snapshot.data.documents;
        List<MessageBubble> messagebubbles = [];
        for (var msg in messages) {
          final messagetxt = msg.data['text'];
          final messagesender = msg.data['sender'];
          final messagebubble = MessageBubble(
            message: messagetxt,
            sender: messagesender,
          );
          messagebubbles.add(messagebubble);
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messagebubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final String sender;
  MessageBubble({this.message, this.sender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
        Text(
          '$sender',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        SizedBox(
          height: 4,
        ),
        Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 10,
          color: Color(0XFF4dd0e1).withOpacity(0.90),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text('$message'),
          ),
        ),
      ]),
    );
  }
}
