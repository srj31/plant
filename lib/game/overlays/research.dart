import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/research/biodegradable.dart';
import 'package:game_name/game/research/carbon_technology.dart';
import 'package:game_name/game/research/nano_technology.dart';
import 'package:game_name/game/research/researh.dart';
import 'package:game_name/game/research/smart_grid.dart';

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
    sprite = Sprite(await Flame.images.load('research.png'));
    position = Vector2(50, 100);
    size = Vector2.all(32);
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.overlays.add(ResearchMenu.id);
    AudioManager.playSfx("opening_overlay.wav", game.soundVolume);
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
                      "Pioneer innovative solutions to combat climate change with advanced carbon capture technology. Develop cutting-edge methods to capture and store carbon emissions, mitigating the environmental impact of industrial processes and fostering a cleaner, greener future.",
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      SmartGrid(),
                      game.smartGrid,
                      "Smart Grid Implementation",
                      "^Energy vCO2 ^Capital",
                      "Revolutionize energy infrastructure with the implementation of a smart grid. Investigate intelligent systems and grid optimization techniques to enhance energy distribution efficiency, integrate renewable resources, and empower communities with sustainable energy solutions.",
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
                      "Lead the way in sustainable materials innovation with research into biodegradable alternatives. Explore eco-friendly materials and manufacturing processes to reduce pollution, minimize waste, and promote the transition to a circular economy.",
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      NanoTechnology(),
                      game.nanoTechnology,
                      "Nanotechnology for Air Filtration",
                      "^Resource ^Health",
                      "Harness the power of nanotechnology to purify the air we breathe. Explore cutting-edge filtration techniques and nano-scale materials to combat air pollution, improve indoor air quality, and safeguard public health in an increasingly urbanized world.",
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
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RawImage(
                              image: spriteImage.toImageSync(),
                              fit: BoxFit.fitHeight,
                            ),
                          )),
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
                      ]),
                ),
                Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                            height: 25,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (research.capital <= game.capital &&
                                      research.resources <= game.resources) {
                                    AudioManager.playSfx(
                                        'tap_button.mp3', game.soundVolume);
                                    game.overlays.remove(ResearchMenu.id);
                                    game.startResearch(research);
                                  }
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  backgroundColor: research.capital <=
                                              game.capital &&
                                          research.resources <= game.resources
                                      ? MaterialStateProperty.all(Colors.green)
                                      : MaterialStateProperty.all(Colors.grey),
                                  fixedSize: MaterialStateProperty.all(
                                      Size(size.x * 0.45, 20)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RawImage(
                                      image: game.capitalSprite.toImageSync(),
                                    ),
                                    Text(research.capital.toStringAsFixed(0),
                                        style: const TextStyle(fontSize: 10)),
                                    const Spacer(),
                                    RawImage(
                                      image: game.resourcesSprite.toImageSync(),
                                    ),
                                    Text(research.resources.toStringAsFixed(0),
                                        style: const TextStyle(fontSize: 10)),
                                  ],
                                )))))
              ]),
            )));
  }
}
