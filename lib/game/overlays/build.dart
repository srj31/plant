import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'package:flame/events.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/misc/item_card.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/structures/ev_factory.dart';
import 'package:game_name/game/structures/green_hydrogen.dart';
import 'package:game_name/game/structures/recycling_factory.dart';
import 'package:game_name/game/structures/windmill.dart';

class BuildComponent extends SpriteComponent
    with TapCallbacks, HasGameReference<OurGame> {
  BuildComponent({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    sprite = Sprite(await Flame.images.load('build.png'));
    position = Vector2(50, 50);
    size = Vector2.all(32);
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.overlays.add(BuildMenu.id);
    AudioManager.playSfx('opening_overlay.wav', game.soundVolume);
  }
}

class BuildMenu extends StatelessWidget {
  static const id = 'BuildMenu';
  final OurGame game;

  const BuildMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          game.overlays.remove(id);
        },
        child: Scaffold(
          backgroundColor: Colors.black.withAlpha(100),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ItemCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      EvFactory(),
                      game.getSpriteFromSheet("ev_factory.png"),
                      "EV Factory",
                      "Establish your Electric Vehicle (EV) factory, produce eco-friendly cars, and ride the wave of sustainability.",
                      true,
                      BuildMenu.id),
                  ItemCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      WindMill(),
                      game.getSpriteFromSheet("windmill.png"),
                      "Wind Energy",
                      "Capitalize on the wind's force to boost your Energy production, reduce Carbon Emission, and strengthen Earth's health",
                      true,
                      BuildMenu.id),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ItemCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      GreenHydrogen(),
                      game.getSpriteFromSheet("green_hydrogen.png"),
                      "Green Hydrogen",
                      "A strategic, long-term investment for players aiming for advanced and low-carbon energy solutions",
                      true,
                      BuildMenu.id),
                  ItemCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      RecyclingFactory(),
                      game.getSpriteFromSheet("recycling_factory.png"),
                      "Recycling Factory",
                      "Process and recycle waste materials, reducing overall pollution and promoting a circular economy",
                      true,
                      BuildMenu.id),
                ])
              ],
            ),
          ),
        ));
  }
}
