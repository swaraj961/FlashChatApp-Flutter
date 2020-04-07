import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'images/logo.png',
                    height: 60,
                  ),
                ),
                Text(
                  'Flash chat App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey.shade800),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Material(
                elevation: 15,
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20),
                child: MaterialButton(
                  onPressed: null,
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
                  onPressed: null,
                  height: 40,
                  minWidth: 200,
                  child: Text(
                    'Register',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
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
