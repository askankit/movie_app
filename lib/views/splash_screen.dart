import 'package:assignment_flutter/generated/assets.dart';
import 'package:assignment_flutter/views/auth/signin_screeen.dart';
import 'package:assignment_flutter/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    _sharedPref();
    super.initState();
  }

  _sharedPref()async{
    final SharedPreferences prefs = await _prefs;
    if(prefs.getString("user_id") != null){
      3.delay(() => Get.offAll(()=> HomeScreen()));
    }else{
      3.delay(() => Get.offAll(()=> SignInScreen()));
    }
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
