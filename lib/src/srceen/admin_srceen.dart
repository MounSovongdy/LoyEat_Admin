// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyeat_admin/src/controller/admin_controller.dart';
import 'package:loyeat_admin/src/controller/remote_data.dart';

class AdminSrceen extends StatefulWidget {
  const AdminSrceen({Key? key}) : super(key: key);

  @override
  State<AdminSrceen> createState() => _AdminSrceenState();
}

class _AdminSrceenState extends State<AdminSrceen> {
  final controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: body,
      backgroundColor: const Color.fromARGB(255, 199, 199, 198),
    );
  }
  final appbar = AppBar(
    title: const Text('Admin Page'),
    
  );

  Widget get body{
    return Obx(() {
      final driverNameStatus = controller.driverData.status;

      if (driverNameStatus == RemoteDataStatus.processing) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      else if (driverNameStatus == RemoteDataStatus.error) {
        return const Text('Error while loading data from server.');
      }
      else if (driverNameStatus == RemoteDataStatus.none) {
        return const Center(child: Text('No Driver Register....'));
      }
      else {
        final name = controller.listDriverName;
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: name.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              borderOnForeground: true,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person,size: 50,),
                    title: Text('Name: ${controller.listDriverName[index]}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: DataTable(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5,
                            color: Colors.black87,
                          )
                      ),
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'ID Card',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Birth',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Tel',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(controller.listIdCard[index], style: const TextStyle(fontSize: 10))),
                            DataCell(Text(controller.listBirth[index], style: const TextStyle(fontSize: 10))),
                            DataCell(Text('0${controller.listTel[index]}', style: const TextStyle(fontSize: 10))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    children: [
                      FlatButton(
                        textColor: const Color.fromARGB(255, 246, 6, 6),
                        onPressed: () {
                          // Perform some action
                        },
                        child: const Text('Reject'),
                      ),
                      FlatButton(
                        textColor: const Color.fromARGB(255, 32, 151, 235),
                        onPressed: () {
                          // Perform some action
                          controller.approveDriver(controller.listTel[index]);
                          controller.loadDriver();
                        },
                        child: const Text('Approve'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }
    });
  }
}
