import 'package:camera/camera.dart';
import 'package:chat/screens/camera_screen.dart';
import 'package:chat/screens/home_screen.dart';
import 'package:chat/screens/landing_screen.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chat',
      theme: ThemeData(
        fontFamily: "OpenSans",
        primaryColor: Color(0xFF075E54),
        accentColor: Color(0xFF128C7E)
      ),
      home: const LoginScreen(),
    );
  }
}