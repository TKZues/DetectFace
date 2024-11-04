// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:findy/main.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketTimeline {
  static final SocketTimeline instance = SocketTimeline();

  IO.Socket? socketmotion;

  Future<void> initializeSocketWithTokenIvmsmotion() async {
      socketmotion = IO.io(
          baseUrl,
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build());
      debugPrint('Socket initialized');
  }
  void connectSocketIvms()  {

    if (socketmotion != null) {
      try {
        socketmotion!.connect();
        socketmotion!.onConnect((_) {
          debugPrint("socketmotion connection success");
        });
        socketmotion!.onConnectError((data) {
          debugPrint("socketmotion connection error: $data");
        });
        socketmotion!.onError((data) {
          debugPrint("socketmotion error: $data");
        });
      } catch (e) {
        debugPrint('Connection failed, Error: $e');
      }
    } else {
      debugPrint('Socket not initialized');
    }
  }
  void disconnectFromSocketIvms() {
    if (socketmotion != null) {
      socketmotion!.disconnect();
      socketmotion!.onDisconnect((_) => debugPrint("socketmotion disconnected"));
      socketmotion!.clearListeners();
      debugPrint("socketmotion closed");
    } else {
      debugPrint('socketmotion not initialized');
    }
  }

  void webSocketMotionReceiverIvms(
      BuildContext context, String eventName, Function(dynamic) onEvent) {
    if (socketmotion != null) {
      socketmotion!.on(eventName, onEvent);
    } else {
      debugPrint('socketmotion not initialized');
    }
  }


}
