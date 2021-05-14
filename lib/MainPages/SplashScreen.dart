import 'package:exam_qrcode/MainPages/HomePage.dart';
import 'package:exam_qrcode/MainPages/LoginPage.dart';
import 'package:exam_qrcode/Widgets/ColorsNConstants.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SplashScreen(
      seconds: 5,
      backgroundColor: indigodye,
      loaderColor: aquamarine,
      navigateAfterSeconds: LoginPage(),
    ));
  }
}
