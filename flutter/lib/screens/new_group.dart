import 'package:chat/custom_ui/avatar_card.dart';
import 'package:chat/custom_ui/contact_card.dart';
import 'package:chat/model/chat_model.dart';
import 'package:flutter/material.dart';

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({Key? key}) : super(key: key);

  @override
  _NewGroupScreenState createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  List<ChatModel> contacts = [
    ChatModel(
      name: "Brutus",
      status: "Brewokan",
    ),
    ChatModel(
      name: "Kevin",
      status: "meow"
    )
  ];

  List<ChatModel> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Group",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "Add participants",
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
        ],
      ),
      body: Column(
        children: [
          if (selected.isNotEmpty) Column(
            children: [
              Container(
                height: 76,
                color: Colors.white,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: contacts.length,
                    itemBuilder: (_, index) {
                      if(contacts[index].isSelected) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              contacts[index].isSelected = false;
                              selected.remove(contacts[index]);
                            });
                          },
                          child: AvatarCard(
                              contact: contacts[index]
                          ),
                        );
                      }

                      else {
                        return Container();
                      }
                    }
                ),
              ),
              Divider(
                thickness: 1,
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (_, index) => InkWell(
                onTap: () {
                  if (!contacts[index].isSelected) {
                    setState(() {
                      contacts[index].isSelected = true;
                      selected.add(contacts[index]);
                    });
                  }
                  else {
                    setState(() {
                      contacts[index].isSelected = false;
                      selected.remove(contacts[index]);
                    });
                  }
                },
                child: ContactCard(
                  contact: contacts[index],
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}