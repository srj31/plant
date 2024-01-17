import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

import 'package:flame/events.dart';
import 'package:flame/game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: TiledGame());
  }
}

class TiledGame extends FlameGame with ScaleDetector, TapDetector {
  late TiledComponent mapComponent;

  static const double _minZoom = 0.1;
  static const double _maxZoom = 2.0;
  double _startZoom = _minZoom;

  @override
  Color backgroundColor() =>
      const Color(0x00000000); // Must be transparent to show the background

  @override
  Future<void> onLoad() async {
    camera.viewfinder
      ..zoom = _startZoom
      ..anchor = Anchor.topLeft;

    mapComponent = await TiledComponent.load(
      'game.tmx',
      Vector2(64, 73),
    );
    world.add(mapComponent);
  }

  @override
  void onScaleStart(ScaleStartInfo info) {
    _startZoom = camera.viewfinder.zoom;
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    final currentScale = info.scale.global;

    if (currentScale.isIdentity()) {
      // One-finger gesture
      _processDrag(info);
    } else {
      // Several fingers gesture
      _processScale(info, currentScale);
    }
  }

  @override
  void onScaleEnd(ScaleEndInfo info) {
    _checkScaleBorders();
    _checkDragBorders();
  }

  void _processDrag(ScaleUpdateInfo info) {
    final delta = info.delta.global;
    final zoomDragFactor = 1.0 /
        _startZoom; // To synchronize a drag distance with current zoom value
    final currentPosition = camera.viewfinder.position;

    camera.viewfinder.position = currentPosition.translated(
      -delta.x * zoomDragFactor,
      -delta.y * zoomDragFactor,
    );
  }

  void _processScale(ScaleUpdateInfo info, Vector2 currentScale) {
    final newZoom = _startZoom * ((currentScale.y + currentScale.x) / 2.0);
    camera.viewfinder.zoom = newZoom.clamp(_minZoom, _maxZoom);
  }

  void _checkScaleBorders() {
    camera.viewfinder.zoom = camera.viewfinder.zoom.clamp(_minZoom, _maxZoom);
  }

  void _checkDragBorders() {
    final worldRect = camera.visibleWorldRect;

    final currentPosition = camera.viewfinder.position;

    final mapSize = Offset(mapComponent.width, mapComponent.height);

    var xTranslate = 0.0;
    var yTranslate = 0.0;

    if (worldRect.topLeft.dx < 0.0) {
      xTranslate = -worldRect.topLeft.dx;
    } else if (worldRect.bottomRight.dx > mapSize.dx) {
      xTranslate = mapSize.dx - worldRect.bottomRight.dx;
    }

    if (worldRect.topLeft.dy < 0.0) {
      yTranslate = -worldRect.topLeft.dy;
    } else if (worldRect.bottomRight.dy > mapSize.dy) {
      yTranslate = mapSize.dy - worldRect.bottomRight.dy;
    }

    camera.viewfinder.position =
        currentPosition.translated(xTranslate, yTranslate);
  }
}
