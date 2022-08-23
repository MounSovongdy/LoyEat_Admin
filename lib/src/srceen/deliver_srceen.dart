// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:loyeat_admin/src/widget/bottom_app_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliverSrceen extends StatefulWidget {
  const DeliverSrceen({Key? key}) : super(key: key);

  @override
  State<DeliverSrceen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<DeliverSrceen> {
  
  final orderId = TextEditingController();
  final orderTime = TextEditingController();
  final orderDate = TextEditingController();
  final period = TextEditingController(); 
  final bonus = TextEditingController();
  final tip = TextEditingController();
  final distance = TextEditingController();
  final deliveryFee = TextEditingController();

  CollectionReference delivers =
      FirebaseFirestore.instance.collection('delivers');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: body,
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }

  final appbar = AppBar(
    title: const Text('Deliver Page'),
  );

  Widget get body {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      children: [
        textEditingController(controller: orderId, labletext: 'Order ID'),
        textEditingController(controller: orderTime, labletext: 'Order Time'),
        textEditingController(controller: orderDate, labletext: 'Order Date'),
        textEditingController(controller: period, labletext: 'Order Period'),
        textEditingController(controller: bonus, labletext: 'Bonus'),
        textEditingController(controller: tip, labletext: 'Tip'),
        textEditingController(controller: distance, labletext: 'Distance'),
        textEditingController(controller: deliveryFee, labletext: 'Delivery Fee'),
        buttonSubmit,
      ],
    );
  }

  Widget textEditingController(
      {required TextEditingController controller, required String labletext}) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: TextField(
          controller: controller,
          obscureText: false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labletext,
          ),
          onSubmitted: (value) {
            controller.text = value;
          },
        ),
      ),
    ]);
  }

  Widget get buttonSubmit {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 400,
              child: RaisedButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                //onPressed for insert to firestore
                onPressed: () async {
                  await delivers.add({
                  
                    'order_id': orderId.text,
                    'distance': distance.text,
                    'delivery_fee': deliveryFee.text,
                    'order_date': orderDate.text,
                    'order_time': orderTime.text,
                  }).then((value) => alert());

                  //clear text from testfeild
                  
                  orderId.clear();
                  distance.clear();
                  deliveryFee.clear();
                  orderDate.clear();
                  orderTime.clear();
                },
                color: Colors.blue,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Text(
                  "Submit Data",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void alert (){
    const snackBar = SnackBar(
            content: Text('Order Added'),
          );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
