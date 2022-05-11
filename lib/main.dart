import 'package:burnett/Registration/RegMain.dart';
import 'package:burnett/login/LoginScreen.dart';
import 'package:burnett/util/AppColors.dart';
import 'package:flutter/material.dart';
import 'Home/HomePage.dart';
import 'Splash/Splash.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Color(0XFFc80718),
      accentColor: Color(0XFFE25E14),
      buttonColor: Color(0XFFc80718),
      fontFamily: "Open Sans",
      textTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: AppColors.appDefaultTextColor,
      ),
    ),
    home: Splash(),
  ));
}
