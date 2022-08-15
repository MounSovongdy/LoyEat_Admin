import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loyeat_admin/src/srceen/landing_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );
  MaterialApp app = MaterialApp(
    home: LandingScreen(),
    debugShowCheckedModeBanner: false,
  );
  runApp(app);
}
