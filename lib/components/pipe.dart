import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_flappy_bird_game/constants.dart';
import 'package:flutter_flappy_bird_game/game.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  // determine if it is a top or buttom pipe
  final bool isTopPipe;

  // scored
  bool hasScored = false;

  // init
  Pipe(Vector2 position, Vector2 size, {required this.isTopPipe})
      : super(position: position, size: size);

  /* 
  LOAD PIPE SPRITE 
  */

  @override
  FutureOr<void> onLoad() async {
    // load pipe sprite
    sprite = await Sprite.load(isTopPipe ? "top_pipe.png" : "bottom_pipe.png");

    // add hitbox for collision detection
    add(RectangleHitbox());
  }

  /* 
  UPDATE EVERY SECOND  
  */

  @override
  void update(double dt) {
    // update pipe position to the left
    position.x -= groundScrollingSpeed * dt;

    // check if bird has passed the pipe to increment score
    if (!hasScored && position.x + size.x < gameRef.bird.position.x) {
      hasScored = true;

      // only increment score once per pipe
      if (isTopPipe) {
        gameRef.incrementScore();
      }
    }

    // remove pipe if it goes off screen
    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
