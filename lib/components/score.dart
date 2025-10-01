import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flappy_bird_game/game.dart';

class ScoreText extends TextComponent with HasGameRef<FlappyBirdGame> {
  ScoreText()
      : super(
            text: "0",
            textRenderer: TextPaint(
                style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            )));

  // load the score text
  @override
  FutureOr<void> onLoad() {
    // set the position to lower middle
    position = Vector2(
      // center horizontally
      (gameRef.size.x - size.x) / 2,
      gameRef.size.y - size.y - 50,
    );
  }

  // update method
  @override
  void update(double dt) {
    final newText = gameRef.score.toString();
    if (text != newText) {
      text = newText;
    }
  }
}
