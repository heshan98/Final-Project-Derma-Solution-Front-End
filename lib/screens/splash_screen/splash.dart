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

  _SplashScreenState() {
print("abcdef");
        Timer(const Duration(milliseconds: 500), () {
          Get.off(() => const LoginScreen(), transition: Transition.fade, curve: Curves.easeInOut, duration: const Duration(milliseconds: 2000));

        });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          // mainAxisSize: MainAxisSize.max,
          fit: StackFit.passthrough,
          children: [
            // Center(child: SizedBox(
            //     // width: Get.width / 2,
            //
            //     child:
            //     Hero(tag: 'logo',
            //         child: Image.asset('assets/images/CSlogo_white.png',
            //             fit: BoxFit.contain)))),
            Positioned(
                bottom: 5,
                child:
                // Image.asset('assets/images/footer.png',
                //     width: Get.width,
                //     fit: BoxFit.fitWidth)
                Icon( Icons.access_alarm, color: Colors.amber, size: 30,)
            )
          ],
        ),
        // child: Image.asset('assets/images/splash.png', fit: BoxFit.cover),
      ),
    );
  }
}
