import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_game/game_core/main_loop.dart';
import 'package:flutter_game/utils/global_var.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final ReceivePort _receivePort = ReceivePort();
  late final Isolate _isolateLoop;
  // late Player player;

  void _startIsolateLoop() async {
    _isolateLoop = await Isolate.spawn(mainLoop, _receivePort.sendPort);
    _receivePort.listen((message) {
      GlobalVars.currentScene.update();
      setState(() {});
    });
  }

  @override
  void initState() {
    _startIsolateLoop();
    super.initState();
  }

  @override
  void dispose() {
    _receivePort.close();
    _isolateLoop.kill();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (isFirstStartGame) {
    //   isFirstStartGame = false;
    //   player = Player();
    // }

    // player.update();
    return GlobalVars.currentScene.sceneBuild();
  }
}
