import 'package:flutter/material.dart';
import 'package:loyeat_admin/src/widget/bottom_app_bar_widget.dart';
import 'package:loyeat_admin/src/widget/text_field_widget.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loy Eat Dashboard'),
      ),
      body: body,
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
  Widget get body{
    return ListView(
      children: const [
        TextFieldWidget(),
        
      ],
    );
  }

}