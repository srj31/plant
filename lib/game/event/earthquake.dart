import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/event/event.dart';
import 'package:game_name/game/our_game.dart';

class Earthquake extends GameEvent {
  Earthquake({required OurGame game, super.priority}) : super(game: game);
  @override
  void handleEvent() {
    var rng = Random();
    final cameraShake = SequenceEffect([
      MoveEffect.by(Vector2(50, 0), ZigzagEffectController(period: 0.25)),
      MoveEffect.by(Vector2(30, 0), ZigzagEffectController(period: 0.25)),
      MoveEffect.by(Vector2(40, 0), ZigzagEffectController(period: 0.5)),
      MoveEffect.by(Vector2(20, 0), ZigzagEffectController(period: 0.5)),
    ]);
    AudioManager.playSfx("earthquake.wav", game.soundVolume * 0.7);
    for (var i = 0; i < game.builtItems.length; i++) {
      if (rng.nextDouble() < 0.2) game.removeBuiltItem(i);
    }

    game.camera.viewfinder.add(cameraShake);
  }
}
