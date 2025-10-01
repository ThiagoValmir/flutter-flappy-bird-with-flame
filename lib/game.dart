import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flappy_bird_game/components/background.dart';
import 'package:flutter_flappy_bird_game/components/bird.dart';
import 'package:flutter_flappy_bird_game/components/ground.dart';
import 'package:flutter_flappy_bird_game/components/pipe.dart';
import 'package:flutter_flappy_bird_game/components/pipe_manager.dart';
import 'package:flutter_flappy_bird_game/components/score.dart';
import 'package:flutter_flappy_bird_game/constants.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
/* 
 Basic Game Components:
  - Bird
  - Background
  - ground
  - pipes 
  - score 
*/

  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

  /*
  LOAD GAME
  */

  @override
  FutureOr<void> onLoad() {
    // load background component
    background = Background(size);
    add(background);
    // load bird component
    bird = Bird();
    add(bird);
    // load ground component
    ground = Ground();
    add(ground);
    // load pipes
    pipeManager = PipeManager();
    add(pipeManager);
    // load score text
    scoreText = ScoreText();
    add(scoreText);
  }

  /*
  TAP DETECTOR
  */

  @override
  void onTap() {
    bird.flap();
  }

  /*
  SCORE
  */

  int score = 0;

  void incrementScore() {
    score += 1;
  }

  /*
  GAME OVER
  */

  bool isGameOver = false;

  void gameOver() {
    // prevent multiple game over calls
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    // show dialog box for the user
    showDialog(
        context: buildContext!,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: const Text("Game over"),
              content: Text("Your score: $score"),
              actions: [
                TextButton(
                  onPressed: () {
                    // pop the box
                    Navigator.of(context).pop();
                    // restart game
                    resetGame();
                  },
                  child: const Text("Restart"),
                ),
              ],
            ));
  }

  void resetGame() {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    score = 0;
    isGameOver = false;
    resumeEngine();
    children.whereType<Pipe>().forEach((pipe) {
      pipe.removeFromParent();
    });
  }
}
