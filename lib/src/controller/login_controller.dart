import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyeat_admin/src/srceen/order_page.dart';

class LoginController extends GetxController{
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  var customerId = ''.obs;
  var customerName = ''.obs;

  final customer = FirebaseFirestore.instance.collection('customers');
  
  void submit() {
    customer.where('tel', isEqualTo: phoneNumber.text).get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          customerId.value = element['customer_id'];
          customerName.value = element['customer_name'];

          if (password.text == '123') {
            Get.off(() => OrderPage());
          }
        }
      }
      else {
        phoneNumber.text = '';
        password.text = '';
      }
    });
  }
}