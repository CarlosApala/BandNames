import 'package:band_names/services/sockets_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class StatusPages extends StatelessWidget {
  const StatusPages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusSocket = Provider.of<SocketServices>(context);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Estado conexion: ${statusSocket.serverstatus}'),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          statusSocket.emit('emitir-mensaje',
              {'nombre': 'flutter', 'mensaje': 'hola desde flutter'});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
