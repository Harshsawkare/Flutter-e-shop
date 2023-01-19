
import 'dart:ui';

import 'package:eshop/Screens/Signup.dart';
import 'package:eshop/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {};
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    route();
    super.initState();
  }

  void route(){
    Future.delayed(Duration(seconds: 2)).then((value){
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          Signup()
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryLight,
      body: Center(
        child: Text("e-Shop",
          style: TextStyle(
            color: primaryLight,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "poppins"
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
