import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:flame/events.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/state/place_item.dart';
import 'package:game_name/game/structures/evFactory.dart';
import 'package:game_name/game/structures/greenHydrogen.dart';
import 'package:game_name/game/structures/recyclingFactory.dart';
import 'package:game_name/game/structures/structures.dart';
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
    sprite = game.getObjectSprite(690, 221, 20, 23);
    position = Vector2(50, 50);
    size = Vector2.all(32);
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.overlays.add(BuildMenu.id);
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
                  ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      EvFactory(),
                      game.evFactory,
                      "EV Factory",
                      "^Energy vCO2 ^Capital",
                      "Establish your Electric Vehicle (EV) factory, produce eco-friendly cars, and ride the wave of sustainability."),
                  ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      WindMill(),
                      game.windmill,
                      "Wind Energy",
                      "^Eneryg vCO2",
                      "Capitalize on the wind's force to boost your Energy production, reduce Carbon Emission, and strengthen Earth's health"),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      GreenHydrogen(),
                      game.greenHydrogen,
                      "Green Hydrogen",
                      "vCO2 ^Resources",
                      "A strategic, long-term investment for players aiming for advanced and low-carbon energy solutions"),
                  ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      RecyclingFactory(),
                      game.recyclingFactory,
                      "Recycling",
                      "^Resources ^Capital vEnergy",
                      "Process and recycle waste materials, reducing overall pollution and promoting a circular economy"),
                ])
              ],
            ),
          ),
        ));
  }
}

class ElevatedCard extends StatelessWidget {
  const ElevatedCard(this.game, this.size, this.structure, this.spriteImage,
      this.heading, this.subheading, this.description);
  final OurGame game;
  final String heading;
  final String subheading;
  final String description;

  final Vector2 size;
  final Sprite spriteImage;
  final Structure structure;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(clipBehavior: Clip.none, children: [
                Positioned(
                    child: Card(
                  elevation: 10,
                  child: SizedBox(
                    width: size.x,
                    height: size.y,
                  ),
                )),
                Positioned(
                    top: -10,
                    left: 5,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: size.x / 2,
                        height: size.y,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: RawImage(
                          image: spriteImage.toImageSync(),
                        ),
                      ),
                    )),
                Positioned(
                    top: 10,
                    right: 0,
                    width: size.x / 2 - 5,
                    height: size.y,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(heading,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(subheading,
                                style: const TextStyle(fontSize: 12)),
                            Text(description,
                                style: const TextStyle(fontSize: 10)),
                            Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                    height: 25,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          game.overlays.remove(BuildMenu.id);
                                          game.state = PlaceItemState();
                                          game.toAdd = structure;
                                        },
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.blue),
                                          fixedSize: MaterialStateProperty.all(
                                              Size(size.x / 3, 20)),
                                        ),
                                        child: Text("Buy"))))
                          ]),
                    ))
              ]),
            )));
  }
}
