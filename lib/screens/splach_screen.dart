import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chat_firebase_app/screens/welcome_screeen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: AnimatedSplashScreen(
              splash: "images/logo.png",
              backgroundColor: Colors.white.withOpacity(0.08),
              splashIconSize: 500,
              duration: 2000,
              splashTransition: SplashTransition.scaleTransition,
              nextScreen: const welcomeScreen(),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.white.withOpacity(0.08),
              child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),),
            ),
          )
        ],
      ),
    );
  }
}
