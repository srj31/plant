import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class TextPopup extends TextBoxComponent {
  late Paint paint;
  late Rect bgRect;

  TextPopup(
    String text,
    bool isRed, {
    super.position,
    super.align,
    super.size,
    super.anchor,
    double? timePerChar,
  }) : super(
          text: text,
          textRenderer: TextPaint(
              style: TextStyle(
            fontSize: 18.0,
            color: isRed ? Colors.red.shade100 : Colors.lightGreenAccent,
            fontFamily: 'monospace',
            letterSpacing: 2.0,
          )),
          boxConfig: TextBoxConfig(
            maxWidth: 400,
            timePerChar: timePerChar ?? 0.05,
            growingBox: true,
            margins: const EdgeInsets.all(10.0),
          ),
        );

  @override
  Future<void> onLoad() {
    paint = Paint();
    bgRect = Rect.fromLTWH(0, 0, width, height);

    paint.color = Colors.black54;
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(bgRect, paint);
    super.render(canvas);
  }
}
