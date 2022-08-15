import 'package:flutter/material.dart';
import 'package:loyeat_admin/src/widget/bottom_app_bar_widget.dart';
import 'package:loyeat_admin/src/widget/button_submit-widget.dart';
import 'package:loyeat_admin/src/widget/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LandingScreen extends StatelessWidget {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
      
        get customer_name => null;

  // ignore: non_constant_identifier_names

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
      children: [
        text_field,
        button_submit,
        //TextFieldWidget(),
      ],
    );
  }

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
          await customers.add({'customer_name': customer_name}).then(
              (value) => print('Added'));
        },
        child: const Text('Submit'),
      ),
    );
  }
}
