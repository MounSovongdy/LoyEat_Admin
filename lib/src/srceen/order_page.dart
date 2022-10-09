
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:loyeat_admin/src/srceen/order_page_detail.dart';

import 'marchants_srceen.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: body,
    );
  }

  final appbar = AppBar(
    title: const Text('Order Page'),
  );

  Widget get body{
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              width: 350,
              height: 150,
              child: RaisedButton(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderPageDetail()),
                  );
                },
                color: Colors.blue,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Text(
                  "Amazon Cofe (Bak Tuk)",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              width: 350,
              height: 150,
              child: RaisedButton(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderPageDetail()),
                  );
                },
                color: Colors.yellow,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Text(
                  "Amazon Cofe (Bak Tuk)",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              width: 350,
              height: 150,
              child: RaisedButton(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderPageDetail()),
                  );
                },
                color: Colors.red,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Text(
                  "Amazon Cofe (Bak Tuk)",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              width: 350,
              height: 150,
              child: RaisedButton(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderPageDetail()),
                  );
                },
                color: Colors.blue,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Text(
                  "Amazon Cofe (Bak Tuk)",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              width: 350,
              height: 150,
              child: RaisedButton(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderPageDetail()),
                  );
                },
                color: Colors.yellow,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Text(
                  "Amazon Cofe (Bak Tuk)",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              width: 350,
              height: 150,
              child: RaisedButton(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderPageDetail()),
                  );
                },
                color: Colors.red,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Text(
                  "Amazon Cofe (Bak Tuk)",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}