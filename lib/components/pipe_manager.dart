import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter_flappy_bird_game/components/pipe.dart';
import 'package:flutter_flappy_bird_game/constants.dart';
import 'package:flutter_flappy_bird_game/game.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  /*
 UPDATE EVERY SECOND DT
 SPAWN NEW PIPES EVERY SECOND
 */

  double pipeSpawnTimer = 0;

  @override
  void update(double dt) {
    // generate new pipes at given interval
    pipeSpawnTimer += dt;
    const double pipeInterval = pipeSpawnInterval;

    if (pipeSpawnTimer > pipeInterval) {
      pipeSpawnTimer = 0;
      spawnPipe();
    }
  }

  /*
 SPAWN NEW PIPES
  */

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;

    /*
    CALCULATE PIPE HEIGHT
  */

    // max possible height
    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    // height of bottom pipe -> randomly select between min and max
    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    // height of top pipe
    final double topPipeHeight =
        screenHeight - groundHeight - pipeGap - bottomPipeHeight;

    /* 
    CREATE BOTTOM PIPE 
    */

    final bottomPipe = Pipe(
      // position
      Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
      // size
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );

    /* 
    CREATE TOP PIPE 
    */

    final topPipe = Pipe(
      // position
      Vector2(gameRef.size.x, 0),
      // size
      Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true,
    );

    // add both pipes to the game
    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
