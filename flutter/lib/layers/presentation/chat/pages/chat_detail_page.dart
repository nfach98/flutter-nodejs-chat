import 'dart:io';

import 'package:chat/layers/domain/entities/message.dart';
import 'package:chat/layers/presentation/chat/widgets/own_message_card.dart';
import 'package:chat/layers/presentation/chat/notifiers/chat_detail_notifier.dart';
import 'package:chat/layers/presentation/chat/widgets/reply_message_card.dart';
import 'package:chat/model/chat_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chat/core/network/socket.dart';
import 'package:provider/provider.dart';

class ChatDetailPage extends StatefulWidget {
  final ChatModel destinationChat;
  final ChatModel sourceChat;

  const ChatDetailPage({Key? key, required this.destinationChat, required this.sourceChat}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> with WidgetsBindingObserver {
  FocusNode focusNode = FocusNode();
  late TextEditingController _messageController;
  late ScrollController _scrollController;
  late AppLifecycleState? lastLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);

    _messageController = TextEditingController();
    _scrollController = ScrollController();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<ChatDetailNotifier>().reset();
      context.read<ChatDetailNotifier>().getLocalMessages(idUser: widget.destinationChat.id.toString());
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          context.read<ChatDetailNotifier>().setIsShowEmoji(false);
        }
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    offline();

    _messageController.dispose();
    _scrollController.dispose();
    focusNode.dispose();

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

  void online() {
    Socket.socket?.emit("online", widget.sourceChat.id);
  }

  void offline() {
    Socket.socket?.emit("offline", widget.sourceChat.id);
  }

  void sendMessage({required String message, required List<Message> list, required int idSender, required int idReceiver}) {
    setMessage(
      id: "${widget.sourceChat.id}_${DateTime.now().toString()}",
      type: "source",
      message: message,
      messages: list
    );
    Socket.socket?.emit("message", {
      "message" : message,
      "idSender" : idSender,
      "idReceiver" : idReceiver
    });
    _messageController.clear();
    focusNode.unfocus();
    context.read<ChatDetailNotifier>().setIsSend(false);
  }

  void setMessage({required String id, required String type, required String message, required List<Message> messages, bool? isRead}) {
    Message messageModel = Message(
      id: id,
      type: type,
      message: message,
      isRead: isRead,
      time: DateTime.now().toString(),
    );
    messages.add(messageModel);
    List<Message> list = List.from(messages);
    context.read<ChatDetailNotifier>().setMessages(list);
    context.read<ChatDetailNotifier>().addLocalMessage(
      id: messageModel.id,
      type: messageModel.type,
      idUser: widget.destinationChat.id.toString(),
      message: messageModel.message,
      time: messageModel.time,
      isRead: messageModel.isRead,
    );
  }

  @override
  Widget build(BuildContext context) {
    online();

    final listonline = context.select((ChatDetailNotifier n) => n.online);
    final messages = context.select((ChatDetailNotifier n) => n.messages);

    final isSend = context.select((ChatDetailNotifier n) => n.isSend);
    final isShowEmoji = context.select((ChatDetailNotifier n) => n.isShowEmoji);
    final isScrollToEnd = context.select((ChatDetailNotifier n) => n.isScrollToEnd);

    // if (isScrollToEnd && _scrollController.hasClients) {
    //   _scrollController.animateTo(
    //     _scrollController.position.maxScrollExtent,
    //     duration: const Duration(milliseconds: 300),
    //     curve: Curves.easeOut
    //   );
    //   if(mounted) context.read<ChatDetailNotifier>().setIsScrollToEnd(false);
    // }

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
                        widget.destinationChat.name ?? "",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      if (listonline.toString().contains(widget.destinationChat.id.toString())) Text(
                        "Online",
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
                  context.read<ChatDetailNotifier>().setIsShowEmoji(false);
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
                          return const SizedBox(height: 60);
                        }
                        if (messages[index].type == "source") {
                          return OwnMessageCard(message: messages[index]);
                        }

                        return ReplyMessageCard(message: messages[index]);
                      },
                    ),
                  ),
                  Container(
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
                                        context.read<ChatDetailNotifier>().setIsSend(true);
                                      }
                                      else {
                                        context.read<ChatDetailNotifier>().setIsSend(false);
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
                                            context.read<ChatDetailNotifier>().setIsShowEmoji(!isShowEmoji);
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
                                        duration: const Duration(milliseconds: 300),
                                        curve: Curves.easeOut
                                      );
                                      sendMessage(
                                        message: _messageController.text,
                                        list: messages,
                                        idSender: widget.sourceChat.id ?? 0,
                                        idReceiver: widget.destinationChat.id ?? 0
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
