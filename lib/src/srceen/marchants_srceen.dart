// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:loyeat_admin/src/widget/bottom_app_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final position = TextEditingController();
  final image = TextEditingController();
  

  CollectionReference merchants = FirebaseFirestore.instance.collection('merchants');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: body,
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }

  final appbar = AppBar(
    title: const Text('Merchant Page'),
  );

  Widget get body {

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal:0),
      children: [
        textEditingController(controller: merchantName,labletext: 'Merchant Name'),
        textEditingController(controller: merchantId,labletext: 'Merchant ID'),
        textEditingController(controller: tel,labletext: 'Telephone'),
        textEditingController(controller: createAt,labletext: 'Create Date'),
        textEditingController(controller: location,labletext: 'Location'),
        textEditingController(controller: position,labletext: 'Position'),
        textEditingController(controller: image,labletext: 'Image'),
       
        buttonSubmit,
      ],
    );
  }

  Widget textEditingController({required TextEditingController controller, required String labletext}){
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child:  TextField(
              controller: controller,
              obscureText: false,
              decoration:  InputDecoration(
                border: const OutlineInputBorder(),
                labelText: labletext,
              ),
              onSubmitted: (value) {
                controller.text = value;
              },
            ),
        ),
      ]
    );
  }

  Widget get buttonSubmit{
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
                    'merchant_id' : merchantId.text,
                    'merchant_name' : merchantName.text,
                    'tel' : tel.text,
                    'create_at' : createAt.text,
                    'location' : location.text,
                    'position' : position.text,
                    'image' : image.text,
                  }).then((value) => print(' Deliver Added'));

                  //clear text from testfeild
                  merchantId.clear();
                  merchantName.clear();
                  tel.clear();
                  createAt.clear();
                  location.clear();
                  position.clear();
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
}