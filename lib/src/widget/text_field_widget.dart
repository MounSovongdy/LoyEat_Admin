import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
            child: const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Customer ID',
                ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
            child: const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Customer Name',
                ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
            child: const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Date',
                ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
            child: const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Marchent ID',
                ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
            child: const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Marchant Name',
                ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
            child: const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Order ID',
                ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
            child: const TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Time',
                ),
            ),
          ),
        ],
      ),
    );
  }
}