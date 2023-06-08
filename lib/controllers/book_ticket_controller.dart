import 'package:assignment_flutter/services/models/bookingModel.dart';
import 'package:assignment_flutter/services/models/date_model.dart';
import 'package:assignment_flutter/utills/app_utills.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookTicketController extends GetxController{
  Rxn<DateTime> selectedDate =Rxn(DateTime.now());
  late SharedPreferences _sharedPreferences;
  var position =-1;
  var alreadyBooked =0.obs;
  RxList<SlotModel> slotList = RxList();
  RxList<BookingModel> bookingList = RxList();
  late TextEditingController userName,email,contactNumber, date, totalPeople;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    _sharedPref();
    _initControllers();
    loadItems();
    getBookingData();
    super.onInit();
  }
  _sharedPref()async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  _initControllers(){
    userName = TextEditingController();
    email = TextEditingController();
    contactNumber = TextEditingController();
    date = TextEditingController();
    totalPeople = TextEditingController();
  }
  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value!,
        firstDate: DateTime.now(),
        lastDate: DateTime(2024),
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter valid date range',
        fieldHintText: 'Month/Date/Year',
      );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      date.text= DateFormat('dd MMM yyyy').format(selectedDate.value!);

    }
  }
  loadItems() {
  DateTime time = DateTime.now();
    List<SlotModel> newItems = [
      SlotModel(
         isSelected: false,
         time: DateTime(time.year, time.month, time.day, 15, 0),
    ),
      SlotModel(
        isSelected: false,
        time: DateTime(time.year, time.month, time.day, 13, 0),
      ),
      SlotModel(
        isSelected: false,
        time: DateTime(time.year, time.month, time.day, 20, 0),
      ),

    ];
    slotList.clear();
    slotList.refresh();
    slotList.assignAll(newItems);
    slotList.refresh();
  }

  selectSlot(int index) {
    position = index;
    for (int i = 0; i < slotList.length; i++) {
      if (i == position) {
        slotList[i].isSelected = true;
      } else {
        slotList[i].isSelected = false;
      }
    }
    slotList.refresh();
  }

  createBooking(Map<String,dynamic> bookingDetails){
    bookingDetails["user_id"] = _sharedPreferences.getString("user_id");
    print(bookingDetails.toString());
    _firebaseFirestore.collection('bookings').add(bookingDetails)
        .then((value) {
      print('Booking details saved with ID: ${value.id}');
      Get.back();
      Utils.sucessSnackBar("Booking done successfully");
    }).catchError((error) {
      Utils.errorSnackBar("Something went wrong please later");
      print('Error saving booking details: $error');
    });
  }


  getBookingData(){
    _firebaseFirestore.collection('bookings').get()
        .then((QuerySnapshot snapshot) {
      for (var document in snapshot.docs) {
        bookingList.clear();
        bookingList.add(BookingModel.fromJson(document.data()));
        bookingList.refresh();
        print(document.data());
      }
    })
        .catchError((error) {
      print('Error retrieving booking data: $error');
    });
  }
}