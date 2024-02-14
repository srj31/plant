import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/overlays/build.dart';
import 'package:game_name/game/state/place_item.dart';
import 'package:game_name/game/structures/structures.dart';

class ItemCard<Item extends Structure> extends StatelessWidget {
  const ItemCard(this.game, this.size, this.structure, this.spriteImage,
      this.heading, this.description,
      {super.key});
  final OurGame game;
  final String heading;
  final String description;

  final Vector2 size;
  final Sprite spriteImage;
  final Item structure;

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
                  color: Colors.green,
                  elevation: 10,
                  child: SizedBox(
                    width: size.x,
                    height: size.y,
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
                                    color: Colors.lightGreen,
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
                                                child: Text(
                                                  structure.deltaMorale
                                                      .toStringAsFixed(2),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
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
                                                    structure.deltaCarbon >= 0
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
                                            child: Text(
                                              structure.deltaCarbon
                                                  .toStringAsFixed(2),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
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
                                                    structure.deltaResources >=
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
                                            child: Text(
                                              structure.deltaResources
                                                  .toStringAsFixed(2),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
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
                                                    structure.deltaEnergy >= 0
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
                                            child: Text(
                                              structure.deltaEnergy
                                                  .toStringAsFixed(2),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
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
                                                    structure.deltaCapital >= 0
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
                                            child: Text(
                                              structure.deltaCapital
                                                  .toStringAsFixed(2),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(heading,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(description,
                                style: const TextStyle(fontSize: 10)),
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
                                    game.overlays.remove(BuildMenu.id);
                                    final newState = PlaceItemState();
                                    newState.displayGrids(game);
                                    game.state = newState;
                                    game.toAdd = structure;
                                  }
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  backgroundColor: structure.capital <=
                                              game.capital &&
                                          structure.resources <= game.resources
                                      ? MaterialStateProperty.all(Colors.green)
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
                                    Text(structure.capital.toStringAsFixed(0),
                                        style: const TextStyle(fontSize: 10)),
                                    const Spacer(),
                                    RawImage(
                                      image: game.resourcesSprite.toImageSync(),
                                    ),
                                    Text(structure.resources.toStringAsFixed(0),
                                        style: const TextStyle(fontSize: 10)),
                                  ],
                                )))))
              ]),
            )));
  }
}
