import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TextPopup extends TextBoxComponent {
  late Paint paint;
  late RRect bgRect;

  TextPopup(
    String text,
    bool isRed, {
    super.position,
    super.align,
    super.size,
    super.anchor,
    double? fontSize,
    double? timePerChar,
  }) : super(
          text: text,
          textRenderer: TextPaint(
              style: TextStyle(
            fontSize: fontSize ?? 18.0,
            color: isRed ? Colors.red.shade100 : Colors.lightGreenAccent,
            fontFamily: 'monospace',
            letterSpacing: 2.0,
          )),
          boxConfig: TextBoxConfig(
            timePerChar: 0.05,
          ),
        );

  @override
  Future<void> onLoad() {
    paint = Paint();
    bgRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, width, height), const Radius.circular(15.0));

    paint.color = Colors.black.withAlpha(150);
    return super.onLoad();
  }

  @override
  void drawBackground(Canvas c) {
    super.drawBackground(c);
    c.drawColor(Colors.transparent, BlendMode.clear);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(bgRect, paint);
    super.render(canvas);
  }
}
