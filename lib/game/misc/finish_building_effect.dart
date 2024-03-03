import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/our_game.dart';

class FinishBuildingEffect extends SpriteAnimationComponent
    with HasGameReference<OurGame> {
  FinishBuildingEffect({
    required super.position,
    super.priority,
    super.size,
    super.scale,
  });
  @override
  FutureOr<void> onLoad() async {
    parent!.addAll([
      SequenceEffect([
        ColorEffect(
          const Color(0xFFFFFFFF),
          EffectController(duration: 0.45),
          opacityTo: 1,
          opacityFrom: 0.2,
        ),
        ColorEffect(
          const Color(0xFFFFFFFF),
          EffectController(duration: 0.45),
          opacityTo: 0.0,
          opacityFrom: 1,
        )
      ]),
      SequenceEffect([
        ScaleEffect.by(Vector2(0.9, 1.2), LinearEffectController(0.15)),
        ScaleEffect.by(Vector2(1 / 0.9, 1 / 1.2), LinearEffectController(0.15)),
        ScaleEffect.by(Vector2(1.2, 0.9), LinearEffectController(0.15)),
        ScaleEffect.by(Vector2(1 / 1.2, 1 / 0.9), LinearEffectController(0.15)),
        ScaleEffect.by(Vector2(0.9, 1.2), LinearEffectController(0.15)),
        ScaleEffect.by(Vector2(1 / 0.9, 1 / 1.2), LinearEffectController(0.15)),
      ])
    ]);
    removeOnFinish = true;
    animation = SpriteAnimation.fromFrameData(
      await game.images.load('built_complete.png'),
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.1,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );
  }
}
