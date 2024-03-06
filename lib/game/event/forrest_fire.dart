import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/event/event.dart';
import 'package:game_name/game/misc_structures/tree.dart';
import 'package:game_name/game/our_game.dart';

class ForrestFire extends GameEvent {
  ForrestFire({required OurGame game, super.priority}) : super(game: game);

  @override
  handleEvent() {
    var rng = Random();
    AudioManager.playSfx("forrest_fire.wav", game.soundVolume);
    for (var i = 0; i < game.trees.length; i++) {
      if (rng.nextDouble() < 0.3) {
        game.carbonEmission += 1.0;
        _addFlame(game.trees[i]);
        game.removeTree(i);
      }
    }
  }

  Vector2 getRandomVector() {
    final random = Random();
    return (Vector2.random(random) - Vector2.random(random)) * 30;
  }

  Paint getFlameColor() {
    final random = Random();
    if (random.nextDouble() < 0.3) {
      return Paint()..color = Colors.orange.shade700;
    }
    if (random.nextDouble() < 0.6) {
      return Paint()..color = Colors.yellow.shade700;
    }
    return Paint()..color = Colors.red;
  }

  void _addFlame(TreeStructure tree) {
    tree.add(ParticleSystemComponent(
      particle: Particle.generate(
        count: 20,
        lifespan: 20,
        generator: (i) => AcceleratedParticle(
          acceleration: getRandomVector(),
          speed: getRandomVector(),
          position: Vector2(60, 70),
          child: CircleParticle(
            radius: 5,
            paint: getFlameColor(),
          ),
        ),
      ),
    ));
  }
}
