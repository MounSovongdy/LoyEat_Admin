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
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 12,
      itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
              height: 80,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 179, 179, 178),
                borderRadius: BorderRadius.circular(10),
              ),
              //child: Text('Entry ${entries[index]}'),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text("Honey Black Coffee",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: const Text("New Product!!"),
                      ),

                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8),
                      child: const Text("Price: 2.35"),
                    ),
                ],
              ),
            ),
            onTap: () {
              setState(() {
              
              });
            },
          );
        },
    );
  }
}
