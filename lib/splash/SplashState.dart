import 'package:flutter/material.dart';

import 'Splash.dart';

class SplashState extends State<Splash>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image:
              AssetImage("assets/images/splash.png"),
            fit: BoxFit.cover
          )
        ),
    ));
  }

}