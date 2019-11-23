import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Login.dart';

void main() => {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.white)),
      runApp(MyApp())
    };

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: SplashScreen(
      seconds: 2,
      navigateAfterSeconds:Login(),
    image: new Image.asset('assets/logo_splash.png'),
    backgroundColor: Colors.blue[800],
        photoSize: 260,
        loaderColor: Colors.transparent,
    ));
  }
}
