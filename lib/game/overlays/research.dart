import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/research/biodegradable.dart';
import 'package:game_name/game/research/carbon_technology.dart';
import 'package:game_name/game/research/nano_technology.dart';
import 'package:game_name/game/research/researh.dart';
import 'package:game_name/game/research/smart_grid.dart';
import 'package:game_name/game/structures/evFactory.dart';
import 'package:game_name/game/structures/structures.dart';

class ResearchComponent extends SpriteComponent
    with TapCallbacks, HasGameReference<OurGame> {
  ResearchComponent({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    sprite = game.getObjectSprite(940, 393, 28, 29);
    position = Vector2(50, 100);
    size = Vector2.all(32);
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.overlays.add(ResearchMenu.id);
  }
}

class ResearchMenu extends StatelessWidget {
  static const id = 'ResearchMenu';
  final OurGame game;

  const ResearchMenu({super.key, required this.game});

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
                      CarbonTechnology(),
                      game.carbonTechnology,
                      "Advanced Carbon Capture Technology",
                      "^CO",
                      "Positive on Health and Carbon Emission",
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      SmartGrid(),
                      game.smartGrid,
                      "Smart Grid Implementation",
                      "^Energy vCO2 ^Capital",
                      "Positive on Energy and Capital.",
                    ),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      Biodegradable(),
                      game.biodegradable,
                      "Biodegradable Materials Research",
                      "^Resource",
                      "Positive on Resources and Health",
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      NanoTechnology(),
                      game.nanoTechnology,
                      "Nanotechnology for Air Filtration",
                      "^Resource ^Health",
                      "Positive on Health and Resources",
                    )
                  ])
                ]))));
  }
}

class ElevatedCard extends StatelessWidget {
  const ElevatedCard(this.game, this.size, this.research, this.spriteImage,
      this.heading, this.subheading, this.description);
  final OurGame game;
  final String heading;
  final String subheading;
  final Research research;
  final String description;

  final Vector2 size;
  final Sprite spriteImage;

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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(heading,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(subheading, style: const TextStyle(fontSize: 12)),
                        Text(description, style: const TextStyle(fontSize: 10)),
                        Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                                height: 25,
                                child: ElevatedButton(
                                    onPressed: () {
                                      game.overlays.remove(ResearchMenu.id);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                      fixedSize: MaterialStateProperty.all(
                                          Size(size.x / 3, 20)),
                                    ),
                                    child: const Text("Buy"))))
                      ]),
                )
              ]),
            )));
  }
}
