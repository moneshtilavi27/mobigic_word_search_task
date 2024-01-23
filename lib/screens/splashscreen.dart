import 'dart:async';

import 'package:flutter/material.dart';
import 'package:word_search/main.dart';
import 'package:word_search/screens/homepage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const HameScreen(title: 'Flutter Demo Home Page')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(163, 246, 246, 252),
            Color.fromARGB(201, 247, 255, 177),
          ],
        )),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: Image(
                image: AssetImage('assets/mobigic_logo.png'),
                width: 250,
                height: 250,
              ),
            ),
            Padding(padding: EdgeInsets.all(15.0)),
            Text(
              'Mobigic',
              style: TextStyle(
                fontSize: 35,
                color: Color.fromARGB(255, 100, 110, 248),
                letterSpacing: 0.084,
                fontWeight: FontWeight.w500,
                height: 2,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.left,
            ),
            Text(
              'Word Search App In Grid',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 160, 166, 255),
                letterSpacing: 0.084,
                fontWeight: FontWeight.w500,
                height: 2,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
