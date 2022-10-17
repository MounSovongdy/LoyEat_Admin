import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyeat_admin/src/controller/save_login_controller.dart';
import 'package:loyeat_admin/src/srceen/order_screen.dart';

class LoginController extends GetxController{
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  var customerId = ''.obs;
  var customerName = ''.obs;

  final customer = FirebaseFirestore.instance.collection('customers');
  final saveLogin = Get.put(SaveLoginController());

  void submit() {
    customer.where('tel', isEqualTo: phoneNumber.text).get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          customerId.value = element['customer_id'];
          customerName.value = element['customer_name'];

          saveLogin.writeCustomerId(customerId.value);
          saveLogin.writeCustomerName(customerName.value);

          if (password.text == '123') {
            Get.to(() => const OrderScreen());
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