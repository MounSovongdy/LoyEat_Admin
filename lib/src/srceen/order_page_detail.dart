import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyeat_admin/src/controller/order_page_detail_controller.dart';
import 'package:loyeat_admin/src/controller/remote_data.dart';
import 'package:loyeat_admin/src/srceen/view_order_item_screen.dart';

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
      appBar: AppBar(
        title: Text(controller.merchantName.value),
        actions: [
          controller.showOrder.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    Get.to(() => const ViewOrderItemScreen());
                  },
                  icon: const Icon(Icons.shopping_cart))
              : const SizedBox(),
        ],
      ),
      body: body,
      backgroundColor: const Color.fromARGB(255, 199, 199, 198),
    );
  }

  Widget get body {
    return Obx(() {
      final productNameStatus = controller.productNameData.status;
      final productPriceStatus = controller.productPriceData.status;

      if (productNameStatus == RemoteDataStatus.processing &&
          productPriceStatus == RemoteDataStatus.processing) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (productNameStatus == RemoteDataStatus.error &&
          productPriceStatus == RemoteDataStatus.error) {
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
                                image:
                                    AssetImage('assets/image/amazon_coffee.jpg'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Text('${controller.listProductName[index]}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Text('\$${controller.listProductPrice[index]}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  controller.loadProductID(controller.listProductName[index]);
                  controller.proPrice.value =
                      controller.listProductPrice[index];
                  showBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return _buildBottomSheet(
                            controller.listProductName[index]);
                      });
                });
              },
            );
          },
        );
      }
    });
  }

  Widget _buildBottomSheet(String title) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Center(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
                onPressed: () {
                  controller.decrementCounter();
                },
                icon: const Icon(Icons.remove),
              ),
              Obx(
                () => Text('${controller.count}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              IconButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
                onPressed: () {
                  controller.incrementCounter();
                },
                icon: const Icon(Icons.add),
              ),
            ]),
          ),
          const Spacer(),
          SizedBox(
            width: 400,
            // ignore: deprecated_member_use
            child: RaisedButton(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              onPressed: () {
                Navigator.pop(context);

                controller.qty.value = controller.count.value;
                controller.count.value = 1;

                // for firebase
                controller.mapProduct = {
                  'product_id': controller.proId.value,
                  'qty': '${controller.qty.value}'
                };
                controller.listOrder.add(controller.mapProduct);

                // for show report
                controller.showProduct = {
                  'product_name': title,
                  'qty': controller.qty.value,
                  'product_price': controller.proPrice.value
                };
                controller.showOrder.add(controller.showProduct);

                debugPrint('listOrder: ${controller.listOrder}');

                setState(() {});
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
        ],
      ),
    );
  }
}
