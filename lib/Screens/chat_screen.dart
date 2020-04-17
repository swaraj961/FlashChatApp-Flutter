import 'package:flutter/material.dart';
import 'package:flashchat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:random_color/random_color.dart';

final _firestore = Firestore.instance;
FirebaseUser loginUser;
final _auth = FirebaseAuth.instance;
RandomColor randomColor = RandomColor();
Color color = randomColor.randomColor();

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textEditingController = TextEditingController();

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
      if (user != null) {
        loginUser = user;
        userid = user.email;
        print(loginUser.email);
      }
      // print(userid);
    } catch (e) {
      print(e);
    }
  }

  // void messagestream() async {
  //   //stream function of data from firestone
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.documents) {
  //       print(message.data);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('⚡️Group Chat'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              setState(() {
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Logout ALERT",
                  desc: "Do you want to Logout",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        setState(() {
                          _auth.signOut();
                          Navigator.pushNamed(context, 'welcome_screen');
                        });
                      },
                      color: Color.fromRGBO(0, 179, 134, 1.0),
                    ),
                    DialogButton(
                      child: Text(
                        "NO",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.pushNamed(context, 'chat_page');
                        });
                      },
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(116, 116, 191, 1.0),
                        Color.fromRGBO(52, 138, 199, 1.0)
                      ]),
                    )
                  ],
                ).show();
              });
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
        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messagebubbles = [];
        for (var msg in messages) {
          final messagetxt = msg.data['text'];
          final messagesender = msg.data['sender'];
          final currentuser = loginUser.email;
          // print('current is $currentuser');
          final messagebubble = MessageBubble(
            message: messagetxt,
            sender: messagesender,
            isme: currentuser == messagesender,
          );
          messagebubbles.add(messagebubble);
        }
        return Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (_, int index) => messagebubbles[index],

            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            // children: messagebubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isme;
  final String sender;
  MessageBubble({this.message, this.sender, this.isme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$sender',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          SizedBox(
            height: 4,
          ),
          Material(
            borderRadius: isme
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
            elevation: 10,
            color: isme ? Color(0XFF4dd0e1).withOpacity(0.90) : color,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text('$message'),
            ),
          ),
        ],
      ),
    );
  }
}
