// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

abstract class Entity {
  double x = 0;
  double y = 0;
  String spritName;
  bool visible = true;
  List sprites = [];
  int currentSprite = 0;
  int currentTick = 0;

  Entity(this.spritName) {
    for (var i = 0; i < 4; i++) {
      sprites.add(Image.asset('assets/$spritName$i.png'));
    }
  }
  void _animate() {
    currentTick++;
    if (currentTick > 15) {
      currentSprite++;
      currentTick = 0;
    }
    if (currentSprite > 3) {
      currentSprite = 0;
    }
  }

  void update() {
    _animate();
    move();
  }

  void move();
  Widget build();
}
