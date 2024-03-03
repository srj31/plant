import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/our_game.dart';
import 'package:just_audio/just_audio.dart';

class BubblePopup extends SpriteComponent
    with TapCallbacks, HasGameReference<OurGame> {
  BubblePopup(
      {required super.sprite,
      required super.position,
      super.priority,
      super.size,
      super.scale,
      required this.onTap});

  Function() onTap;

  var isDisplayed = false;

  @override
  void onTapDown(TapDownEvent event) {
    addAll([
      OpacityEffect.fadeOut(
        LinearEffectController(0.05),
        target: this,
        onComplete: removeFromParent,
      ),
      ScaleEffect.by(
        Vector2.all(1.1),
        LinearEffectController(0.05),
      ),
    ]);
    AudioManager.playSfx("tap_bubble.wav", game.soundVolume);
    onTap();
  }

  @override
  void render(Canvas canvas) {
    if (isRemoved) {
      return;
    }

    final center = Offset(size.x / 2, size.y / 2);
    final radius = size.x * 0.7;

    // The circle should be paint before or it will be hidden by the path
    Paint paintTri = Paint()..color = Colors.green.shade400;
    Paint paintCircle = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(0, size.y),
        [
          Colors.lightGreen.shade400,
          Colors.green.shade400,
        ],
      );
    canvas.drawCircle(center, radius, paintCircle);
    canvas.drawVertices(
        ui.Vertices(VertexMode.triangles, [
          Offset(0, size.y),
          Offset(size.x, size.y),
          Offset(size.x / 2, 1.5 * size.y)
        ]),
        BlendMode.plus,
        paintTri);

    super.render(canvas);
  }
}
