// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:loyeat_admin/src/srceen/order_page_detail.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  final List<String> store = <String>['Cafe Amazon (Bak Tuk)','Ptas Bay Khmer','Sach Ang Pises','Oun KuTeav'];

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

  Widget get body{
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    height: 220,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 233, 232),
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('lib/images/logo_amazon.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Spacer(),
                        Container(
                          height: 64,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text('${store[index]}',style: const TextStyle(fontWeight: FontWeight.bold),),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderPageDetail()),
                );
              });
            },
          );
      },
    );
  }
}