
import 'package:chat/layers/domain/entities/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReplyMessageCard extends StatelessWidget {
  final Message message;

  const ReplyMessageCard({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
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
                bottomRight: Radius.circular(12),
              )
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 80, 20),
                child: Text(
                  message.message ?? "",
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 12,
                child: Text(
                  DateFormat("HH:mm").format(DateTime.parse(message.time ?? "")),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
