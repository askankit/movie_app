import 'package:assignment_flutter/utills/app_utills.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../views/home/home_screen.dart';

class AuthController extends GetxController {
  late TextEditingController firstName, lastName, email, password;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    _initControllers();
    super.onInit();
  }

  _initControllers() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }

  reset() {
    firstName.clear();
    lastName.clear();
    email.clear();
    password.clear();
  }

  Future<void> login() async {
    if(await Utils.hasNetwork()){
      Utils.showLoader();
      try {
        UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        Utils.hideLoader();
        if(userCredential != null){
          Get.offAll(()=>HomeScreen());
        }
      }on FirebaseAuthException catch (e) {
        Utils.hideLoader();
        if(e.code == 'user-not-found'){
          Utils.errorSnackBar("User not found");
        }else if(e.code == 'wrong-password'){
          Utils.errorSnackBar("Invalid Password");
        }else if(e.code == 'too-many-requests'){
          Utils.errorSnackBar("We have blocked all requests from this device due to unusual activity. Try again later.");
        }else{
          Utils.printLog('Login error: $e');
        }
      }
    }

  }

  Future<void> signUp() async {
    if (await Utils.hasNetwork()) {
      Utils.showLoader();
      try {
        UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim(),
        );
        Utils.hideLoader();
        User? user = userCredential.user;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'firstName': firstName.text.trim(),
            'lastName': lastName.text.trim(),
          }).then((value) => Get.to(() => HomeScreen()));
        }
      } catch (e) {
        Utils.printLog('Sign-up error: $e');
      }
    }
  }
}
