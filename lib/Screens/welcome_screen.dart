import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                                      child: Container(
                      child: Image.asset(
                        'images/logo.png',
                        height: 70,
                      ),
                    ),
                  ),
                  Text(
                    'Flash Chat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey.shade800),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Material(
                elevation: 15,
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'login_page');
                  },
                  minWidth: 200,
                  height: 40,
                  child: Text(
                    'Login ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 15,
                color: Colors.redAccent,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'register_page');
                  },
                  height: 40,
                  minWidth: 200,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
