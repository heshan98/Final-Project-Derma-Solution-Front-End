import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/screens/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Simulate some loading process here, e.g., fetching data or initializing resources
    // Set a loading timeout to ensure that the loader is displayed for a minimum duration
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        _isLoading = false; // Turn off the loader
      });

      // After loading, navigate to the LoginScreen
      Timer(const Duration(milliseconds: 500), () {
        Get.off(() => const LoginScreen(), transition: Transition.fade, curve: Curves.easeInOut, duration: const Duration(milliseconds: 2000));
      });
    });

    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Container(
          //   color: Colors.white,
          //   child: Center(
          //     child: Hero(
          //       tag: 'logo',
          //       child: Image.asset(
          //         'assets/images/logo.png',
          //         height: 300,
          //         width: 300,
          //         fit: BoxFit.contain,
          //       ),
          //     ),
          //   ),
          // ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          Positioned(
            bottom: 5,
            child: Icon(
              Icons.access_alarm,
              color: Colors.amber,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
