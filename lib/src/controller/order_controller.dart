import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyeat_admin/src/controller/remote_data.dart';

class OrderController extends GetxController {
  var listDeliveryFee = [];
  var listDistance = [];
  var listStoreName = [];
  var listImage = [];
  var store = ''.obs;

  final merchant = FirebaseFirestore.instance.collection('merchants');
  final merchantData = FirebaseFirestore.instance.collection('merchant_data');

  final _merchant = RemoteData<List>(status: RemoteDataStatus.processing, data: null).obs;
  RemoteData<List> get merchantValue => _merchant.value;

  final _merchantDistance = RemoteData<List>(status: RemoteDataStatus.processing, data: null).obs;
  RemoteData<List> get merchantDistance => _merchantDistance.value;


  void loadMerchantData() {
    listDeliveryFee.clear();
    listDistance.clear();
  listStoreName.clear();
listImage.clear();
    merchant.orderBy('merchant_id').get().then((merchants) {
      for (var data in merchants.docs) {
        listStoreName.add(data['merchant_name']);
        listImage.add(data['image']);
        debugPrint('listStoreName: $listStoreName');
        _merchant.value = RemoteData<List>(
            status: RemoteDataStatus.success, data: listStoreName);
      }
    });

    merchantData.orderBy('merchant_id').get().then((merchantData) {
      for (var data in merchantData.docs) {
        listDeliveryFee.add(data['delivery_fee']);
        listDistance.add(data['distance']);
        _merchantDistance.value = RemoteData<List>(
            status: RemoteDataStatus.success, data: listDistance);
      }
    });
  }
}
