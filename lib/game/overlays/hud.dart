import 'package:flutter/material.dart';

import 'package:flame/components.dart';

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
    print(game.size);

    double widthOfEach = game.size.x / 6;
    double height = game.size.y - 50;
    const double sizeOfSpirte = 32;

    Paint hudBackground = Paint()..color = const Color(0xFF000000);
    await add(RectangleComponent.fromRect(
      Rect.fromLTWH(0, game.size.y - 50, game.size.x, 50),
      paint: hudBackground,
    ));

    await add(HeartHealthComponent(
      position: Vector2(0, height),
      size: Vector2.all(sizeOfSpirte),
    ));

    await add(HeartHealthComponent(
      position: Vector2(widthOfEach, height),
      size: Vector2.all(sizeOfSpirte),
    ));
    await add(HeartHealthComponent(
      position: Vector2(widthOfEach * 2, height),
      size: Vector2.all(sizeOfSpirte),
    ));
    await add(HeartHealthComponent(
      position: Vector2(widthOfEach * 3, height),
      size: Vector2.all(sizeOfSpirte),
    ));
    await add(HeartHealthComponent(
      position: Vector2(widthOfEach * 4, height),
      size: Vector2.all(sizeOfSpirte),
    ));
    await add(HeartHealthComponent(
      position: Vector2(widthOfEach * 5, height),
      size: Vector2.all(sizeOfSpirte),
    ));

    _healthTextComponent = addTextComponent(
        '${game.health}', Vector2(sizeOfSpirte + 20, height + 15));
    _moraleTextComponent = addTextComponent('${game.morale}',
        Vector2(sizeOfSpirte + 20 + widthOfEach, height + 15));

    _carbonEmissionTextComponent = addTextComponent('${game.carbonEmission}',
        Vector2(sizeOfSpirte + 20 + 2 * widthOfEach, height + 15));
    _resourcesTextComponent = addTextComponent('${game.resources}',
        Vector2(sizeOfSpirte + 20 + 3 * widthOfEach, height + 15));
    _energyTextComponent = addTextComponent('${game.energy}',
        Vector2(sizeOfSpirte + 20 + 4 * widthOfEach, height + 15));
    _capitalTextComponent = addTextComponent('${game.capital}',
        Vector2(sizeOfSpirte + 20 + 5 * widthOfEach, height + 15));
  }

  TextComponent addTextComponent(String text, Vector2 position) {
    TextComponent component = TextComponent(
      text: text,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      anchor: Anchor.center,
      position: position,
    );

    add(component);
    return component;
  }

  @override
  void update(double dt) {
    _healthTextComponent.text = '${game.health}';
    _moraleTextComponent.text = '${game.morale}';
    _carbonEmissionTextComponent.text = '${game.carbonEmission}';
    _resourcesTextComponent.text = '${game.resources}';
    _energyTextComponent.text = '${game.energy}';
    _capitalTextComponent.text = '${game.capital}';
  }
}
