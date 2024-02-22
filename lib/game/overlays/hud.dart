import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:game_name/game/overlays/banner.dart';
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

    final style = TextStyle(
      fontSize: 20.0, // Change the font size here
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.varelaRound().fontFamily,
    );
    final regular = TextPaint(style: style);
    final larger = TextPaint(
        style: style.copyWith(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.varelaRound().fontFamily,
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
  }
}
