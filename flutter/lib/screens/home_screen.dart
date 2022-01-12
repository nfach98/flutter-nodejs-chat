import 'package:chat/model/chat_model.dart';
import 'package:chat/pages/camera_page.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;

  const HomeScreen({Key? key, required this.chatModels, required this.sourceChat}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 1
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WhatsApp Clone"
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {

            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  value: "New group",
                  child: Text("New group")
                ),
                PopupMenuItem(
                  value: "New broadcast",
                  child: Text("New broadcast")
                ),
                PopupMenuItem(
                  value: "Whatsapp web",
                  child: Text("Whatsapp web")
                ),
                PopupMenuItem(
                  value: "Starred message",
                  child: Text("Starred message")
                ),
                PopupMenuItem(
                  value: "Settings",
                  child: Text("Settings")
                ),
              ];
            }
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "CHATS",
            ),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CameraPage(),
          ChatPage(
            chatModels: widget.chatModels,
            sourceChat: widget.sourceChat,
          ),
          Text("Status"),
          Text("Calls"),
        ],
      ),
    );
  }
}
