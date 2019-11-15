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
      seconds: 5,
      navigateAfterSeconds:Login(),
    image: new Image.asset('assets/wayaheadLogo.png'),
    backgroundColor: Colors.blue[800],
        photoSize: 100,
        loaderColor: Colors.transparent,
    ));
  }
}
