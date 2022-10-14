// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AdminSrceen extends StatefulWidget {
  const AdminSrceen({Key? key}) : super(key: key);

  @override
  State<AdminSrceen> createState() => _AdminSrceenState();
}

class _AdminSrceenState extends State<AdminSrceen> {
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
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) { 
      return Card(
        borderOnForeground: true,
        clipBehavior: Clip.antiAlias,
          child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.person,size: 50,),
                  title: Text('Driver Name: Sok Sovan'),
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
                            'Gender',
                            style: TextStyle(fontStyle: FontStyle.normal),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Birth',
                            style: TextStyle(fontStyle: FontStyle.normal),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Vehicle',
                            style: TextStyle(fontStyle: FontStyle.normal),
                          ),
                        ),
                      ),
                    ],
                    rows: const <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('Male')),
                          DataCell(Text('1989')),
                          DataCell(Text('Motor')),
                        ],
                      ),
                    ],
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: [
                    FlatButton(
                      textColor: Color.fromARGB(255, 246, 6, 6),
                      onPressed: () {
                        // Perform some action
                      },
                      child: const Text('Reject'),
                    ),
                    FlatButton(
                      textColor: Color.fromARGB(255, 32, 151, 235),
                      onPressed: () {
                        // Perform some action
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
}
