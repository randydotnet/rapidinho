import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rapidinho/pages/home_page.dart';
import 'package:rapidinho/pages/splash_page.dart';

void main() => runApp(
  RapidinhoApp()
);

class RapidinhoApp extends StatelessWidget {

  RapidinhoApp(){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.red[700]));
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rapidinho',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashPageAnimator(),
      debugShowCheckedModeBanner: false,
    );
  }
}
