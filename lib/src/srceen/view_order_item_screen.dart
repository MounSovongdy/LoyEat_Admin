import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loyeat_admin/src/controller/order_detail_controller.dart';
import 'package:loyeat_admin/src/controller/save_login_controller.dart';
import 'package:loyeat_admin/src/srceen/order_screen.dart';

class ViewOrderItemScreen extends StatefulWidget {
  const ViewOrderItemScreen({Key? key}) : super(key: key);

  @override
  State<ViewOrderItemScreen> createState() => _ViewOrderItemScreenState();
}

class _ViewOrderItemScreenState extends State<ViewOrderItemScreen> {
  final controller = Get.put(OrderDetailController());
  final saveLogin = Get.put(SaveLoginController());

  final delivers = FirebaseFirestore.instance.collection('delivers');
  final orders = FirebaseFirestore.instance.collection('orders');
  final orderDetail = FirebaseFirestore.instance.collection('orders_detail');

  String? today;
  String? time;
  String? orderId;
  String? orderDate;

  Timer? _timer;
  var startCounter = 58.obs;
  var id = ''.obs;
  var orderDoc = ''.obs;
  var deliverDoc = ''.obs;
  var orderDetailDoc = ''.obs;
  var list = [];

  loadLastOrderID() async {
    await orders.where('date', isEqualTo: today).get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var data in value.docs) {
          final lastID = data['order_id'];
          var newID = int.parse(lastID) + 1;
           list.add(newID);
          setState(() {
            var maxId = list.reduce((value, element) => value > element ? value : element);
            orderId = maxId.toString();
          });
        }
      } else {
        setState(() {
          orderId = '${orderDate}001';
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    controller.customerId.value = saveLogin.readCustomerId();
    controller.customerName.value = saveLogin.readCustomerName();
    debugPrint('view order item : customer name : ${controller.customerName.value}');
    var getCurrentDate = DateTime.now();
    var formatDate = DateFormat('dd-MMM-yy');
    var formatTime = DateFormat('kk:mm a');
    var formatOrder = DateFormat('yyMMdd');
    today = formatDate.format(getCurrentDate);
    time = formatTime.format(getCurrentDate);
    orderDate = formatOrder.format(getCurrentDate);
    loadLastOrderID();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back_ios_sharp, color: Colors.black)),
          backgroundColor: Colors.white,
          title: const Text(
            'Your Order',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(15, 5, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextValue('Order ID', orderId.toString()),
              buildTextValue(
                  'Order date', '${today.toString()} ${time.toString()}'),
              Obx(() => buildTextValue(
                  'Customer name', controller.customerName.value)),
              Obx(() => buildTextValue(
                  'Merchant name', controller.merchantName.value)),
              buildListItems,
            ],
          ),
        ),
        bottomSheet: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 50),
          // ignore: deprecated_member_use
          child: RaisedButton(
            // ignore: deprecated_member_use
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            onPressed: () async {
              closeTimer();
              id.value = orderId.toString();
              await orders.add({
                'customer_id': controller.customerId.value,
                'customer_name': controller.customerName.value,
                'date': today.toString(),
                'driver_id': '',
                'is_new': true,
                'merchant_id': controller.merchantId.value,
                'merchant_name': controller.merchantName.value,
                'order_id': orderId.toString(),
                'time': time.toString(),
                'total_discount': '0.00',
              }).then((value) => debugPrint('added'));
              await delivers.add({
                'bonus': '0.00',
                'customer_rating': '5.0',
                'date': today.toString(),
                'delivery_fee': controller.deliveryFee.value,
                'distance': controller.distance.value,
                'driver_id': '',
                'merchant_rating': '5.0',
                'order_id': orderId.toString(),
                'period': '15',
                'process': '',
                'step_1': false,
                'step_2': false,
                'step_3': false,
                'step_4': false,
                'tip': '0.00',
              }).then((value) => alert());
              await orderDetail.add({
                'order_id': orderId.toString(),
                'items': controller.listOrder,
              }).then((value) {});
              await orderSuccess();
            },
            color: Colors.blue,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: const Text(
              "Confirm Order",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
  void alert() {
    const snackBar = SnackBar(
      content: Text('Order Successfully'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  orderSuccess() {
    debugPrint('customer name: ${controller.customerName.value}');
    Get.offAll(() => const OrderScreen());
    controller.showOrder.clear();
    controller.showProduct.clear();
    startTimer();
  }

  void startTimer() async {
    await loadFirebase();
    const oneSec = Duration(seconds: 1);

    _timer = Timer.periodic(oneSec, (Timer timer) {
      debugPrint('Timer = ${startCounter.value}');
      if (startCounter.value == 0) {
        orders.doc(orderDoc.value).get().then((data) {
          var isNew = data['is_new'];
          debugPrint('isNew: $isNew');
          if (isNew == true) {
            timer.cancel();
            orders.doc(orderDoc.value).delete();
            delivers.doc(deliverDoc.value).delete();
            orderDetail.doc(orderDetailDoc.value).delete();
            debugPrint('Sorry, your order was delete because no driver.');
            orderDeleteAlter();
          }
          else {
            debugPrint('timer cancel');
            timer.cancel();
          }
        });
      }
      else {
        orders.doc(orderDoc.value).get().then((data) {
          var isNew = data['is_new'];
          if (isNew == false) {
            timer.cancel();
            debugPrint('timer cancel');
            debugPrint('isNew: $isNew');
          }
          else {
            startCounter--;
          }
        });

      }
    });
  }
  void closeTimer() {
    debugPrint('timer cancel');
    _timer?.cancel();
    startCounter.value = 58;
  }
  loadFirebase() {
    debugPrint('order id: $id');
    orders.where('order_id', isEqualTo: id.value).get().then((value) {
      for (var data in value.docs) {
        orderDoc.value = data.id;
      }
    });
    delivers.where('order_id', isEqualTo: id.value).get().then((value) {
      for (var data in value.docs) {
        deliverDoc.value = data.id;
      }
    });
    orderDetail.where('order_id', isEqualTo: id.value).get().then((value) {
      for (var data in value.docs) {
        orderDetailDoc.value = data.id;
      }
    });
  }
  void orderDeleteAlter() {
    Get.defaultDialog(
      radius: 5,
      title: '',
      barrierDismissible: false,
      titleStyle: const TextStyle(fontSize: 10),
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(15),
      middleTextStyle: const TextStyle(fontSize: 14),
      middleText: 'Sorry, your order was delete because no driver.',
      textConfirm: 'Confirm',
      confirmTextColor: Colors.white,
      buttonColor: Colors.blueAccent,
      onConfirm: () => Get.back(),
    );
  }

  Widget buildTextValue(String key, String value) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text('$key: '),
          Text(value),
        ],
      ),
    );
  }

  Widget get buildListItems {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Product: '),
          const SizedBox(height: 5),
          Container(
            width: 400,
            height: 150,
            margin: const EdgeInsets.only(left: 10),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.showOrder.length,
              itemBuilder: (context, index) {
                var subTotal = double.tryParse(
                        controller.showOrder[index]['product_price'])! *
                    double.parse(controller.showOrder[index]['qty'].toString());

                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${index + 1}. '),
                      Expanded(
                          flex: 2,
                          child: Text(
                              controller.showOrder[index]['product_name'])),
                      const SizedBox(width: 20),
                      const Text('Qty: '),
                      Expanded(
                          flex: 1,
                          child: Text(
                              controller.showOrder[index]['qty'].toString())),
                      const SizedBox(width: 20),
                      const Text('Sub Total: '),
                      Text('\$ ${subTotal.toStringAsFixed(2)}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
