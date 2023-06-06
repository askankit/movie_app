import 'package:assignment_flutter/controllers/auth_controller.dart';
import 'package:assignment_flutter/generated/assets.dart';
import 'package:assignment_flutter/utills/app_utills.dart';
import 'package:assignment_flutter/views/auth/app_colors.dart';
import 'package:assignment_flutter/views/auth/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatelessWidget {
   SignInScreen({super.key}){
     _controller.reset();
   }
   final _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              children: [
                Align(
                  child: Lottie.asset(Assets.jsonsLogin, height: 300),
                ),
                TextFormField(
                  controller: _controller.email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    //add prefix icon
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.grey,
                    hintText: "Enter email",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),

                    labelText: 'Email',

                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _controller.password,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    //add prefix icon
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.grey,
                    hintText: "Enter Password",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: Get.width/2,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_controller.email.text.trim().isEmpty){
                        Utils.errorSnackBar("Enter email");
                      }else if(!Utils.emailValidation(_controller.email.text.trim())){
                        Utils.errorSnackBar("Enter password");
                      }else if(_controller.password.text.trim().isEmpty){
                        Utils.errorSnackBar("Enter password");
                      }else{
                        _controller.login();
                      }
                    },
                    style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.themeColor),),
                    child: const Text("log in",style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),),

                  ),
                ),
                const SizedBox(height: 50,),
                 Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(text: "Don't have an account",style: TextStyle(
                          fontSize: 16,
                        fontWeight: FontWeight.w300,
                      )),
                      TextSpan(text: "  Sing up  ",
                          recognizer: TapGestureRecognizer()..onTap = () => Get.to(()=> SignUpScreen()),
                          style: const TextStyle(
                        color: AppColor.themeColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.themeColor,
                        fontWeight: FontWeight.w600,fontSize: 16
                      ) ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
