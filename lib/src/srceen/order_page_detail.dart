// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyeat_admin/src/controller/order_page_detail_controller.dart';
import 'package:loyeat_admin/src/controller/remote_data.dart';
import 'package:loyeat_admin/src/srceen/order_srceen.dart';

import 'customer_srceen.dart';

class OrderPageDetail extends StatefulWidget {
  const OrderPageDetail({Key? key}) : super(key: key);

  @override
  State<OrderPageDetail> createState() => _OrderPageDetailState();
}

class _OrderPageDetailState extends State<OrderPageDetail> {
  final controller = Get.put(OrderPageDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.merchantName.value)),
      body: body,
      backgroundColor: const Color.fromARGB(255, 199, 199, 198),
    );
  }

  Widget get body {
    return  Obx(() {
      final productNameStatus = controller.productNameData.status;
      final productPriceStatus = controller.productPriceData.status;

      if (productNameStatus == RemoteDataStatus.processing && productPriceStatus == RemoteDataStatus.processing) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (productNameStatus == RemoteDataStatus.error && productPriceStatus == RemoteDataStatus.error) {
        return const Text('Error while loading data from server.');
      } else {
        final name = controller.productNameData.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: name.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                height: 80,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
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
                          child: Text('${controller.listProductName[index]}',style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Text('\$${controller.listProductPrice[index]}',style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  showBottomSheet(context: context, builder: _buildBottomSheet);
                });
              },
            );
          },
        );
      }
    });
  }
  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          const Center(child: Text('Green Tea latte',style: TextStyle(fontWeight: FontWeight.bold))),
          // Padding(
          //   padding: const EdgeInsets.all(32),
          //   child: Container(
          //     width: 100,
          //     height: 40.0, 
          //     child: Row(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(4),
          //           child: RaisedButton(
          //             child: const Text('-'),
          //           onPressed: () {

          //           },
          //           ),
          //         ),
          //         Spacer(),
          //         Padding(
          //           padding: const EdgeInsets.all(4),
          //           child: RaisedButton(
          //             child: const Text('+'),
          //           onPressed: () {

          //           },
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          const Spacer(),
          Container(
            child: SizedBox(
                width: 400,
                child: RaisedButton(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CustomerScreen()),
                    );
                  }, 
                  color: Colors.blue,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Text(
                    "Add To Cart",
                    style: TextStyle(
                      color: Colors.white, 
                    ),
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
