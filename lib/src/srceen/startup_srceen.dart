// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyeat_admin/src/controller/order_page_controller.dart';
import 'package:loyeat_admin/src/srceen/admin_srceen.dart';
import 'package:loyeat_admin/src/srceen/login_srceen.dart';
import 'customer_srceen.dart';
import 'marchants_srceen.dart';

class StartUpSrceen extends StatefulWidget {
  const StartUpSrceen({Key? key}) : super(key: key);

  @override
  State<StartUpSrceen> createState() => _StartUpSrceenState();
}

class _StartUpSrceenState extends State<StartUpSrceen> {
  final controller = Get.put(OrderPageController());


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
    );
  }

  final appbar = AppBar(
    title: const Text('Start Up Page'),
  );

  Widget get body {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 350,
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
                "Customer Page",
                style: TextStyle(
                  color: Colors.white, 
                ),
              ),
            ),
          ),
        ), 
        Center(
          child: SizedBox(
            width: 350,
            child: RaisedButton(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MarchantsSrceen()),
                );
              },
              color: Colors.blue,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const Text(
                "Merchant Page",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 350,
            child: RaisedButton(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginSrceen()),
                );
              },
              color: Colors.blue,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const Text(
                "Order Page",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ), 
          ),
        ),
        Center(
          child: SizedBox(
            width: 350,
            child: RaisedButton(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminSrceen()),
                );
              },
              color: Colors.blue,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const Text(
                "Admin Page",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ), 
          ),
        )
      ],
    );
  }
}
