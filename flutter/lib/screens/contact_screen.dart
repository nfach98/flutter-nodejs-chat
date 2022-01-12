import 'package:chat/custom_ui/contact_button_card.dart';
import 'package:chat/custom_ui/contact_card.dart';
import 'package:chat/model/chat_model.dart';
import 'package:chat/screens/new_group.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  List<ChatModel> contacts = [
    ChatModel(
      name: "Brutus",
      status: "Brewokan"
    ),
    ChatModel(
      name: "Kevin",
      status: "meow"
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "${contacts.length} contacts",
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 24,
            ),
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
                      value: "Invite a friend",
                      child: Text("Invite a friend")
                  ),
                  PopupMenuItem(
                      value: "Contacts",
                      child: Text("Contacts")
                  ),
                  PopupMenuItem(
                      value: "Refresh",
                      child: Text("Refresh")
                  ),
                  PopupMenuItem(
                      value: "Help",
                      child: Text("Help")
                  ),
                ];
              }
          )
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length + 2,
        itemBuilder: (_, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => NewGroupScreen()));
              },
              child: ContactButtonCard(
                name: "New group",
                icon: Icons.group,
              ),
            );
          }
          else if (index == 1) {
            return ContactButtonCard(
              name: "New contact",
              icon: Icons.person_add,
            );
          }
          return ContactCard(
            contact: contacts[index - 2],
          );
        }
      ),
    );
  }
}
