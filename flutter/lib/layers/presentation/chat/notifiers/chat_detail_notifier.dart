import 'dart:convert';
import 'dart:developer';

import 'package:chat/layers/domain/entities/message.dart';
import 'package:chat/layers/domain/usecase/message/add_local_message_usecase.dart';
import 'package:chat/layers/domain/usecase/message/delete_local_message_usecase.dart';
import 'package:chat/layers/domain/usecase/message/get_local_messages_usecase.dart';
import 'package:flutter/cupertino.dart';

class ChatDetailNotifier with ChangeNotifier {
  final GetLocalMessagesUsecase _localMessagesUsecase;
  final AddLocalMessageUsecase _addLocalMessageUsecase;
  final DeleteLocalMessageUsecase _deleteLocalMessageUsecase;

  ChatDetailNotifier({
    required GetLocalMessagesUsecase localMessagesUsecase,
    required AddLocalMessageUsecase addLocalMessageUsecase,
    required DeleteLocalMessageUsecase deleteLocalMessageUsecase,
  }) : _localMessagesUsecase = localMessagesUsecase,
        _addLocalMessageUsecase = addLocalMessageUsecase,
        _deleteLocalMessageUsecase = deleteLocalMessageUsecase;

  List online = [];

  List<Message> messages = [];
  bool isLoadingMessages = false;

  bool isSend = false;
  bool isShowEmoji = false;
  bool isScrollToEnd = false;

  Future<void> getLocalMessages({required String idUser}) async {
    isLoadingMessages = true;
    notifyListeners();

    final result = await _localMessagesUsecase(GetLocalMessagesParams(idUser: idUser));

    result.fold(
      (error) { },
      (success) {
        log(json.encode(success), name: "get");
        messages.addAll(success);
      }
    );

    isLoadingMessages = false;
    notifyListeners();
  }

  Future<int> addLocalMessage({required String id, String? type, String? idUser, String? message, String? time, bool? isRead}) async {
    int status = 0;

    final result = await _addLocalMessageUsecase(AddLocalMessagesParams(
      id: id,
      type: type,
      idUser: idUser,
      message: message,
      time: time,
      isRead: isRead
    ));

    result.fold(
      (error) { },
      (success) {
        status = success;
      }
    );

    return status;
  }

  Future<int> deleteLocalMessage({required String id}) async {
    int status = 0;

    final result = await _deleteLocalMessageUsecase(DeleteLocalMessageParams(id: id));

    result.fold(
      (error) { },
      (success) {
        status = success;
        List<Message> list = List.from(messages);
        list.removeWhere((element) => element.id == id);
      }
    );

    notifyListeners();
    return status;
  }

  onOnline(online) {
    this.online = online;
    notifyListeners();
  }

  onMessage(msg) {
    Message message = Message(
      id: "${msg["idSender"]}_${DateTime.now().toString()}",
      type: "destination",
      message: msg["message"],
      isRead: true,
      time: DateTime.now().toString(),
    );

    List<Message> list = List.from(messages);
    list.add(message);
    messages = list;
    isScrollToEnd = true;
    notifyListeners();
  }

  setMessages(List<Message> list) {
    messages = list;
    notifyListeners();
  }

  setIsSend(bool value) {
    isSend = value;
    notifyListeners();
  }

  setIsShowEmoji(bool value) {
    isShowEmoji = value;
    notifyListeners();
  }

  setIsScrollToEnd(bool value) {
    isScrollToEnd = value;
    notifyListeners();
  }

  reset() {
    online = [];

    messages = [];
    isLoadingMessages = false;

    isSend = false;
    isShowEmoji = false;
    isScrollToEnd = false;

    notifyListeners();
  }
}