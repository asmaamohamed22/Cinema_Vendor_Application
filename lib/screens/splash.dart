import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cinema_vendor_app/screens/admin_home.dart';

class Splash extends StatefulWidget {
  static String id = 'Splash';
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5), () => Navigator.pushNamed(context, AdminHome.id));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/movie.gif',
              height: size.height * 0.6,
              width: size.width * 0.6,
            ),
          ],
        ),
      ),
    );
  }
}
