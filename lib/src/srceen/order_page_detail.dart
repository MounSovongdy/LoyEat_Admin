import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyeat_admin/src/controller/order_page_detail_controller.dart';
import 'package:loyeat_admin/src/controller/remote_data.dart';
import 'package:loyeat_admin/src/srceen/order_srceen.dart';

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderSrceen()),
                  );
                });
              },
            );
          },
        );
      }
    });
  }
}
