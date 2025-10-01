import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_flappy_bird_game/constants.dart';
import 'package:flutter_flappy_bird_game/game.dart';

class Ground extends SpriteComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Ground() : super();

  // load ground sprite image
  @override
  Future<void> onLoad() async {
    // set size and position
    size = Vector2(2 * gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y - groundHeight);

    // load ground sprite image
    sprite = await Sprite.load("ground.png");

    // add hitbox
    add(RectangleHitbox());
  }

  // UPDATE EVERY SECOND
  @override
  void update(double dt) {
    // move ground to the left
    position.x -= groundScrollingSpeed * dt;
    // reset ground position when it goes off screen
    // if half of the ground is off screen, reset position
    if (position.x + size.x / 2 <= 0) {
      position.x = 0;
    }
  }
}
