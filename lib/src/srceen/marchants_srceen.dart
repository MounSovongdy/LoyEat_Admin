// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyeat_admin/src/controller/order_page_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MarchantsSrceen extends StatefulWidget {
  const MarchantsSrceen({Key? key}) : super(key: key);

  @override
  State<MarchantsSrceen> createState() => _MarchantsSrceenState();
}

class _MarchantsSrceenState extends State<MarchantsSrceen> {
  final merchantName = TextEditingController();
  final merchantId = TextEditingController();
  final createAt = TextEditingController();
  final tel = TextEditingController();
  final location = TextEditingController();
  final latitude = TextEditingController();
  final longitude = TextEditingController();
  final image = TextEditingController();

  final controller = Get.put(OrderPageController());

  CollectionReference merchants =
      FirebaseFirestore.instance.collection('merchants');

        CollectionReference merchantData =
      FirebaseFirestore.instance.collection('merchant_data');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: body,
      //bottomNavigationBar: const BottomAppBarWidget(),
    );
  }

  final appbar = AppBar(
    title: const Text('Merchant Page'),
  );

  Widget get body {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      children: [
        textEditingController(
            controller: merchantId,
            labletext: 'Merchant ID',
            suffixIcon: GestureDetector(
                onTap: () => {}, child: const Icon(Icons.key_rounded))),
        textEditingController(
            controller: merchantName,
            labletext: 'Merchant Name',
            suffixIcon: GestureDetector(
                onTap: () => {}, child: const Icon(Icons.store))),
        textEditingController(
            controller: tel,
            labletext: 'Telephone',
            suffixIcon: GestureDetector(
                onTap: () => {}, child: const Icon(Icons.phone))),
        textEditingController(
          controller: createAt,
          labletext: 'Create Date',
          suffixIcon: GestureDetector(
              onTap: () async {
                DateTime? pickerDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickerDate != null) {
                  setState(() {
                    createAt.text =
                        DateFormat('dd-MMM-yy').format(pickerDate);
                  });
                }
              },
              child: const Icon(Icons.calendar_month_rounded)),
        ),
        textEditingController(
            controller: location,
            labletext: 'Location',
            suffixIcon: GestureDetector(
                onTap: () => {}, child: const Icon(Icons.map_rounded))),
        textEditingController(
            controller: latitude,
            labletext: 'Latitude',
            suffixIcon: GestureDetector(
                onTap: () => {}, child: const Icon(Icons.pin_drop_rounded))),
        textEditingController(
            controller: longitude,
            labletext: 'Longitude',
            suffixIcon: GestureDetector(
                onTap: () => {}, child: const Icon(Icons.pin_drop_rounded))),
        textEditingController(
            controller: image,
            labletext: 'Image',
            suffixIcon: GestureDetector(
                onTap: () => {}, child: const Icon(Icons.image_rounded))),
        buttonSubmit,
      ],
    );
  }

  Widget textEditingController({
    required TextEditingController controller,
    required String labletext,
    Widget? suffixIcon,
  }) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: TextField(
          controller: controller,
          obscureText: false,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            border: const OutlineInputBorder(),
            labelText: labletext,
          ),
          onSubmitted: (value) {
            controller.text = value;
          },
        ),
      ),
    ]);
  }

  Widget get buttonSubmit {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 400,
              child: RaisedButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                //onPressed for insert to firestore
                onPressed: () async {
                  await merchants.add({
                    'merchant_id': merchantId.text,
                    'merchant_name': merchantName.text,
                    'tel': tel.text,
                    'create_at': createAt.text,
                    'location': location.text,
                    'position': GeoPoint(double.parse(latitude.text),
                        double.parse(longitude.text)),
                    'image': 'assets/image/${image.text}',
                  }).then((value) {
                    debugPrint('merchant added');
                  });

                    await merchantData.add({
                    'merchant_id': merchantId.text,
                    'delivery_fee': '1.25',
                    'distance': '5.50',
                  }).then((value) {
                    debugPrint('merchant added');
                  });

                  //clear text from testfeild
                  merchantId.clear();
                  merchantName.clear();
                  tel.clear();
                  createAt.clear();
                  location.clear();
                  latitude.clear();
                  longitude.clear();
                  image.clear();
                },
                color: Colors.blue,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Text(
                  "Submit Data",
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

  void alert() {
    const snackBar = SnackBar(
      content: Text('Marchent Added'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
