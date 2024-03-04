import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/state/place_item.dart';
import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/util/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemCard<Item extends Structure> extends StatelessWidget {
  const ItemCard(this.game, this.size, this.structure, this.spriteImage,
      this.heading, this.description, this.isGreen, this.overlayId,
      {super.key});
  final OurGame game;
  final String heading;
  final String description;

  final Vector2 size;
  final Sprite spriteImage;
  final Item structure;

  final bool isGreen;
  final String overlayId;

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
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isGreen
                              ? [
                                  Colors.green.shade800,
                                  Colors.lightGreen,
                                  Colors.green.shade600
                                ]
                              : [
                                  Colors.grey.shade700,
                                  Colors.grey.shade400,
                                  Colors.grey
                                ],
                        )),
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
                              Stack(clipBehavior: Clip.none, children: [
                                Container(
                                  width: size.x * 0.5,
                                  height: size.y,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    gradient: RadialGradient(
                                      radius: 0.5,
                                      colors: isGreen
                                          ? [
                                              Colors.green.shade800,
                                              Colors.lightGreen,
                                            ]
                                          : [Colors.grey.shade700, Colors.grey],
                                    ),
                                  ),
                                  child: RawImage(
                                    image: spriteImage.toImageSync(),
                                  ),
                                ),
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
                                                    color: structure
                                                                .deltaMorale >=
                                                            0
                                                        ? isGreen
                                                            ? Colors.green
                                                            : Colors
                                                                .green.shade900
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
                                                  text: structure.deltaMorale
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
                                                color: structure.deltaCarbon >=
                                                        0
                                                    ? isGreen
                                                        ? Colors.green
                                                        : Colors.green.shade900
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
                                              text: structure.deltaCarbon
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
                                                color: structure
                                                            .deltaResources >=
                                                        0
                                                    ? isGreen
                                                        ? Colors.green
                                                        : Colors.green.shade900
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
                                              text: structure.deltaResources
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
                                                color: structure.deltaEnergy >=
                                                        0
                                                    ? isGreen
                                                        ? Colors.green
                                                        : Colors.green.shade900
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
                                              text: structure.deltaEnergy
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
                                                color: structure.deltaCapital >=
                                                        0
                                                    ? isGreen
                                                        ? Colors.green
                                                        : Colors.green.shade900
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
                                              text: structure.deltaCapital
                                                  .abs()
                                                  .toStringAsFixed(0),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    )),
                              ])
                            ]))),
                Positioned(
                    top: 10,
                    right: 0,
                    width: size.x / 2 - 5,
                    height: size.y,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                color: isGreen
                                    ? Colors.green.shade600
                                    : Colors.grey.shade700,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(heading,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily:
                                              GoogleFonts.play().fontFamily,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            Text(description,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: GoogleFonts.play().fontFamily)),
                          ]),
                    )),
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
                                  if (structure.capital <= game.capital &&
                                      structure.resources <= game.resources) {
                                    AudioManager.playSfx(
                                        'tap_button.mp3', game.soundVolume);
                                    game.overlays.remove(overlayId);
                                    final newState = PlaceItemState();
                                    newState.displayGrids(game);
                                    game.state = newState;
                                    game.toAdd = structure;
                                  }
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  backgroundColor: structure.capital <=
                                              game.capital &&
                                          structure.resources <= game.resources
                                      ? isGreen
                                          ? MaterialStateProperty.all(
                                              Colors.green)
                                          : MaterialStateProperty.all(
                                              Colors.green.shade900)
                                      : MaterialStateProperty.all(Colors.grey),
                                  fixedSize: MaterialStateProperty.all(
                                      Size(size.x * 0.5, 20)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RawImage(
                                      image: game.capitalSprite.toImageSync(),
                                    ),
                                    BorderedText(
                                      text:
                                          structure.capital.toStringAsFixed(0),
                                    ),
                                    const Spacer(),
                                    RawImage(
                                      image: game.resourcesSprite.toImageSync(),
                                    ),
                                    BorderedText(
                                      text: structure.resources
                                          .toStringAsFixed(0),
                                    )
                                  ],
                                )))))
              ]),
            )));
  }
}
