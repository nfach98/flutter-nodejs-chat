class ChatModel {
  int? id;
  String? name;
  String? icon;
  bool? isGroup;
  String? time;
  String? currentMessage;
  String? status;
  bool isSelected;

  ChatModel({this.id, this.name, this.icon, this.isGroup, this.time, this.currentMessage, this.status, this.isSelected = false});
}