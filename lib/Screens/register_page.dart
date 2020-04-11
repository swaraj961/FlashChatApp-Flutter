import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  bool showspinner = false;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0XFF08d9d6).withOpacity(0.90),
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Register Here!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 140,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.orange.shade400.withOpacity(0.85),
                ),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your Email',
                          hintStyle:
                              TextStyle(fontSize: 16, color: Colors.white),
                          contentPadding: EdgeInsets.all(20)),
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle:
                              TextStyle(fontSize: 16, color: Colors.white),
                          contentPadding: EdgeInsets.all(20)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Material(
                elevation: 15,
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20),
                child: MaterialButton(
                  onPressed: () async {
                    setState(() {
                      showspinner = true;
                    });
                    try {
                      final newuser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      if (newuser != null)
                        Navigator.pushNamed(context, 'chat_page');
                      setState(() {
                        showspinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  minWidth: 150,
                  height: 10,
                  child: Text(
                    'Register ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
