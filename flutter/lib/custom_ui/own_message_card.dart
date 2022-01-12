import 'package:chat/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OwnMessageCard extends StatelessWidget {
  final MessageModel message;

  const OwnMessageCard({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 46,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            )
          ),
          color: Color(0xFFDCF8C6),
          margin: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 80, 20),
                child: Text(
                  message.message,
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 12,
                child: Row(
                  children: [
                    Text(
                      DateFormat("HH:mm").format(DateTime.parse(message.time)),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.done_all,
                      size: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
