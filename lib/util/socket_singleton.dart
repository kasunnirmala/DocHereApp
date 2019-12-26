import 'package:adhara_socket_io/adhara_socket_io.dart';

class SocketSingleton {
  SocketIO socket;
  SocketSingleton._internal() {
    initSocket();
  }
  static final SocketSingleton _singleton = SocketSingleton._internal();

  factory SocketSingleton() {
    return _singleton;
  }

  initSocket() async {
    socket = await SocketIOManager()
        .createInstance(SocketOptions('http://192.168.8.100:5000/'));
    socket.onConnect((data) {
      // socket = skt;
      print("connected...");
    });

    socket.connect();
  }
}
