import 'package:assignment_flutter/controllers/home_controller.dart';
import 'package:assignment_flutter/services/api_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/app_colors.dart';

class BookTicketScreen extends StatelessWidget {
   BookTicketScreen({super.key});
  final _controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book Ticket"),),
      
      /*
     Customer Name

Customer Email
ID Customer
Contact No.
Movie Title
No. Of tickets required Date/Time Slot
      * */
      body:  Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.cyan,
              width: Get.width,
              height: 300,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Obx(
                    () => CachedNetworkImage(
                  imageUrl:
                  "${ApiConstants.imageUrl}${_controller.model.value?.belongsToCollection?.posterPath}",
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 120,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return const SizedBox(
                      width: 120,
                      height: 140,
                      child: Center(
                        child: SizedBox(
                          width: 10,
                          height: 10,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColor.themeColor),
                            strokeWidth: 3.5,
                          ),
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      width: 120,
                      height: 140,
                      color: AppColor.themeColor,
                      child: const Icon(Icons.error),
                    );
                  },
                ),
              ),
            ),
            Obx(()=> Text(_controller.model.value?.title??"",
              style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)),
            const SizedBox(height: 20,),
            const Text("User Name",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
            const SizedBox(height: 10,),
            TextFormField(
              //  controller: _controller.password,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                focusColor: Colors.white,
                //add prefix icon
                prefixIcon: const Icon(
                  Icons.person,
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
                hintText: "Enter user name",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            const Text("Email",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
            const SizedBox(height: 10,),
            TextFormField(
              //  controller: _controller.password,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                focusColor: Colors.white,
                //add prefix icon
                prefixIcon: const Icon(
                  Icons.person,
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
              ),
            ),
            const SizedBox(height: 10,),
            const Text("Contact No.",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
            const SizedBox(height: 10,),
            TextFormField(
              //  controller: _controller.password,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                focusColor: Colors.white,
                //add prefix icon
                prefixIcon: const Icon(
                  Icons.person,
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
                hintText: "Enter Contact No.",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 10,),
           /* Row(
              children: [
                Column(
                  children: [
                    const Text("Contact No.",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                    const SizedBox(height: 10,),
                    TextFormField(
                      //  controller: _controller.password,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        //add prefix icon
                        prefixIcon: const Icon(
                          Icons.person,
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
                        hintText: "Enter Contact No.",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Contact No.",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15),),
                    const SizedBox(height: 10,),
                    TextFormField(
                      //  controller: _controller.password,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        //add prefix icon
                        prefixIcon: const Icon(
                          Icons.person,
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
                        hintText: "Enter Contact No.",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )*/




          ],
        ),
      ),
    );
  }
}
