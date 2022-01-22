import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String id;
  final String? type;
  final String? idUser;
  final String? message;
  final String? time;
  final bool? isRead;

  Message({
    required this.id,
    this.type,
    this.idUser,
    this.message,
    this.time,
    this.isRead
  });

  @override
  List<Object?> get props => [
    id,
    type,
    idUser,
    message,
    time,
    isRead,
  ];
}