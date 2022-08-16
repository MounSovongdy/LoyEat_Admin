import 'package:flutter/material.dart';
import 'package:loyeat_admin/src/widget/bottom_app_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}
class _LandingScreenState extends State<LandingScreen> {

  String customerName='';
  String customerId='';
  String customerRating='';
  String marchentName='';
  String marchentId='';
  String marchentRating='';
  String orderId='';
  String orderTime='';
  String orderDate='';
  String distance='';
  String deliveryFee='';

  CollectionReference customers = FirebaseFirestore.instance.collection('customers');
  CollectionReference delivers = FirebaseFirestore.instance.collection('delivers');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: body,
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }

  final appbar = AppBar(
    title: const Text('Loy Eat Dashboard'),
  );

  Widget get body {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal:0),
      children: [
        textField(controller: customerName,labletext: 'Customer Name'),
        textField(controller: customerId,labletext: 'Customer ID'),
        textField(controller: customerRating,labletext: 'Customer Rating'),
        textField(controller: marchentName,labletext: 'Marchent Name'),
        textField(controller: marchentId,labletext: 'Marchent ID'),
        textField(controller: marchentRating,labletext: ' Marchent Rating'),
        textField(controller: orderId,labletext: 'Order ID'),
        textField(controller: orderTime,labletext: 'Order Time'),
        textField(controller: orderDate,labletext: 'Order Date'),
        textField(controller: distance,labletext: 'Distance'),
        textField(controller: deliveryFee,labletext: 'Delivery Fee'),
        buttonSubmit,
      ],
    );
  }

  Widget textField({required String controller, required String labletext}){
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child:  TextField(
              obscureText: false,
              decoration:  InputDecoration(
                border: const OutlineInputBorder(),
                labelText: labletext,
              ),
              onChanged: (value) {
                controller = value;
              }
            ),
        ),
      ]
    );
  }

  Widget get buttonSubmit{
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 8),
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),

        onPressed: () async {
          await customers.add({
            'customer_name': customerName,
            'customer_id' : customerId,
            // 'customer_rating' : customerRating,
            // 'marchent_name' : marchentName,
            // 'marchent_id' : marchentId,
            // 'marchent_rating' : marchentRating,
            // 'order_id' : orderId,
            // 'order_time' : orderTime,
            // 'order_date' : orderDate,
            // 'distance' : distance,
            // 'delivery_fee' : deliveryFee,
            }).then((value)=> print('Added'));

            await delivers.add({
            // 'customer_name': customerName,
            // 'customer_id' : customerId,
            'customer_rating' : customerRating,
            // 'marchent_name' : marchentName,
            // 'marchent_id' : marchentId,
            // 'marchent_rating' : marchentRating,
            'order_id' : orderId,
            //'order_time' : orderTime,
            'date' : orderDate,
            'distance' : distance,
            'delivery_fee' : deliveryFee,
            }).then((value)=> print('Added'));
        },
        child: 
          const Text('Submit'),
      ),
    );
  }
}
