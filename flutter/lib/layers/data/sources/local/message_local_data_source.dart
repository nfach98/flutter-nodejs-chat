import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chat/core/storage/internal_storage.dart';
import 'package:chat/layers/data/models/message_model.dart';

abstract class MessageLocalDataSource {
  Future<List<MessageModel>> getLocalMessages({required String idUser});

  Future<int> addLocalMessage({required String id, String? type, String? idUser, String? message, String? time, bool? isRead});

  Future<int> deleteLocalMessage({required String id});
}

class MessageLocalDataSourceImpl implements MessageLocalDataSource {
  InternalStorage storage = InternalStorage();

  @override
  Future<List<MessageModel>> getLocalMessages({required String idUser}) async {
    List<MessageModel> messages = [];
    String? data = await storage.readMessages();
    if (data != null) {
      List<dynamic> map = json.decode(data);

      if (map.isNotEmpty) {
        var mapId = map.where((element) => element["id_user"] == idUser);
        for (var element in mapId) {
          messages.add(MessageModel.fromJson(element));
        }
      }
    }

    return messages;
  }

  @override
  Future<int> addLocalMessage({required String id, String? type, String? idUser, String? message, String? time, bool? isRead}) async {
    List<MessageModel> messages = [];
    File? file;

    String? data = await storage.readMessages();
    List<dynamic> map = json.decode(data ?? "[]");

    for (var element in map) {
      messages.add(MessageModel.fromJson(element));
    }
    messages.add(MessageModel(
        id: id,
        type: type,
        idUser: idUser,
        message: message,
        time: time,
        isRead: isRead
    ));
    log(json.encode(messages));
    file = await storage.writeMessages(json.encode(messages));

    return file == null ? 0 : 1;
  }

  @override
  Future<int> deleteLocalMessage({required String id}) async {
    List<MessageModel> messages = [];
    File? file;

    String? data = await storage.readMessages();
    List<dynamic> map = json.decode(data ?? "[]");

    for (var element in map) {
      messages.add(MessageModel.fromJson(element));
    }
    messages.removeWhere((element) => element.id == id);
    file = await storage.writeMessages(json.encode(messages));

    return file == null ? 0 : 1;
  }
}