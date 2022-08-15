import 'package:flutter/material.dart';
import 'package:loyeat_admin/src/widget/bottom_app_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LandingScreen extends StatefulWidget {
  LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  // ignore: non_constant_identifier_names
  String customer_name='';
  // ignore: non_constant_identifier_names
  String customer_id='';
  

  CollectionReference customers = FirebaseFirestore.instance.collection('customers');

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
        text_field(controller: customer_name,labletext: 'Customer Name'),
        text_field(controller: customer_id,labletext: 'Customer ID'),
        text_field(controller: customer_name,labletext: 'Customer Rating'),
        text_field(controller: customer_id,labletext: 'Marchent Name'),
        text_field(controller: customer_name,labletext: 'Marchent ID'),
        text_field(controller: customer_id,labletext: ' Marchent Rating'),
        text_field(controller: customer_name,labletext: 'Order ID'),
        text_field(controller: customer_id,labletext: 'Order Time'),
        text_field(controller: customer_name,labletext: 'Order Date'),
        text_field(controller: customer_id,labletext: 'Distance'),
        text_field(controller: customer_name,labletext: 'Delivery Fee'),
        button_submit,
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget text_field({required String controller, required String labletext}){
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
  // ignore: non_constant_identifier_names
  Widget get button_submit{
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
            'customer_name':customer_name,
            'customer_id' : customer_id,
            }).then((value)=> print('Added'));
        },
        child: 
          const Text('Submit'),
      ),
    );
  }
}
