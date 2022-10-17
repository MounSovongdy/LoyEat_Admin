// // ignore_for_file: deprecated_member_use
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
//
// class OrderSrceen extends StatefulWidget {
//   const OrderSrceen({Key? key}) : super(key: key);
//
//   @override
//   State<OrderSrceen> createState() => _CustomerScreenState();
// }
//
// class _CustomerScreenState extends State<OrderSrceen> {
//   final orderId = TextEditingController();
//   final orderTime = TextEditingController();
//   final orderDate = TextEditingController();
//   final customerId = TextEditingController();
//   final customerName = TextEditingController();
//   final merchantId = TextEditingController();
//   final merchantName = TextEditingController();
//   final period = TextEditingController();
//   final bonus = TextEditingController();
//   final tip = TextEditingController();
//   final totalDiscount = TextEditingController();
//   final distance = TextEditingController();
//   final deliveryFee = TextEditingController();
//
//   CollectionReference delivers =
//   FirebaseFirestore.instance.collection('delivers');
//   CollectionReference orders = FirebaseFirestore.instance.collection('orders');
//   CollectionReference driverReport =
//   FirebaseFirestore.instance.collection('driver_reports');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appbar,
//       body: body,
//       //bottomNavigationBar: const BottomAppBarWidget(),
//     );
//   }
//
//   final appbar = AppBar(
//     title: const Text('Order Page'),
//   );
//
//   Widget get body {
//     return ListView(
//       padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
//       children: [
//         textEditingController(controller: orderId, labletext: 'Order ID'),
//         textEditingController(
//           controller: orderTime,
//           labletext: 'Order Time',
//           suffixIcon: GestureDetector(
//               onTap: () async {
//                 TimeOfDay? pickedTime = await showTimePicker(
//                     initialTime: TimeOfDay.now(), context: context);
//
//                 if (pickedTime != null) {
//                   DateTime parsedTime = DateFormat.jm()
//                   // ignore: use_build_context_synchronously
//                       .parse(pickedTime.format(context).toString());
//                   String formattedTime =
//                   DateFormat('HH:mm a').format(parsedTime);
//
//                   setState(() {
//                     orderTime.text = formattedTime;
//                   });
//                 } else {
//                   debugPrint("Time is not selected");
//                 }
//               },
//               child: const Icon(Icons.timer_rounded)),
//         ),
//         textEditingController(
//           controller: orderDate,
//           labletext: 'Order Date',
//           suffixIcon: GestureDetector(
//               onTap: () async {
//                 DateTime? pickerDate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2101));
//
//                 if (pickerDate != null) {
//                   setState(() {
//                     orderDate.text = DateFormat('dd-MMM-yy').format(pickerDate);
//                   });
//                 }
//               },
//               child: const Icon(Icons.calendar_month_rounded)),
//         ),
//         textEditingController(controller: customerId, labletext: 'Customer ID'),
//         textEditingController(
//             controller: customerName, labletext: 'Customer Name'),
//         textEditingController(controller: merchantId, labletext: 'Merchant Id'),
//         textEditingController(
//             controller: merchantName, labletext: 'Merchant Name'),
//         textEditingController(controller: period, labletext: 'Order Period'),
//         textEditingController(controller: bonus, labletext: 'Bonus'),
//         textEditingController(controller: tip, labletext: 'Tip'),
//         textEditingController(
//             controller: totalDiscount, labletext: 'Total Discount'),
//         textEditingController(controller: distance, labletext: 'Distance'),
//         textEditingController(
//             controller: deliveryFee, labletext: 'Delivery Fee'),
//         buttonSubmit,
//       ],
//     );
//   }
//
//   Widget textEditingController({
//     required TextEditingController controller,
//     required String labletext,
//     Widget? suffixIcon,
//   }) {
//     return Column(children: [
//       Container(
//         padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//         child: TextField(
//           controller: controller,
//           obscureText: false,
//           decoration: InputDecoration(
//             suffixIcon: suffixIcon,
//             border: const OutlineInputBorder(),
//             labelText: labletext,
//           ),
//           onSubmitted: (value) {
//             controller.text = value;
//           },
//         ),
//       ),
//     ]);
//   }
//
//   Widget get buttonSubmit {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 8),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: SizedBox(
//               width: 400,
//               child: RaisedButton(
//                 padding:
//                 const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//                 //onPressed for insert to firestore
//                 onPressed: () async {
//                   await orders.add({
//                     'customer_id': customerId.text,
//                     'customer_name': customerName.text,
//                     'date': orderDate.text,
//                     'driver_id': '',
//                     'is_new': true,
//                     'merchant_id': merchantId.text,
//                     'merchant_name': merchantName.text,
//                     'order_id': orderId.text,
//                     'time': orderTime.text,
//                     'total_discount': totalDiscount.text,
//                   }).then((value) => debugPrint('added'));
//
//                   await delivers.add({
//                     'bonus': bonus.text,
//                     'customer_rating': '5.0',
//                     'date': orderDate.text,
//                     'delivery_fee': deliveryFee.text,
//                     'distance': distance.text,
//                     'merchant_rating': '5.0',
//                     'order_id': orderId.text,
//                     'period': period.text,
//                     'process': '',
//                     'step_1': false,
//                     'step_2': false,
//                     'step_3': false,
//                     'step_4': false,
//                     'tip': tip.text,
//                   }).then((value) => alert());
//
//                   final data = driverReport.where('date', isEqualTo: orderDate.text).snapshots();
//
//                   data.listen((event) async {
//                     if (event.docs.isEmpty) {
//                       await driverReport.add({
//                         'bonus': bonus.text,
//                         'customer_rating': '5.0',
//                         'date': orderDate.text,
//                         'delivery_fee': deliveryFee.text,
//                         'distance': distance.text,
//                         'driver_id': '',
//                         'merchant_rating': '5.0',
//                         'online_hour': '0',
//                         'online_minute': '0',
//                         'point': '',
//                         'tip': '',
//                         'trip': '',
//                         'day': 1,
//                         'month': 1,
//                         'year': 2020,
//                       }).then((value) => debugPrint('added'));
//                     }
//                   });
//
//                   //clear text from testfeild
//                   orderId.clear();
//                   orderTime.clear();
//                   orderDate.clear();
//                   customerId.clear();
//                   customerName.clear();
//                   merchantId.clear();
//                   merchantName.clear();
//                   period.clear();
//                   bonus.clear();
//                   tip.clear();
//                   totalDiscount.clear();
//                   distance.clear();
//                   deliveryFee.clear();
//                 },
//                 color: Colors.blue,
//                 shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(5))),
//                 child: const Text(
//                   "Submit Data",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void alert() {
//     const snackBar = SnackBar(
//       content: Text('Order Sueccesfully'),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
