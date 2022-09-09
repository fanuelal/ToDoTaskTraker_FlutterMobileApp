import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            child: Image.asset('assets/images/logo.png',
            fit: BoxFit.cover,)),
          const Text('TO DO ',style: TextStyle(fontSize: 40, 
          fontWeight: FontWeight.bold, 
          color: Colors.white,
          fontFamily: "TitilliumWeb"),
          ),
        ],
      ),
      backgroundColor: Colors.blueGrey,
      nextScreen: MyHomePage(),
      splashIconSize: 220,
      
      duration: 4000,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
