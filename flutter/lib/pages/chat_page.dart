import 'package:chat/custom_ui/custom_card.dart';
import 'package:chat/model/chat_model.dart';
import 'package:chat/screens/contact_screen.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;

  const ChatPage({Key? key, required this.chatModels, required this.sourceChat}) : super(key: key);

  @override

  _ChatPageState createState() => _ChatPageState();

}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ContactScreen()));
        },
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: widget.chatModels.length,
        itemBuilder: (_, index) => CustomCard(
          chat: widget.chatModels[index],
          sourceChat: widget.sourceChat,
        ),
      ),
    );
  }
}
