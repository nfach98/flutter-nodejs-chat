import 'package:camera/camera.dart';
import 'package:chat/layers/presentation/chat/notifiers/chat_detail_notifier.dart';
import 'package:chat/screens/camera_screen.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Chat
        ChangeNotifierProvider<ChatDetailNotifier>(
          create: (_) => di.sl<ChatDetailNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'chat',
        theme: ThemeData(
          fontFamily: "OpenSans",
          primaryColor: Color(0xFF075E54),
          accentColor: Color(0xFF128C7E)
        ),
        home: const LoginScreen(),
      ),
    );
  }
}