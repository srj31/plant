import 'package:flame/components.dart';
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
    removeFromParent();
    super.removeFromParent();
    onTap();
  }

  @override
  void render(Canvas canvas) {
    if (isRemoved) {
      return;
    }
    final center = Offset(size.x / 2, size.y / 2);
    final radius = size.x;

    // The circle should be paint before or it will be hidden by the path
    Paint paintCircle = Paint()..color = Colors.black;
    Paint paintBorder = Paint()
      ..color = Colors.white
      ..strokeWidth = size.x / 36
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paintCircle);
    canvas.drawCircle(center, radius, paintBorder);
    super.render(canvas);
  }
}
