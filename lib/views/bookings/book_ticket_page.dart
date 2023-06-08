import 'package:assignment_flutter/controllers/book_ticket_controller.dart';
import 'package:assignment_flutter/controllers/home_controller.dart';
import 'package:assignment_flutter/services/api_constant.dart';
import 'package:assignment_flutter/utills/app_utills.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../auth/app_colors.dart';

class BookTicketScreen extends StatelessWidget {
  BookTicketScreen({super.key});

  final _controller = Get.put(HomeController());
  final _bookingController = Get.put(BookTicketController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Ticket"),
        centerTitle: true,
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Obx(
            ()=> Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    color: Colors.cyan,
                    width: Get.width/2,
                    height: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: CachedNetworkImage(
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
                Text(
                      _controller.model.value?.title ?? "",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "User Name",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _bookingController.userName,
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
                    contentPadding: const EdgeInsets.all(8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0),
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
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _bookingController.email,
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
                    contentPadding: const EdgeInsets.all(8),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0),
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
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Contact No.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _bookingController.contactNumber,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    //add prefix icon
                    prefixIcon: const Icon(
                      Icons.call,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: const EdgeInsets.all(8),
                    // Added this
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0),
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
                const SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Date",
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onTap: () {
                              _bookingController.chooseDate();
                            },
                            enableInteractiveSelection: true,
                            enabled: true,
                            readOnly: true,
                            controller: _bookingController.date,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              //add prefix icon
                              prefixIcon: const Icon(
                                Icons.calendar_month,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: const EdgeInsets.all(8),
                              // Added this
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.grey,
                              hintText: "Select Date",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const Text(
                          "No. of Tickets",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 50,
                          child: TextFormField(
                            controller: _bookingController.totalPeople,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            decoration: InputDecoration(
                              focusColor: Colors.white,

                              //add prefix icon
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: const EdgeInsets.all(8),
                              // Added this
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: Colors.grey,
                              hintText: "2",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Time",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
               Wrap(
             spacing: 10.0,
             children: [
               ...List.generate(_bookingController.slotList.length, (index) {
                 var data = _bookingController.slotList[index];
                 return ActionChip(
                   label: Text(DateFormat('h:mm a').format(data.time!)),
                   onPressed: () {




                     _bookingController.selectSlot(index);
                     _bookingController.slotList.refresh();
                     bool isBooked = false;
                     int status = 0;
                     for(var item in _bookingController.bookingList.value){
                       if(item.timeSlot == DateFormat('HH:mm').format(data.time!) && item.bookingDate == DateFormat("yyyy-MM-dd").format(_bookingController.selectedDate.value!)){
                         isBooked = true;
                       }else{
                         isBooked = false;
                       }
                       debugPrint(isBooked.toString());
                       if(isBooked) {
                         status++;
                       }
                     }
                     if(status!=0)
                     {
                       _bookingController.alreadyBooked.value = 1;
                       Utils.errorSnackBar("Already have booking with this date and time");
                     }
                     else{
                       _bookingController.alreadyBooked.value =0;
                     }
                   },
                   backgroundColor:data.isSelected==true?AppColor.themeColor:Colors.white ,
                 );

               }),

             ],
           ),
                const SizedBox(height: 40,),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: Get.width/2,
                      child: ElevatedButton(
                          style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.themeColor),),
                          onPressed: (){
                            DateTime ? date ;
                            for(var item in _bookingController.slotList.value){
                              if(item.isSelected==true){
                                date = item.time!;
                              }
                            }
                            if(_bookingController.userName.text.trim().isEmpty){
                              Utils.errorSnackBar("Please enter user name");
                            }else if(_bookingController.email.text.trim().isEmpty){
                              Utils.errorSnackBar("Please enter email");
                            }else if(_bookingController.contactNumber.text.trim().isEmpty){
                              Utils.errorSnackBar("Please enter contact number");
                            }else if(_bookingController.date.text.trim().isEmpty){
                              Utils.errorSnackBar("Please enter booking date");
                            }else if(_bookingController.totalPeople.text.trim().isEmpty){
                              Utils.errorSnackBar("Please enter no of tickets");
                            }else if(_bookingController.totalPeople.text.trim().isEmpty){
                              Utils.errorSnackBar("Please enter no of tickets");
                            }else if(date == null){
                              Utils.errorSnackBar("Please select time slot");
                            }else if(_bookingController.alreadyBooked.value ==1){
                              Utils.errorSnackBar("You already have booking for this date and time");
                            }else{
                              Map<String, dynamic> bookingDetails = {
                                'movie_name': _controller.model.value?.title??"",
                                'booking_date': DateFormat("yyyy-MM-dd").format(_bookingController.selectedDate.value!),
                                'user_name': _bookingController.userName.text,
                                'email': _bookingController.email.text,
                                'contact': _bookingController.contactNumber.text,
                                'total_tickets': _bookingController.totalPeople.text,
                                'time_slot':DateFormat('HH:mm').format(date),
                                'createAt': FieldValue.serverTimestamp(),
                              };

                              _bookingController.createBooking(bookingDetails);
                            }
                          },
                          child: const Text("Book",
                            style: TextStyle(color: Colors.white,fontSize: 16),))),
                ),
                const SizedBox(height: 50,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
