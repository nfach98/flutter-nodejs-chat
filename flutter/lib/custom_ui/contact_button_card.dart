import 'package:chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactButtonCard extends StatelessWidget {
  final String name;
  final IconData icon;

  const ContactButtonCard({Key? key, required this.name, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        child: Icon(
          icon,
          size: 24,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF128C7E),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
