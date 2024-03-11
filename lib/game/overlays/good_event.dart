import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/misc_structures/house.dart';
import 'package:game_name/game/misc_structures/tree.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/state/place_item.dart';
import 'package:game_name/game/structures/structures.dart';
import 'package:google_fonts/google_fonts.dart';

class GoodEventMenu extends StatelessWidget {
  static const id = 'GoodEventMenu';
  final OurGame game;

  const GoodEventMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Scaffold(
            backgroundColor: Colors.black.withAlpha(100),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.30, game.size.y * 0.80),
                      HouseStructure(),
                      game.getSpriteFromSheet("house.png"),
                    ),
                    ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.30, game.size.y * 0.80),
                      TreeStructure(),
                      game.getSpriteFromSheet("tree_animation.png"),
                    ),
                  ]),
                ]))));
  }
}

class ElevatedCard extends StatelessWidget {
  const ElevatedCard(this.game, this.size, this.structure, this.sprite,
      {super.key});
  final OurGame game;
  final Structure structure;

  final Sprite sprite;

  final Vector2 size;
  final double borderWidth = 5;

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
                  surfaceTintColor: Colors.lightGreen,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                        color: Colors.orangeAccent, width: borderWidth),
                  ),
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.green.shade700, Colors.lightGreen],
                      ),
                    ),
                    child: SizedBox(
                      width: size.x,
                      height: size.y,
                    ),
                  ),
                )),
                Positioned(
                    top: -10,
                    left: size.x * 0.1,
                    child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(clipBehavior: Clip.none, children: [
                                Container(
                                    width: size.x * 0.8,
                                    height: size.y * 0.5,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.lightGreen,
                                        gradient: RadialGradient(
                                          center: Alignment.center,
                                          radius: 1,
                                          colors: [
                                            Colors.lightGreen,
                                            Colors.green.shade900
                                          ],
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.green,
                                          )
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: RawImage(
                                        image: sprite.toImageSync(),
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                              ])
                            ]))),
                Positioned(
                  top: size.y * 0.375,
                  left: size.x * 0.1 + borderWidth,
                  child: Center(
                      child: Container(
                    alignment: Alignment.center,
                    width: size.x * 0.8,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 3),
                        )
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.amber.shade800,
                          Colors.amber,
                          Colors.amber.shade600
                        ],
                      ),
                    ),
                    child: Text(structure.displayName,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  )),
                ),
                Positioned(
                    top: size.y * 0.5,
                    left: 2 * borderWidth,
                    width: size.x * 0.95,
                    height: size.y * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.x,
                              height: size.y * 0.45,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.yellow.withOpacity(0.2),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    structure.description,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily:
                                            GoogleFonts.play().fontFamily,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                child: SizedBox(
                                    width: size.x,
                                    height: size.y * 0.1,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          final newState = PlaceItemState();
                                          newState.displayGrids(game);
                                          game.state = newState;
                                          game.toAdd = structure;
                                          game.hasTimerStarted = true;
                                          game.overlays
                                              .remove(GoodEventMenu.id);
                                        },
                                        style: ButtonStyle(
                                          shadowColor:
                                              MaterialStateProperty.all(
                                                  Colors.yellow),
                                          foregroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.black),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.amber),
                                        ),
                                        child: Text("CHOOSE",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: GoogleFonts.play()
                                                    .fontFamily,
                                                fontWeight:
                                                    FontWeight.bold))))),
                          ]),
                    ))
              ]),
            )));
  }
}
