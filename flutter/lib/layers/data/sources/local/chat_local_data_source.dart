import 'dart:convert';

import 'package:chat/core/storage/internal_storage.dart';
import 'package:chat/layers/data/models/chat_model.dart';

abstract class ChatLocalDataSource {
  Future<List<ChatModel>> getLocalChats();
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  InternalStorage storage = InternalStorage();

  @override
  Future<List<ChatModel>> getLocalChats() async {
    List<ChatModel> chats = [];
    String? data = await storage.readChats();
    if (data != null) {
      List<Map<String, dynamic>> map = json.decode(data);

      if (map.isNotEmpty) {
        for (var element in map) {
          chats.add(ChatModel.fromJson(element));
        }
      }
    }

    return chats;
  }
}