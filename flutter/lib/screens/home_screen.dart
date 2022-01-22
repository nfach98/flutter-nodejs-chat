import 'package:chat/core/network/socket.dart';
import 'package:chat/core/storage/internal_storage.dart';
import 'package:chat/layers/presentation/chat/notifiers/chat_detail_notifier.dart';
import 'package:chat/model/chat_model.dart';
import 'package:chat/pages/camera_page.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class HomeScreen extends StatefulWidget {
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;

  const HomeScreen({Key? key, required this.chatModels, required this.sourceChat}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;
  late AppLifecycleState? lastLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);

    Socket.socket = io.io(
      // "https://glacial-anchorage-36266.herokuapp.com",
      "http://192.168.68.184:5000",
      <String, dynamic> {
        "transports": ["websocket"],
        "autoConnect": false,
      }
    );
    Socket.socket?.connect();
    Socket.socket?.onConnect((data) {
      Socket.socket?.on("message", (msg) {
        context.read<ChatDetailNotifier>().onMessage(msg);
        context.read<ChatDetailNotifier>().addLocalMessage(
          id: "${msg["idSender"]}_${DateTime.now().toString()}",
          type: "destination",
          idUser: msg["idSender"].toString(),
          message: msg["message"],
          isRead: true,
          time: DateTime.now().toString(),
        );
      });
      Socket.socket?.on("online", (online) {
        context.read<ChatDetailNotifier>().onOnline(online);
      });
    });

    _tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 1
    );
  }



  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    offline();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      lastLifecycleState = state;
      if (state == AppLifecycleState.resumed) {
        online();
      }
      else {
        offline();
      }
    });
  }

  @override
  Future<bool> didPopRoute() async {
    offline();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    online();

    return WillPopScope(
      onWillPop: () async {
        Socket.socket?.emit("offline", widget.sourceChat.id);
        Socket.socket?.disconnect();
        Socket.socket?.destroy();

        return true;
      },
      child: Scaffold(
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
              onSelected: (value) async {
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
      ),
    );
  }

  void online() {
    Socket.socket?.emit("online", widget.sourceChat.id);
  }

  void offline() {
    Socket.socket?.emit("offline", widget.sourceChat.id);
  }
}
