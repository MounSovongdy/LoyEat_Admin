import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyeat_admin/src/controller/order_controller.dart';
import 'package:loyeat_admin/src/controller/order_detail_controller.dart';
import 'package:loyeat_admin/src/srceen/order_screen_detail.dart';
import 'package:loyeat_admin/src/srceen/startup_srceen.dart';

import '../controller/remote_data.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final controller = Get.put(OrderController());
  final orderDetailController = Get.put(OrderDetailController());

  @override
  void initState() {
    super.initState();
    controller.loadMerchantData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: body,
      backgroundColor: const Color.fromARGB(255, 199, 199, 198),
    );
  }

  final appbar = AppBar(
    title: const Text('Order Page'),
    leading: InkWell(onTap: () => Get.offAll(const StartUpSrceen()), child: const Icon(Icons.arrow_back_sharp)),
  );

  Widget get body{
    return Obx(() {
      final merchantValueStatus = controller.merchantValue.status;
      final merchantDataStatus = controller.merchantDistance.status;

      if (merchantValueStatus == RemoteDataStatus.processing && merchantDataStatus == RemoteDataStatus.processing) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (merchantValueStatus == RemoteDataStatus.error && merchantDataStatus == RemoteDataStatus.processing) {
        return const Text('Error while loading data from server.');
      } else {
        final name = controller.merchantValue.data!;
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: name.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    height: 220,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 233, 232),
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(controller.listImage[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Spacer(),
                        Container(
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                const Icon(Icons.store_sharp,size: 20),
                                const SizedBox(width: 4),
                                Text(controller.listStoreName[index],style: const TextStyle(fontSize: 12)),
                                const Spacer(),

                                const Icon(Icons.directions_run,size: 20),
                                const SizedBox(width: 2),
                                Text('${controller.listDistance[index]} km',style: const TextStyle(fontSize: 12)),

                                const SizedBox(width: 16),

                                const Icon(Icons.two_wheeler,size: 20),
                                const SizedBox(width: 4),
                                Text('\$ ${controller.listDeliveryFee[index]}',style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  orderDetailController.data.value = true;
                  debugPrint('merchantName: ${controller.listStoreName[index]}, deliveryFee: ${controller.listDeliveryFee[index]}');
                  Get.to(() => const OrderScreenDetail(),
                      arguments: {'merchantName': controller.listStoreName[index],
                        'deliveryFee': controller.listDeliveryFee[index],
                        'distance': controller.listDistance[index],
                      });
                }
            );
          },
        ) ;
      }
    });
  }
}
