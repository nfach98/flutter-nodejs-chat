import 'package:chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactCard extends StatelessWidget {
  final ChatModel contact;

  const ContactCard({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 52,
        width: 52,
        child: Stack(
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
            if (contact.isSelected) Positioned(
              bottom: 4,
              right: 4,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.teal,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            )
          ],
        ),
      ),
      title: Text(
        contact.name ?? "",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
      subtitle: Text(
        contact.status ?? "",
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
