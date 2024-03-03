import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:game_name/game/overlays/banner.dart';
import 'package:game_name/game/overlays/sun.dart';
import 'package:game_name/game/overlays/wind.dart';
import 'package:google_fonts/google_fonts.dart';

import '../our_game.dart';
import 'heart.dart';

class Hud extends PositionComponent with HasGameReference<OurGame> {
  Hud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  });

  late TextComponent _healthTextComponent;
  late TextComponent _moraleTextComponent;
  late TextComponent _carbonEmissionTextComponent;
  late TextComponent _resourcesTextComponent;
  late TextComponent _energyTextComponent;
  late TextComponent _capitalTextComponent;
  late TextComponent _temperatureTextComponent;
  late TextComponent _temperatureTextComponent2;
  late TextComponent _windTextComponent;
  late TextComponent _windTextComponent2;
  late TextComponent _timeTextComponent;

  @override
  Future<void> onLoad() async {
    double widthOfEach = game.size.x * 0.1;
    const double sizeOfSpirte = 32;

    Vector2 bannerSize = Vector2(game.size.x * 0.4, game.size.y * 0.1);

    Vector2 position = Vector2(game.size.x * 0.55, game.size.y * 0.05);

    await add(
        BannerComponent(position: position, size: bannerSize, borderSize: 5));

    await add(HeartHealthComponent(
      position: Vector2(game.size.x * 0.05, game.size.y * 0.1),
      size: Vector2.all(sizeOfSpirte),
      scale: Vector2.all(1.5),
      anchor: Anchor.center,
    ));

    await add(SpriteComponent(
      sprite: game.moraleSprite,
      position: position + Vector2.all(bannerSize.y / 2),
      size: Vector2.all(sizeOfSpirte),
      priority: 100,
      anchor: Anchor.center,
    ));

    await add(SpriteComponent(
      sprite: game.carbonEmissionSprite,
      position:
          position + Vector2(widthOfEach, 0) + Vector2.all(bannerSize.y / 2),
      size: Vector2.all(sizeOfSpirte),
      priority: 100,
      anchor: Anchor.center,
    ));
    await add(SpriteComponent(
      sprite: game.resourcesSprite,
      position: position +
          Vector2(2 * widthOfEach, 0) +
          Vector2.all(bannerSize.y / 2),
      size: Vector2.all(sizeOfSpirte),
      priority: 100,
      anchor: Anchor.center,
    ));

    await add(SpriteComponent(
      sprite: game.energySprite,
      position: position +
          Vector2(3 * widthOfEach, 0) +
          Vector2.all(bannerSize.y / 2),
      size: Vector2.all(sizeOfSpirte),
      priority: 100,
      anchor: Anchor.center,
    ));

    await add(SpriteComponent(
      sprite: game.capitalSprite,
      position: Vector2(game.size.x * 0.8, game.size.y * 0.9),
      size: Vector2.all(sizeOfSpirte),
      scale: Vector2.all(1.5),
      anchor: Anchor.center,
    ));

    await add(WeatherComponent(
      position: Vector2(game.size.x * 0.35, game.size.y * 0.10),
      size: Vector2.all(sizeOfSpirte),
      anchor: Anchor.center,
    ));

    await add(WindComponent(
        position: Vector2(game.size.x * 0.25, game.size.y * 0.10),
        size: Vector2.all(sizeOfSpirte),
        anchor: Anchor.center));

    await add(SpriteComponent(
      sprite: Sprite(await Flame.images.load("time.png")),
      position: Vector2(game.size.x * 0.2, game.size.y * 0.9),
      size: Vector2.all(sizeOfSpirte),
      anchor: Anchor.center,
    ));

    final style = TextStyle(
      fontSize: 20.0, // Change the font size here
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.play().fontFamily,
    );
    final regular = TextPaint(style: style);
    final larger = TextPaint(
        style: style.copyWith(
      fontSize: 30.0,
      fontWeight: FontWeight.w600,
      fontFamily: GoogleFonts.play().fontFamily,
    ));

    final style2 = TextStyle(
      fontSize: 15.0, // Change the font size here
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.play().fontFamily,
      color: Colors.black,
    );

    final small = TextPaint(style: style2);

    final small2 = TextPaint(
        style: style2.copyWith(
      decorationStyle: TextDecorationStyle.dotted,
      foreground: Paint()
        ..color = Colors.white
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
      fontFamily: GoogleFonts.play().fontFamily,
    ));

    _healthTextComponent = addTextComponent('${game.health}',
        Vector2(game.size.x * 0.05 + 32 * 2, game.size.y * 0.1))
      ..anchor = Anchor.center
      ..textRenderer = larger;

    _moraleTextComponent = addTextComponent(
        '${game.morale}',
        position +
            Vector2.all(bannerSize.y * 0.5) +
            Vector2(sizeOfSpirte * 1.5, 0))
      ..anchor = Anchor.center
      ..textRenderer = regular;

    _carbonEmissionTextComponent = addTextComponent(
        '${game.carbonEmission}',
        position +
            Vector2.all(bannerSize.y * 0.5) +
            Vector2(sizeOfSpirte * 1.5 + widthOfEach, 0))
      ..anchor = Anchor.center
      ..textRenderer = regular;

    _resourcesTextComponent = addTextComponent(
        '${game.resources}',
        position +
            Vector2.all(bannerSize.y * 0.5) +
            Vector2(sizeOfSpirte * 1.5 + 2 * widthOfEach, 0))
      ..anchor = Anchor.center
      ..textRenderer = regular;

    _energyTextComponent = addTextComponent(
        '${game.energy}',
        position +
            Vector2.all(bannerSize.y * 0.5) +
            Vector2(sizeOfSpirte * 1.5 + 3 * widthOfEach, 0))
      ..anchor = Anchor.center
      ..textRenderer = regular;

    _capitalTextComponent = addTextComponent('${game.capital}',
        Vector2(game.size.x * 0.8 + sizeOfSpirte * 2, game.size.y * 0.9))
      ..anchor = Anchor.center
      ..textRenderer = regular;

    _temperatureTextComponent2 = addTextComponent('${game.temperature}',
        Vector2(game.size.x * 0.35 + sizeOfSpirte, game.size.y * 0.1))
      ..anchor = Anchor.center
      ..textRenderer = small2;

    _temperatureTextComponent = addTextComponent('${game.temperature}',
        Vector2(game.size.x * 0.35 + sizeOfSpirte, game.size.y * 0.1))
      ..anchor = Anchor.center
      ..textRenderer = small;

    _windTextComponent2 = addTextComponent('${game.windSpeed}',
        Vector2(game.size.x * 0.25 + sizeOfSpirte, game.size.y * 0.1))
      ..anchor = Anchor.center
      ..textRenderer = small2;

    _windTextComponent = addTextComponent('${game.windSpeed}',
        Vector2(game.size.x * 0.25 + sizeOfSpirte, game.size.y * 0.1))
      ..anchor = Anchor.center
      ..textRenderer = small;

    _timeTextComponent = addTextComponent('${game.elapsedSecs}',
        Vector2(game.size.x * 0.2 + sizeOfSpirte, game.size.y * 0.9))
      ..anchor = Anchor.center
      ..textRenderer = regular;
  }

  TextComponent addTextComponent(String text, Vector2 position) {
    TextComponent component = TextComponent(
        text: text, anchor: Anchor.center, position: position, priority: 100);

    add(component);
    return component;
  }

  @override
  void update(double dt) {
    _healthTextComponent.text = game.health.toStringAsFixed(1);
    _moraleTextComponent.text = game.morale.toStringAsFixed(1);
    _carbonEmissionTextComponent.text = game.carbonEmission.toStringAsFixed(1);
    _resourcesTextComponent.text = game.resources.toStringAsFixed(1);
    _energyTextComponent.text = game.energy.toStringAsFixed(1);
    _capitalTextComponent.text = "\$${game.capital.toStringAsFixed(1)}";
    _temperatureTextComponent.text = game.temperature.toStringAsFixed(1);
    _temperatureTextComponent2.text = game.temperature.toStringAsFixed(1);
    _windTextComponent.text = game.windSpeed.toStringAsFixed(1);
    _windTextComponent2.text = game.windSpeed.toStringAsFixed(1);
    _timeTextComponent.text = game.elapsedSecs.toStringAsFixed(0);
  }
}
