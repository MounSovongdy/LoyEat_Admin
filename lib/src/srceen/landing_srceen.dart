import 'package:flutter/material.dart';
import 'package:loyeat_admin/src/widget/bottom_app_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  final customerName = TextEditingController();
  final customerId = TextEditingController();
  final customerRating = TextEditingController();
  final merchantName = TextEditingController();
  final merchantId = TextEditingController(); 
  final merchantRating = TextEditingController();
  final orderId = TextEditingController();
  final orderTime = TextEditingController();
  final orderDate = TextEditingController();
  final distance = TextEditingController();
  final deliveryFee= TextEditingController();
  

  CollectionReference customers = FirebaseFirestore.instance.collection('customers');
  CollectionReference merchants = FirebaseFirestore.instance.collection('merchants');
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
        textEditingController(controller: customerName,labletext: 'Customer Name'),
        textEditingController(controller: customerId,labletext: 'Customer ID'),
        textEditingController(controller: customerRating,labletext: 'Customer Rating'),
        textEditingController(controller: merchantName,labletext: 'Merchant Name'),
        textEditingController(controller: merchantId,labletext: 'Merchant ID'),
        textEditingController(controller: merchantRating,labletext: ' Merchant Rating'),
        textEditingController(controller: orderId,labletext: 'Order ID'),
        textEditingController(controller: orderTime,labletext: 'Order Time'),
        textEditingController(controller: orderDate,labletext: 'Order Date'),
        textEditingController(controller: distance,labletext: 'Distance'),
        textEditingController(controller: deliveryFee,labletext: 'Delivery Fee'),
        buttonSubmit,
      ],
    );
  }

  Widget textEditingController({required TextEditingController controller, required String labletext}){
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child:  TextField(
              controller: controller,
              obscureText: false,
              decoration:  InputDecoration(
                border: const OutlineInputBorder(),
                labelText: labletext,
              ),
              onSubmitted: (value) {
                controller.text = value;
              },
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
            'customer_name': customerName.text,
            'customer_id' : customerId.text,
            'marchant_name' : merchantName.text,
            'marchant_id' : merchantId.text,
            }).then((value)=> print(' Customer Added'));

            await merchants.add({
            'marchant_name' : merchantName.text,
            'marchant_id' : merchantId.text,
            }).then((value)=> print(' Merchant Added'));

            await delivers.add({
            'customer_rating' : customerRating.text,
            'marchant_rating' : merchantRating.text,
            'order_id' : orderId.text,
            'distance' : distance.text,
            'delivery_fee' : deliveryFee.text,
            'order_date' : orderDate.text,
            'order_time' : orderTime.text,
            }).then((value)=> print(' Deliver Added'));
        },
        child: 
          const Text('Submit'),
      ),
    );
  }
}



