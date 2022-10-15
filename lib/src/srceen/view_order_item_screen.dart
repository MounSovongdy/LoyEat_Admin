import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loyeat_admin/src/controller/order_page_detail_controller.dart';

class ViewOrderItemScreen extends StatefulWidget {
  const ViewOrderItemScreen({Key? key}) : super(key: key);

  @override
  State<ViewOrderItemScreen> createState() => _ViewOrderItemScreenState();
}

class _ViewOrderItemScreenState extends State<ViewOrderItemScreen> {

  final controller = Get.put(OrderPageDetailController());
  String? today;

  @override
  void initState() {
    super.initState();
    var getCurrentDate = DateTime.now();
    var format = DateFormat('dd-MMM-yy');
    today = format.format(getCurrentDate);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              buildTextValue('Order date', today.toString()),
              Obx(() => buildTextValue('Merchant name', controller.merchantName.value)),
              listItems(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextValue(String key, String value) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text('$key: '),
          Text(value),
        ],
      ),
    );
  }
  Widget listItems() {
    return Row(
      children: [
        const Text('Product'),
        ListView.builder(
          itemCount: controller.listOrder.length,
          itemBuilder: (context, index){
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Product name: '),
                Text(controller.listOrder[index]['product_id']),
                SizedBox(width: 20),
                Text('qty: '),
                Text(controller.listOrder[index]['qty']),
              ],
            );
          },
        ),
      ],
    );
  }
}
