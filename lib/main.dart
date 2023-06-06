import 'package:assignment_flutter/views/auth/app_colors.dart';
import 'package:assignment_flutter/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
Future initializeFirebase() async {
  await Firebase.initializeApp(
    name: "LoveOneFish",
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeFirebase();
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..boxShadow = [
      const BoxShadow(
        color: Colors.black12,
        blurRadius: 10.0, // has the effect of softening the shadow
        spreadRadius: 0.0, // has the effect of extending the shadow
        offset: Offset(
          0, // horizontal, move right 10
          5.0, // vertical, move down 10
        ),
      )
    ]
    ..progressColor = AppColor.themeColor
    ..backgroundColor = Colors.white
    ..indicatorColor = AppColor.themeColor
    ..textColor = Colors.black
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.white10
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Assignment',
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(builder: (context, child) {
          EasyLoading.init();
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Center(child: child),
          );
        }),
        theme: ThemeData(
          fontFamily: "Roxborough CF",
          colorScheme:
              ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade900),
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
