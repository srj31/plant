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
import 'package:game_name/util/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

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
    position = Vector2(game.size.x * 0.075, game.size.y * 0.40);
    anchor = Anchor.center;
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
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      SmartGrid(),
                      game.smartGrid,
                    ),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      Biodegradable(),
                      game.biodegradable,
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.40, game.size.y * 0.40),
                      NanoTechnology(),
                      game.nanoTechnology,
                    )
                  ])
                ]))));
  }
}

class ElevatedCard extends StatelessWidget {
  const ElevatedCard(this.game, this.size, this.research, this.spriteImage,
      {super.key});
  final OurGame game;
  final Research research;

  final Vector2 size;
  final Sprite spriteImage;

  @override
  Widget build(BuildContext context) {
    bool isPurchased = game.isPurchased[research.id] ?? false;
    return Center(
        child: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(clipBehavior: Clip.none, children: [
                Positioned(
                    child: Card(
                  color: Colors.green,
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green.shade800,
                              Colors.lightGreen,
                              Colors.green.shade600
                            ])),
                    child: SizedBox(
                      width: size.x,
                      height: size.y,
                    ),
                  ),
                )),
                Positioned(
                    top: -15,
                    left: 5,
                    child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                      width: size.x * 0.5,
                                      height: size.y,
                                      decoration: BoxDecoration(
                                        color: Colors.lightGreen,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        gradient: RadialGradient(
                                            radius: 0.5,
                                            colors: [
                                              Colors.green.shade800,
                                              Colors.lightGreen,
                                            ]),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: RawImage(
                                          image: spriteImage.toImageSync(),
                                        ),
                                      )),
                                  Positioned(
                                      top: size.y * 0.1,
                                      left: -size.x * 0.07,
                                      child: Column(
                                        children: [
                                          Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                SizedBox(
                                                    width: size.x * 0.18,
                                                    height: size.y * 0.15,
                                                    child: Card(
                                                      elevation: 5,
                                                      color: research
                                                                  .deltaMorale >=
                                                              0
                                                          ? Colors.green
                                                          : Colors.red.shade900,
                                                    )),
                                                Positioned(
                                                    top: size.y * 0.01,
                                                    left: size.x * 0.02,
                                                    child: RawImage(
                                                        image: game.moraleSprite
                                                            .toImageSync())),
                                                Positioned(
                                                  bottom: size.y * 0.02,
                                                  right: size.x * 0.02,
                                                  child: BorderedText(
                                                    text: research.deltaMorale
                                                        .abs()
                                                        .toStringAsFixed(2),
                                                  ),
                                                ),
                                              ]),
                                          Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                SizedBox(
                                                    width: size.x * 0.18,
                                                    height: size.y * 0.15,
                                                    child: Card(
                                                      elevation: 5,
                                                      color: research
                                                                  .deltaCarbon >=
                                                              0
                                                          ? Colors.green
                                                          : Colors.red.shade900,
                                                    )),
                                                Positioned(
                                                    top: size.y * 0.01,
                                                    left: size.x * 0.02,
                                                    child: RawImage(
                                                        image: game
                                                            .carbonEmissionSprite
                                                            .toImageSync())),
                                                Positioned(
                                                  bottom: size.y * 0.02,
                                                  right: size.x * 0.02,
                                                  child: BorderedText(
                                                    text: research.deltaCarbon
                                                        .abs()
                                                        .toStringAsFixed(2),
                                                  ),
                                                ),
                                              ]),
                                          Stack(children: [
                                            SizedBox(
                                                width: size.x * 0.18,
                                                height: size.y * 0.15,
                                                child: Card(
                                                  elevation: 5,
                                                  color:
                                                      research.deltaResources >=
                                                              0
                                                          ? Colors.green
                                                          : Colors.red.shade900,
                                                )),
                                            Positioned(
                                                top: size.y * 0.01,
                                                left: size.x * 0.02,
                                                child: RawImage(
                                                    image: game.resourcesSprite
                                                        .toImageSync())),
                                            Positioned(
                                              bottom: size.y * 0.02,
                                              right: size.x * 0.02,
                                              child: BorderedText(
                                                text: research.deltaResources
                                                    .abs()
                                                    .toStringAsFixed(2),
                                              ),
                                            ),
                                          ]),
                                        ],
                                      )),
                                  Positioned(
                                      top: size.y * 0.15,
                                      right: -size.x * 0.05,
                                      child: Column(
                                        children: [
                                          Stack(children: [
                                            SizedBox(
                                                width: size.x * 0.18,
                                                height: size.y * 0.15,
                                                child: Card(
                                                  elevation: 5,
                                                  color:
                                                      research.deltaEnergy >= 0
                                                          ? Colors.green
                                                          : Colors.red.shade900,
                                                )),
                                            Positioned(
                                                top: size.y * 0.01,
                                                left: size.x * 0.02,
                                                child: RawImage(
                                                    image: game.energySprite
                                                        .toImageSync())),
                                            Positioned(
                                              bottom: size.y * 0.02,
                                              right: size.x * 0.02,
                                              child: BorderedText(
                                                text: research.deltaEnergy
                                                    .abs()
                                                    .toStringAsFixed(2),
                                              ),
                                            ),
                                          ]),
                                          Stack(children: [
                                            SizedBox(
                                                width: size.x * 0.18,
                                                height: size.y * 0.15,
                                                child: Card(
                                                  elevation: 5,
                                                  color:
                                                      research.deltaCapital >= 0
                                                          ? Colors.green
                                                          : Colors.red.shade900,
                                                )),
                                            Positioned(
                                                top: size.y * 0.01,
                                                left: size.x * 0.02,
                                                child: RawImage(
                                                    image: game.capitalSprite
                                                        .toImageSync())),
                                            Positioned(
                                              bottom: size.y * 0.02,
                                              right: size.x * 0.02,
                                              child: BorderedText(
                                                text: research.deltaCapital
                                                    .abs()
                                                    .toStringAsFixed(2),
                                              ),
                                            ),
                                          ]),
                                        ],
                                      )),
                                ],
                              )
                            ]))),
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
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
                                color: Colors.green.shade600,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(research.displayName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily:
                                              GoogleFonts.play().fontFamily,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            Container(
                              height: size.y * 0.525,
                              alignment: Alignment.topCenter,
                              decoration: BoxDecoration(
                                  color: Colors.yellow.withOpacity(0.2),
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  research.description,
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily:
                                          GoogleFonts.play().fontFamily),
                                ),
                              ),
                            ),
                          ]),
                    )),
                Positioned(
                    bottom: 40,
                    left: 15,
                    child: Row(children: [
                      RawImage(
                        scale: 1.5,
                        image: game.time.toImageSync(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: BorderedText(
                          text: research.timeToImplement.toStringAsFixed(0),
                        ),
                      ),
                    ])),
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
                                    game.isPurchased[research.id] = true;
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
                                      ? isPurchased
                                          ? MaterialStateProperty.all(
                                              Colors.green.shade900)
                                          : MaterialStateProperty.all(
                                              Colors.green)
                                      : MaterialStateProperty.all(Colors.grey),
                                  fixedSize: MaterialStateProperty.all(
                                      Size(size.x * 0.5, 20)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: isPurchased
                                      ? [
                                          const Text("Purchased",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white))
                                        ]
                                      : [
                                          RawImage(
                                            image: game.capitalSprite
                                                .toImageSync(),
                                          ),
                                          BorderedText(
                                            text: research.capital
                                                .toStringAsFixed(0),
                                          ),
                                          const Spacer(),
                                          RawImage(
                                            image: game.resourcesSprite
                                                .toImageSync(),
                                          ),
                                          BorderedText(
                                            text: research.resources
                                                .toStringAsFixed(0),
                                          ),
                                        ],
                                )))))
              ]),
            )));
  }
}
