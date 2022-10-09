// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class OrderPageDetail extends StatefulWidget {
  const OrderPageDetail({Key? key}) : super(key: key);

  @override
  State<OrderPageDetail> createState() => _OrderPageDetailState();
}

class _OrderPageDetailState extends State<OrderPageDetail> {
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
    return Container(
      width: 350,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.amber[600],
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(8),
        child: const Center(child: Text('Entry A')),
    );
  }
  Widget get listitem{
    return ListView(
      children: [
              Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: RaisedButton(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
            ],
    );
  }
}