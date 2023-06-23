import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_game/entities/bullet.dart';
import 'package:flutter_game/entities/player.dart';
import 'package:flutter_game/scenes/app_scene.dart';
import 'package:flutter_game/utils/global_var.dart';

class GameScene extends AppScene {
  GameScene();
  double _startGlobalPosition = 0.0;
  final Player _player = Player();
  List<Bullet> _listBullets = [];
  List<Widget> _listWidgets = [];
  @override
  Widget sceneBuild() {
    return Stack(
      children: [
        _player.build(),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.green)),
              width: GlobalVars.screenWidth / 2,
              height: GlobalVars.screenHeight,
              child: GestureDetector(
                onPanStart: _onPanStart,
                onPanUpdate: _onPanUpdate,
              ),
            )),
        Positioned(
            top: 0,
            left: GlobalVars.screenWidth / 2,
            child: Container(
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.green)),
              width: GlobalVars.screenWidth / 2,
              height: GlobalVars.screenHeight / 2,
              child: GestureDetector(onTap: _onAcceleration),
            )),
        Positioned(
            top: GlobalVars.screenHeight / 2,
            left: GlobalVars.screenWidth / 2,
            child: Container(
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.green)),
              width: GlobalVars.screenWidth / 2,
              height: GlobalVars.screenHeight / 2,
              child: GestureDetector(onTap: _onShoot),
            )),
        Stack(
          children: _listWidgets,
        )
      ],
    );
  }

  @override
  void update() {
    _player.update();
    _listWidgets.clear();
    _listBullets.removeWhere((bullet) => !bullet.visible);
    for (var bullet in _listBullets) {
      _listWidgets.add(bullet.build());
      bullet.update();
    }
  }

  void _onPanStart(DragStartDetails details) {
    _startGlobalPosition = details.globalPosition.dx;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double updateGlobalPosition = details.globalPosition.dx;
    if (updateGlobalPosition > _startGlobalPosition + 30) {
      _player.isMoveRight = true;
    }
    if (updateGlobalPosition < _startGlobalPosition - 30) {
      _player.isMoveLeft = true;
    }
  }

  void _onAcceleration() {
    _player.isAcceleration = _player.isAcceleration ? false : true;
  }

  void _onShoot() {
    _listBullets.add(Bullet(
      playerAngle: _player.getAngle,
      playerX: _player.x,
      playerY: _player.y,
    ));
  }
}
