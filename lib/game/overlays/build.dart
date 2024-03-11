import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'package:flame/events.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/misc/item_card.dart';
import 'package:game_name/game/our_game.dart';

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
    position = Vector2(game.size.x * 0.075, game.size.y * 0.25);
    size = Vector2.all(32);
    anchor = Anchor.center;
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
                      game.greenStructures[0].$1,
                      game.getSpriteFromSheet(game.greenStructures[0].$2),
                      true,
                      BuildMenu.id),
                  ItemCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      game.greenStructures[1].$1,
                      game.getSpriteFromSheet(game.greenStructures[1].$2),
                      true,
                      BuildMenu.id),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ItemCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      game.greenStructures[2].$1,
                      game.getSpriteFromSheet(game.greenStructures[2].$2),
                      true,
                      BuildMenu.id),
                  ItemCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      game.greenStructures[3].$1,
                      game.getSpriteFromSheet(game.greenStructures[3].$2),
                      true,
                      BuildMenu.id),
                ])
              ],
            ),
          ),
        ));
  }
}
