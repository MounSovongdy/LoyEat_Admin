import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loyeat_admin/src/controller/login_controller.dart';
import 'package:loyeat_admin/src/controller/order_page_detail_controller.dart';
import 'package:loyeat_admin/src/srceen/order_page.dart';

class ViewOrderItemScreen extends StatefulWidget {
  const ViewOrderItemScreen({Key? key}) : super(key: key);

  @override
  State<ViewOrderItemScreen> createState() => _ViewOrderItemScreenState();
}

class _ViewOrderItemScreenState extends State<ViewOrderItemScreen> {
  final controller = Get.put(OrderPageDetailController());
  final loginController = Get.put(LoginController());

  final orderCollection = FirebaseFirestore.instance.collection('orders');
  final delivers = FirebaseFirestore.instance.collection('delivers');
  final orders = FirebaseFirestore.instance.collection('orders');
  final orderDetail = FirebaseFirestore.instance.collection('orders_detail');

  String? today;
  String? time;
  String? orderId;
  String? orderDate;

  loadLastOrderID() async {
    await orderCollection.where('date', isEqualTo: today).get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var data in value.docs) {
          final lastID = data['order_id'];
          var newID = int.parse(lastID) + 1;
          debugPrint('newID: $newID');
          setState(() {
            orderId = newID.toString();
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
              child:
                  const Icon(Icons.arrow_back_ios_sharp, color: Colors.black)),
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
                  'Customer name', loginController.customerName.value)),
              Obx(() => buildTextValue(
                  'Merchant name', controller.merchantName.value)),
              buildListItems,
            ],
          ),
        ),
        bottomSheet: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 50),
          child: RaisedButton(
            // ignore: deprecated_member_use
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            onPressed: () async {
              await orders.add({
                'customer_id': loginController.customerId.value,
                'customer_name': loginController.customerName.value,
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
              }).then((value) {
                Get.off(() => OrderPage());
                controller.showOrder.clear();
                controller.showProduct.clear();
              });
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
