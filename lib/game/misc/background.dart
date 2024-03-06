import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class BackgroundTile extends ParallaxComponent {
  BackgroundTile({
    position,
  }) : super(
          position: position,
        );

  @override
  FutureOr<void> onLoad() async {
    priority = -1000;
    size = Vector2(120, 140);
    parallax = await game.loadParallax([
      ParallaxImageData('background/water.png'),
      ParallaxImageData('background/water2.png')
    ],
        baseVelocity: Vector2(0, 0),
        velocityMultiplierDelta: Vector2(0, 0.5),
        repeat: ImageRepeat.repeat,
        fill: LayerFill.none);
    return super.onLoad();
  }
}
