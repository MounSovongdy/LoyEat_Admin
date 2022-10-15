import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderPageController extends GetxController{

  var listDeliveryFee = ['0.75', '0.50'];
  var listDistance = ['1.50', '2.50'];
  var listStoreName = [];
  var store = ''.obs;

  final merchant = FirebaseFirestore.instance.collection('merchants');

  void loadMerchantData() {
    merchant.orderBy('merchant_id').get().then((merchants){
      for (var data in merchants.docs) {
        listStoreName.add(data['merchant_name']);
        debugPrint('listStoreName: $listStoreName');
      }
    });
  }
}