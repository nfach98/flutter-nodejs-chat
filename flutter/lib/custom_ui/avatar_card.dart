import 'package:chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AvatarCard extends StatelessWidget {
  final ChatModel contact;

  const AvatarCard({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 12
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                child: SvgPicture.asset(
                  "assets/icons/person.svg",
                  color: Colors.white,
                  height: 28,
                  width: 28,
                ),
                backgroundColor: Colors.blueGrey[200],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 2),
          Text(
            contact.name ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12
            ),
          )
        ],
      ),
    );
  }
}
