import 'package:chat/layers/domain/entities/chat.dart';

class ChatModel extends Chat {
  int? id;
  String? name;
  String? icon;
  bool? isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool isSelected;

  ChatModel({
    this.id,
    this.name,
    this.icon,
    this.isGroup,
    this.time,
    this.currentMessage,
    this.status,
    this.isSelected = false
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id : json['id'],
      name : json['name'],
      icon : json['icon'],
      isGroup : json['is_group'],
      time : json['time'],
      currentMessage : json['current_message'],
      status : json['status'],
      isSelected : json['is_selected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name' : name,
      'icon' : icon,
      'is_group' : isGroup,
      'time' : time,
      'current_message' : currentMessage,
      'status' : status,
      'is_selected' : isSelected,
    };
  }
}