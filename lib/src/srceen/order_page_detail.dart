// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:loyeat_admin/src/srceen/order_srceen.dart';

class OrderPageDetail extends StatefulWidget {
  const OrderPageDetail({Key? key}) : super(key: key);

  @override
  State<OrderPageDetail> createState() => _OrderPageDetailState();
}

class _OrderPageDetailState extends State<OrderPageDetail> {
  @override

 final List<String> menu = <String>['Amazon Cafe','Amazon Extra', 'Black Tea','Mocha', 'Cappucino', 'Cafe latie','Chocolate', 'Honey Black Tea', 'Green Tea'];
 final List<double> price = <double>[1.5,2.30,1.80,2.50,2.00,1.86,2.00,2.20,2.30];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: body,
      backgroundColor: const Color.fromARGB(255, 199, 199, 198),
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
      itemCount: 9,
      itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
              height: 80,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(10),
              ),
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
                        child: Text('${menu[index]}',style: const TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Text('\$${price[index]}',style: const TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderSrceen()),
                );
              });
            },
          );
        },
    );
  }
}
