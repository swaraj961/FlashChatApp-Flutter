import 'package:flashchat/Screens/Welcome_screen.dart';
import 'package:flashchat/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/Screens/register_page.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'welcome_screen',
     routes: 
     {
      'welcome_screen' : (context) => WelcomeScreen(),
      'login_page' : (context)=> LoginPage(),
    'register_page': (context) => RegisterPage(),
     },
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      home:WelcomeScreen(),
    );
  }
}