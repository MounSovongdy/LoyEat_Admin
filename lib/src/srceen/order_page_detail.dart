// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class OrderPageDetail extends StatefulWidget {
  const OrderPageDetail({Key? key}) : super(key: key);

  @override
  State<OrderPageDetail> createState() => _OrderPageDetailState();
}

class _OrderPageDetailState extends State<OrderPageDetail> {
  @override
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C'
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: body,
    );
  }

  final appbar = AppBar(
    title: const Text('Order Page'),
  );

  Widget get body {
    return SingleChildScrollView(
      //padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 350,
              height: 150,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 21, 2),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(8),
              child: const Center(child: Text('Entry A')),
            ),
          ),
          ListView.builder(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 230, 166, 18),
                    borderRadius: BorderRadius.circular(10),
                    //margin: const EdgeInsets.all(8),
                  ),
                  child: Center(child: Text('Entry ${entries[index]}')),
                );
              }),
        ],
      ),
    );
  }
}
