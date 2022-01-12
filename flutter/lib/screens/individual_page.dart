import 'dart:io';

import 'package:chat/custom_ui/own_message_card.dart';
import 'package:chat/custom_ui/reply_message_card.dart';
import 'package:chat/model/chat_model.dart';
import 'package:chat/model/message_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualPage extends StatefulWidget {
  final ChatModel chat;
  final ChatModel sourceChat;

  const IndividualPage({Key? key, required this.chat, required this.sourceChat}) : super(key: key);

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool isShowEmoji = false;
  FocusNode focusNode = FocusNode();
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  late IO.Socket socket;
  bool isSend = false;

  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() => isShowEmoji = false);
      }
    });
  }

  void connect() {
    socket = IO.io(
      "https://glacial-anchorage-36266.herokuapp.com",
      <String, dynamic> {
        "transports": ["websocket"],
        "autoConnect": false,
      }
    );
    socket.connect();
    socket.emit("signin", widget.sourceChat.id);
    socket.onConnect((data) {
      socket.on("message", (msg) {
        setMessage(type: "destination", message: msg["message"]);
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut
        );
      });
    });
  }

  void sendMessage({required String message, required int idSender, required int idReceiver}) {
    setMessage(type: "source", message: message);
    socket.emit("message", {
      "message" : message,
      "idSender" : idSender,
      "idReceiver" : idReceiver
    });
    _messageController.clear();
    focusNode.unfocus();
    setState(() => isSend = false);
  }

  void setMessage({required String type, required String message}) {
    MessageModel messageModel = MessageModel(
      type: type,
      message: message,
      time: DateTime.now().toString()
    );
    setState(() => messages.add(messageModel));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/background_chat.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              leadingWidth: 70,
              titleSpacing: 0,
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blueGrey,
                      child: SvgPicture.asset(
                        "assets/icons/person.svg",
                        color: Colors.white,
                        height: 36,
                        width: 36,
                      ),
                    ),
                  ],
                ),
              ),
              title: InkWell(
                onTap: () {

                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chat.name ?? "",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "last seen today at 12:05",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.videocam),
                  onPressed: () {

                  },
                ),
                IconButton(
                  icon: Icon(Icons.call),
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
                            value: "View contact",
                            child: Text("View contact")
                        ),
                        PopupMenuItem(
                            value: "Media, links, and docs",
                            child: Text("Media, links, and docs")
                        ),
                        PopupMenuItem(
                            value: "Whatsapp web",
                            child: Text("Whatsapp web")
                        ),
                        PopupMenuItem(
                            value: "Search",
                            child: Text("Search")
                        ),
                        PopupMenuItem(
                            value: "Mute notification",
                            child: Text("Mute notification")
                        ),
                        PopupMenuItem(
                            value: "Wallpaper",
                            child: Text("Wallpaper")
                        ),
                      ];
                    }
                )
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: () {
                if (isShowEmoji) {
                  setState(() => isShowEmoji = false);
                }
                else {
                  Navigator.pop(context);
                }

                return Future.value(false);
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: messages.length + 1,
                      itemBuilder: (_, index) {
                        if (index == messages.length) {
                          return SizedBox(height: 60);
                        }
                        if (messages[index].type == "source") {
                          return OwnMessageCard(message: messages[index]);
                        }

                        return ReplyMessageCard(message: messages[index]);
                      },
                    ),
                  ),
                  Container(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 60,
                              child: Card(
                                  margin: EdgeInsets.fromLTRB(2, 0, 2, 8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)
                                  ),
                                  child: TextFormField(
                                    controller: _messageController,
                                    focusNode: focusNode,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    minLines: 1,
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() => isSend = true);
                                      }
                                      else {
                                        setState(() => isSend = false);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Type a message",
                                      prefixIcon: IconButton(
                                        icon: Icon(
                                          Icons.emoji_emotions,
                                        ),
                                        onPressed: () {
                                          focusNode.unfocus();
                                          focusNode.canRequestFocus = false;
                                          setState(() => isShowEmoji = !isShowEmoji);
                                        },
                                      ),
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.attach_file,
                                            ),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  backgroundColor: Colors.transparent,
                                                  context: context,
                                                  builder: (_) => bottomSheet()
                                              );
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.camera_alt,
                                            ),
                                            onPressed: () {

                                            },
                                          ),
                                        ],
                                      ),
                                      contentPadding: EdgeInsets.all(4)
                                    ),
                                  )
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(2, 0, 2, 8),
                              child: CircleAvatar(
                                radius: 24,
                                backgroundColor: Color(0xFF128C7E),
                                child: IconButton(
                                  icon: Icon(
                                    isSend ? Icons.send : Icons.mic,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (isSend) {
                                      _scrollController.animateTo(
                                        _scrollController.position.maxScrollExtent,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeOut
                                      );
                                      sendMessage(
                                        message: _messageController.text,
                                        idSender: widget.sourceChat.id ?? 0,
                                        idReceiver: widget.chat.id ?? 0
                                      );
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        if (isShowEmoji) emojiSelect(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget emojiSelect() {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      child: EmojiPicker(
        config: Config(
          columns: 7,
          emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
          verticalSpacing: 0,
          horizontalSpacing: 0,
          initCategory: Category.RECENT,
          bgColor: Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          progressIndicatorColor: Colors.blue,
          showRecentsTab: true,
          recentsLimit: 28,
          noRecentsText: "No Recents",
          noRecentsStyle: const TextStyle(fontSize: 20, color: Colors.black26),
          tabIndicatorAnimDuration: kTabScrollDuration,
          categoryIcons: const CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL
        ),
        onEmojiSelected: (category, emoji) {
          setState(() {
            _messageController.text = _messageController.text + emoji.emoji;
          });
        }
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 20
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconFile(
                    icon: Icons.insert_drive_file,
                    color: Colors.indigo,
                    text: "Document"
                  ),
                  iconFile(
                    icon: Icons.camera_alt,
                    color: Colors.pink,
                    text: "Camera"
                  ),
                  iconFile(
                    icon: Icons.insert_photo,
                    color: Colors.purple,
                    text: "Gallery"
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconFile(
                      icon: Icons.headset,
                      color: Colors.deepOrange,
                      text: "Audio"
                  ),
                  iconFile(
                      icon: Icons.location_pin,
                      color: Colors.teal,
                      text: "Location"
                  ),
                  iconFile(
                      icon: Icons.person,
                      color: Colors.blue,
                      text: "Contact"
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget iconFile({required IconData icon, required Color color, required String text}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: color,
          child: Icon(
            icon,
            size: 28,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12
          ),
        )
      ],
    );
  }
}
