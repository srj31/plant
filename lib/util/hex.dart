import 'dart:math' as math;

import 'package:flame/game.dart';

class Hex {
  Hex.from(this.q, this.r, this.s);
  Hex(this.q, this.r) : s = -q - r;

  @override
  operator ==(o) => o is Hex && o.q == q && o.r == r && o.s == s;

  operator -(Hex o) => Hex(q - o.q, r - o.r);

  operator +(Hex o) => Hex(q - o.q, r - o.r);

  operator *(int i) => Hex(q * i, r * i);

  int hexLength(Hex hex) {
    return ((hex.q.abs() + hex.r.abs() + hex.s.abs()) / 2).floor();
  }

  int hexDistance(Hex a, Hex b) {
    return hexLength(a - b);
  }

  final int q;
  final int r;
  final int s;
}

class Orientation {
  final double f0, f1, f2, f3;
  final double b0, b1, b2, b3;
  final double start_angle; // in multiples of 60°
  Orientation(this.f0, this.f1, this.f2, this.f3, this.b0, this.b1, this.b2,
      this.b3, this.start_angle);
}

Orientation layout_pointy = Orientation(math.sqrt(3.0), math.sqrt(3.0) / 2.0,
    0.0, 3.0 / 2.0, math.sqrt(3.0) / 3.0, -1.0 / 3.0, 0.0, 2.0 / 3.0, 0.5);

class Layout {
  final Orientation orientation;
  final Vector2 size;
  final Vector2 origin;
  Layout(this.orientation, this.size, this.origin);
}

class FractionalHex {
  final double q, r, s;
  FractionalHex(this.q, this.r, this.s);
}

Vector2 pixelToOffset(Layout layout, Vector2 p) {
  return axialToOddR(pixelToHex(layout, p));
}

Hex pixelToHex(Layout layout, Vector2 p) {
  final Orientation M = layout.orientation;
  Vector2 pt = Vector2((p.x - layout.origin.x) / layout.size.x,
      (p.y - layout.origin.y) / layout.size.y);
  double q = M.b0 * pt.x + M.b1 * pt.y;
  double r = M.b2 * pt.x + M.b3 * pt.y;
  final hex = hexRound(FractionalHex(q, r, -q - r));
  final pixel = hexToPixel(layout, hex);
  return hex;
}

hexToPixel(Layout layout, Hex h) {
  final Orientation M = layout.orientation;
  double x = (M.f0 * h.q + M.f1 * h.r) * layout.size.x;
  double y = (M.f2 * h.q + M.f3 * h.r) * layout.size.y;
  return Vector2(x + layout.origin.x, y + layout.origin.y);
}

Hex hexRound(FractionalHex h) {
  int q = (h.q).round();
  int r = (h.r).round();
  int s = h.s.round();
  double qDiff = (q - h.q).abs();
  double rDiff = (r - h.r).abs();
  double sDiff = (s - h.s).abs();
  if (qDiff > rDiff && qDiff > sDiff) {
    q = -r - s;
  } else if (rDiff > sDiff) {
    r = -q - s;
  } else {
    s = -q - r;
  }
  return Hex.from(q, r, s);
}

axialToOddR(Hex hex) {
  var col = hex.q + (hex.r - (hex.r & 1)) / 2;
  var row = hex.r;
  return Vector2(row.floorToDouble(), col.floorToDouble());
}

Vector2 hex_corner_offset(Layout layout, int corner) {
  Vector2 size = layout.size;
  double angle = 2.0 * math.pi * (layout.orientation.start_angle + corner) / 6;
  return Vector2(size.x * math.cos(angle), size.y * math.sin(angle));
}

List<Vector2> polygon_corners(Layout layout, Hex h) {
  List<Vector2> corners = [];
  Vector2 center = hexToPixel(layout, h);
  for (int i = 0; i < 6; i++) {
    Vector2 offset = hex_corner_offset(layout, i);
    corners.add(Vector2(center.x + offset.x, center.y + offset.y));
  }
  return corners;
}
