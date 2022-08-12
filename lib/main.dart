import 'package:flutter/material.dart';
import 'package:loyeat_admin/src/landing_screen.dart';

void main(){
  MaterialApp app = const MaterialApp(
    home: LandingScreen(),
    debugShowCheckedModeBanner: false,
  );
  runApp(app);
}
