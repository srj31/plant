import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BannerComponent extends PositionComponent {
  final double borderSize;
  final Paint? backgroundPaint;
  final Paint? borderPaint;
  var brown = Paint()..color = Colors.brown.shade200;
  var darkGreen = Paint()..color = Colors.brown.shade300;

  BannerComponent({
    super.position,
    super.size,
    super.scale,
    super.priority = 5,
    super.anchor,
    this.borderSize = 0,
    this.backgroundPaint,
    this.borderPaint,
  }) {
    var banner = PolygonComponent([
      Vector2(size.y / 3, 0),
      Vector2(size.x - size.y / 3, 0),
      Vector2(size.x, size.y / 3),
      Vector2(size.x, 2 * size.y / 3),
      Vector2(size.x - size.y / 3, size.y),
      Vector2(size.y / 3, size.y),
      Vector2(0, 2 * size.y / 3),
      Vector2(0, size.y / 3),
    ],
        paint: backgroundPaint ?? darkGreen
          ..shader = ui.Gradient.linear(
            Offset.zero,
            Offset(0, size.y),
            [
              Colors.brown.shade300,
              Colors.brown.shade500,
            ],
          ));
    var border = PolygonComponent([
      Vector2(size.y / 3, -borderSize),
      Vector2(size.x - size.y / 3, -borderSize),
      Vector2(size.x + borderSize, size.y / 3),
      Vector2(size.x + borderSize, 2 * size.y / 3),
      Vector2(size.x - size.y / 3, size.y + borderSize),
      Vector2(size.y / 3, size.y + borderSize),
      Vector2(-borderSize, 2 * size.y / 3),
      Vector2(-borderSize, size.y / 3),
    ],
        paint: borderPaint ?? brown
          ..shader = ui.Gradient.linear(
            Offset.zero,
            Offset(0, size.y),
            [
              Colors.brown.shade200,
              Colors.brown.shade400,
            ],
          ));

    add(border);
    add(banner);
  }
}
