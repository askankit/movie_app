import 'package:assignment_flutter/generated/assets.dart';
import 'package:assignment_flutter/views/auth/signin_screeen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    3.delay(() => Get.offAll(()=> SignInScreen()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Center(
          child: Lottie.asset(Assets.jsonsSplash),
        ),
      ),
    );
  }
}
