import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketServices extends ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;
  SocketServices() {
    _initConfig();
  }

  ServerStatus get serverstatus => this._serverStatus;
  IO.Socket get socket => _socket;
  Function get emit => this._socket.emit;
  void _initConfig() {
    this._socket = IO.io(
        'http://192.168.0.13:3000/',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());

    this._socket.on('connect', (data) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    /* this._socket.onDisconnect((_) {
      this._serverStatus=ServerStatus
    }); */
    this._socket.on('nuevo-mensaje', (payload) {
      print('nuevo mensaje: $payload');
    });
    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }
}
