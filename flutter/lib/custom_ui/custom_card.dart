import 'package:chat/model/chat_model.dart';
import 'package:chat/screens/individual_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  final ChatModel? chat;
  final ChatModel sourceChat;

  const CustomCard({Key? key, this.chat, required this.sourceChat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (chat != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => IndividualPage(
              chat: chat!,
              sourceChat: sourceChat,
            ))
          );
        }
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 28,
              child: SvgPicture.asset(
                "assets/icons/person.svg",
                color: Colors.white,
                height: 36,
                width: 36,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(
              chat?.name ?? "",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(width: 4),
                Text(
                  chat?.currentMessage ?? "",
                )
              ],
            ),
            trailing: Text(chat?.time ?? "",),
          ),
          Padding(
            padding: EdgeInsets.only(left: 80, right: 20),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
