import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_managment_app/src/presentation/screens/splash/splash.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
  ));
  runApp(const StartSplashScreen());
}
