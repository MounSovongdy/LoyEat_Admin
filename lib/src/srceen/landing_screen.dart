import 'package:flutter/material.dart';
import 'package:loyeat_admin/src/widget/bottom_app_bar_widget.dart';
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';

class LandingScreen extends StatefulWidget {
  LandingScreen({Key? key}) : super(key: key);
=======
import 'package:loyeat_admin/src/widget/button_submit-widget.dart';
import 'package:loyeat_admin/src/widget/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LandingScreen extends StatelessWidget {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
      
        get customer_name => null;

  // ignore: non_constant_identifier_names
>>>>>>> 3e0016b3568312cb79cb69d6396e67e11a655994

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
<<<<<<< HEAD
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
=======
      children: [
        text_field,
        button_submit,
        //TextFieldWidget(),
>>>>>>> 3e0016b3568312cb79cb69d6396e67e11a655994
      ],
    );
  }

<<<<<<< HEAD
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
=======
  Widget get text_field {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: TextField(
              onChanged: (value) {
                String customer_name;
                customer_name = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Customer Name',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get button_submit {
>>>>>>> 3e0016b3568312cb79cb69d6396e67e11a655994
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
<<<<<<< HEAD
          await customers.add({
            'customer_name':customer_name,
            'customer_id' : customer_id,
            }).then((value)=> print('Added'));
        },
        child: 
          const Text('Submit'),
=======
          await customers.add({'customer_name': customer_name}).then(
              (value) => print('Added'));
        },
        child: const Text('Submit'),
>>>>>>> 3e0016b3568312cb79cb69d6396e67e11a655994
      ),
    );
  }
}
