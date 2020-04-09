import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
//  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  Animation animation1;

  // Animation animation2;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        upperBound: 1, vsync: this, duration: Duration(seconds: 1));
    controller.forward();
    animation1 = CurvedAnimation(parent: controller, curve: Curves.decelerate);
// animation2 = ColorTween(begin: Colors.grey, end: Colors.lightBlueAccent).animate(controller)
    controller.addListener(() {
      setState(() {});
      print(animation1.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent, // withOpacity(controller.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(8, 6, 15, 0),
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset(
                        'images/logo.png',
                        height: animation1.value * 100,
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
                    height: 130,
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
