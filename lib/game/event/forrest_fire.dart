import 'dart:math';

import 'package:game_name/game/event/event.dart';
import 'package:game_name/game/our_game.dart';

class ForrestFire extends GameEvent {
  ForrestFire({required OurGame game, super.priority}) : super(game: game);

  @override
  handleEvent() {
    // TODO: implement handleEvent
    var rng = Random();
    for (var i = 0; i < game.trees.length; i++) {
      if (rng.nextDouble() < 0.3) {
        game.carbonEmission += 1.0;
        game.removeTree(i);
      }
    }
  }
}
