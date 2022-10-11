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
                color: Color.fromARGB(255, 233, 233, 232),
                borderRadius: BorderRadius.circular(10),
              ),
              //child: Text('Entry ${entries[index]}'),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          height: 72.0,
                          width: 72.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('lib/images/amazon_coffee.jpg'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                        ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text("Amazon Coffee",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text("2.23\$",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ],
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
