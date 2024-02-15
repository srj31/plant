import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:game_name/game/event/event.dart';
import 'package:game_name/game/our_game.dart';

class Earthquake extends GameEvent {
  Earthquake({required OurGame game, super.priority}) : super(game: game);
  @override
  void handleEvent() {
    var rng = Random();
    final cameraShake = MoveEffect.by(
      Vector2(0, 3),
      ZigzagEffectController(period: 0.2),
    );
    for (var i = 0; i < game.builtItems.length; i++) {
      if (rng.nextDouble() < 0.2) game.removeBuiltItem(i);
    }

    game.camera.viewfinder.add(cameraShake);
  }
}
