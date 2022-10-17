import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_gallery/ui/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'assets/splash_screen_image.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
