import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_flappy_bird_game/components/ground.dart';
import 'package:flutter_flappy_bird_game/components/pipe.dart';
import 'package:flutter_flappy_bird_game/constants.dart';
import 'package:flutter_flappy_bird_game/game.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
/*
 INIT BIRD  
*/

// initialize bird position and size

  Bird()
      : super(
            position: Vector2(birdStartX, birdStartY),
            size: Vector2(birdWidth, birdHeight));

// physical world properties
  double velocity = 0;

/*
 LOAD BIRD  
*/

  @override
  FutureOr<void> onLoad() async {
    // load bird sprite image
    sprite = await Sprite.load('bird.png');
    // add hitbox
    add(RectangleHitbox());
  }

/*
 JUMP / FLAP
*/

  void flap() {
    velocity = jumpStrength;
  }

/*
 UPDATE EVERY SECOND
*/

  @override
  void update(double dt) {
    // aply gravity to velocity
    velocity += gravity * dt;

    // update bird position based on velocity
    position.y += velocity * dt;
  }

/*
 COLLISION WITH ANOTHER OBJECT
*/

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);

    // check if bird collides with the ground
    if (other is Ground) {
      (parent as FlappyBirdGame).gameOver();
    }
    // check if bird collides with the pipes
    if (other is Pipe) {
      (parent as FlappyBirdGame).gameOver();
    }
  }
}
