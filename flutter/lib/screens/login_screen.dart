import 'package:chat/custom_ui/contact_button_card.dart';
import 'package:chat/model/chat_model.dart';
import 'package:chat/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chatModels = [
    ChatModel(
      id: 1,
      name: "Brutus",
      isGroup: false,
      currentMessage: "24",
      time: "04:00",
      icon: "person.svg"
    ),
    ChatModel(
      id: 2,
      name: "Kevin",
      isGroup: false,
      currentMessage: "Meow",
      time: "14:27",
      icon: "person.svg"
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatModels.length,
        itemBuilder: (_, index) => InkWell(
          onTap: () {
            sourceChat = chatModels.removeAt(index);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen(
              chatModels: chatModels,
              sourceChat: sourceChat,
            )));
          },
          child: ContactButtonCard(
            name: chatModels[index].name ?? "",
            icon: Icons.person
          ),
        )
      ),
    );
  }
}