import 'package:chat/layers/domain/entities/message.dart';

class MessageModel extends Message {
  String id;
  String? type;
  String? idUser;
  String? message;
  String? time;
  bool? isRead;

  MessageModel({
    required this.id,
    this.type,
    this.idUser,
    this.message,
    this.time,
    this.isRead
  }) : super(
    id: id,
    type: type,
    idUser: idUser,
    message: message,
    time: time,
    isRead: isRead
  );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json["id"],
      type : json['type'],
      idUser : json['id_user'],
      message : json['message'],
      time : json['time'],
      isRead : json['is_read'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'type' : type,
      'id_user' : idUser,
      'message' : message,
      'time' : time,
      'is_read' : isRead,
    };
  }
}