import 'package:assignment_flutter/views/auth/app_colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Utils {

  static sucessSnackBar(String? message) {
    if (message == null) {
      return;
    }
    Get.closeAllSnackbars();
    Get.snackbar(
      "Flutter Assignment",
      message,
      padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top:10,
          bottom:10),
      icon: const Icon(
        Icons.check_circle,
        color: Colors.white,
        size: 30,
      ),
      margin: const EdgeInsets.fromLTRB(10,10,10,10),
      backgroundColor: AppColor.themeColor,
      borderRadius:8,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      titleText: const Text(
        "Flutter Assignment",
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      duration: const Duration(milliseconds: 1000),
      messageText: Text(
        message,
        maxLines: 5,
        textAlign: TextAlign.start,
        style:  const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    );
  }

  static errorSnackBar(String? message) {
    if (message == null) {
      return;
    }
    Get.closeAllSnackbars();
    Get.snackbar(
      "Flutter Assignment",
      message,
      padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top:10,
          bottom:10),
      icon: const Icon(
        Icons.info_outline,
        color: Colors.white,
        size: 30,
      ),
      margin: const EdgeInsets.fromLTRB(
          10,10,10,10),
      backgroundColor: Colors.red,
      borderRadius:8,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      titleText: const Text(
        "Flutter Assignment",
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      duration: const Duration(milliseconds: 1000),
      messageText: Text(
        message,
        maxLines: 5,
        textAlign: TextAlign.start,
        style:  const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    );
  }

  static bool emailValidation(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  static Future<bool> hasNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Utils.errorSnackBar("check your internet connection");
      return false;
    } else {
      return true;
    }
  }






  static showLoader() {
    EasyLoading.show(
        dismissOnTap: false,
        status: "Please wait...");
  }
  static Future hideLoader() async {
    return await EasyLoading.dismiss();
  }
  static void printLog(message) {
    if(kDebugMode){
      debugPrint("=======================================================================");
      debugPrint(message.toString());
      debugPrint("=======================================================================");
    }
  }


}