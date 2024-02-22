import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BannerComponent extends PositionComponent {
  final double borderSize;
  var brown = Paint()..color = Colors.brown.shade200;
  var darkGreen = Paint()..color = Colors.brown.shade300;

  BannerComponent({
    super.position,
    super.size,
    super.scale,
    super.priority = 5,
    super.anchor,
    this.borderSize = 0,
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
    ], paint: darkGreen);
    var border = PolygonComponent([
      Vector2(size.y / 3, -borderSize),
      Vector2(size.x - size.y / 3, -borderSize),
      Vector2(size.x + borderSize, size.y / 3),
      Vector2(size.x + borderSize, 2 * size.y / 3),
      Vector2(size.x - size.y / 3, size.y + borderSize),
      Vector2(size.y / 3, size.y + borderSize),
      Vector2(-borderSize, 2 * size.y / 3),
      Vector2(-borderSize, size.y / 3),
    ], paint: brown);

    add(border);
    add(banner);
  }
}
