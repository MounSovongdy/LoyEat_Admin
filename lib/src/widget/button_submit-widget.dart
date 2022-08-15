// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ButtonSubmitWidget extends StatelessWidget {
//   ButtonSubmitWidget({Key? key}) : super(key: key);

//   CollectionReference customers =
//       FirebaseFirestore.instance.collection('customer');

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 8),
//       child: TextButton(
//         style: ButtonStyle(
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30.0),
//             ),
//           ),
//           foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//         ),
//         onPressed: () async {
//           await customers
//               .add({'customer_name'}).then((value) => print('Added'));
//         },
//         child: const Text('Submit'),
//       ),
//     );
//   }
// }
