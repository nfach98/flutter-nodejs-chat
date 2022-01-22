import 'dart:io';
import 'package:path_provider/path_provider.dart';

class InternalStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localChat async {
    final path = await _localPath;
    return File('$path/chats.chat');
  }

  Future<File> get _localMessage async {
    final path = await _localPath;
    return File('$path/messages.chat');
  }

  Future<String?> readChats() async {
    try {
      final file = await _localChat;

      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  Future<File> writeChats(String counter) async {
    final file = await _localChat;
    return file.writeAsString(counter);
  }

  Future<String?> readMessages() async {
    try {
      final file = await _localMessage;

      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }

  Future<File> writeMessages(String message) async {
    final file = await _localMessage;
    return file.writeAsString(message);
  }
}