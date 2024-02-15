import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/our_game.dart';

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
    Paint paintCircle = Paint()..color = Colors.lightGreen;
    Paint paintBorder = Paint()
      ..color = Colors.lightGreenAccent
      ..strokeWidth = size.x / 36
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paintCircle);
    canvas.drawCircle(center, radius, paintBorder);
    super.render(canvas);
  }
}
