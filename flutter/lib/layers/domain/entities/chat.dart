import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final int? id;
  final String? name;
  final String? icon;
  final bool? isGroup;
  final String? time;
  final String? currentMessage;
  final String? status;
  final bool isSelected;

  Chat({
    this.id,
    this.name,
    this.icon,
    this.isGroup,
    this.time,
    this.currentMessage,
    this.status,
    this.isSelected = false
  });

  @override
  List<Object?> get props => [
    id,
    name,
    icon,
    isGroup,
    time,
    currentMessage,
    status,
    isSelected,
  ];
}