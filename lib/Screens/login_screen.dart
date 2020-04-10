import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0XFF08d9d6).withOpacity(0.90),
        body: SafeArea(
          child: Column(children: <Widget>[
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
            Text(
              'Welcome Back !',
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
                color: Colors.orange.shade400.withOpacity(0.90),
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your Email',
                        hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                        contentPadding: EdgeInsets.all(20)),
                  ),
                  Divider(
                    thickness: 0.5,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(fontSize: 16, color: Colors.white),
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
              color: Color(0xFF00e676),
              borderRadius: BorderRadius.circular(20),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'login_page');
                },
                minWidth: 150,
                height: 10,
                child: Text(
                  'Login ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
              ),
            ),
          ]),
        ));
  }
}
