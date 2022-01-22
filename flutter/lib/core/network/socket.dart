import 'package:socket_io_client/socket_io_client.dart' as io;

class Socket {
  static io.Socket? socket;

  static Function(dynamic) onMessage = (msg) {};

  static Function(dynamic) onOnline = (online) {};
}