import 'package:flutter/material.dart';
import 'package:loyeat_admin/src/widget/bottom_app_bar_widget.dart';
import 'package:loyeat_admin/src/widget/button_submit-widget.dart';
import 'package:loyeat_admin/src/widget/text_field_widget.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: body,
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  final appbar = AppBar(
    title: const Text('Loy Eat Dashboard'),
  );

  Widget get body {
    return ListView(
      children: const [
        TextFieldWidget(),
        TextFieldWidget(),
        TextFieldWidget(),
        TextFieldWidget(),
        ButtonSubmitWidget(),
      ],
    );
  }
}
