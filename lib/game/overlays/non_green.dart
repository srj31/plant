import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/misc/item_card.dart';
import 'package:game_name/game/non_green/chemical.dart';
import 'package:game_name/game/non_green/fossil_fuel.dart';
import 'package:game_name/game/non_green/plastic.dart';
import 'package:game_name/game/non_green/waste_incineration.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/state/place_item.dart';
import 'package:game_name/game/structures/structures.dart';

class NonGreenComponent extends SpriteComponent
    with TapCallbacks, HasGameReference<OurGame> {
  NonGreenComponent({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    sprite = Sprite(await Flame.images.load('non_green.png'));
    position = Vector2(game.size.x * 0.075, game.size.y * 0.70);
    anchor = Anchor.center;
    size = Vector2.all(32);
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.overlays.add(NonGreenMenu.id);
    AudioManager.playSfx('opening_overlay.wav', game.soundVolume);
  }
}

class NonGreenMenu extends StatelessWidget {
  static const id = 'NonGreenMenu';
  final OurGame game;

  const NonGreenMenu({super.key, required this.game});

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
                        FossilFuel(),
                        game.getSpriteFromSheet("fossil_fuel.png"),
                        false,
                        NonGreenMenu.id),
                    ItemCard(
                        game,
                        Vector2(game.size.x * 0.40, game.size.y * 0.40),
                        ChemicalPlant(),
                        game.getSpriteFromSheet("chemical_plant.png"),
                        false,
                        NonGreenMenu.id)
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ItemCard(
                        game,
                        Vector2(game.size.x * 0.40, game.size.y * 0.40),
                        PlasticPlants(),
                        game.getSpriteFromSheet("plastic_plant.png"),
                        false,
                        NonGreenMenu.id),
                    ItemCard(
                        game,
                        Vector2(game.size.x * 0.40, game.size.y * 0.40),
                        WasteIncineration(),
                        game.getSpriteFromSheet("waste_incineration.png"),
                        false,
                        NonGreenMenu.id)
                  ])
                ]))));
  }
}

class ElevatedCard extends StatelessWidget {
  const ElevatedCard(this.game, this.size, this.structure, this.spriteImage,
      this.heading, this.description,
      {super.key});
  final OurGame game;
  final String heading;
  final Structure structure;
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
                        Text(description, style: const TextStyle(fontSize: 10)),
                        Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                                height: 25,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (structure.capital <= game.capital &&
                                          structure.resources <=
                                              game.resources) {
                                        game.overlays.remove(NonGreenMenu.id);
                                        final newState = PlaceItemState();
                                        newState.displayGrids(game);
                                        game.state = newState;
                                        game.toAdd = structure;
                                      }
                                    },
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      backgroundColor:
                                          structure.capital <= game.capital &&
                                                  structure.resources <=
                                                      game.resources
                                              ? MaterialStateProperty.all(
                                                  Colors.green)
                                              : MaterialStateProperty.all(
                                                  Colors.grey),
                                      fixedSize: MaterialStateProperty.all(
                                          Size(size.x * 0.45, 20)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RawImage(
                                          image:
                                              game.capitalSprite.toImageSync(),
                                        ),
                                        Text(
                                            structure.capital
                                                .toStringAsFixed(0),
                                            style:
                                                const TextStyle(fontSize: 10)),
                                        const Spacer(),
                                        RawImage(
                                          image: game.resourcesSprite
                                              .toImageSync(),
                                        ),
                                        Text(
                                            structure.resources
                                                .toStringAsFixed(0),
                                            style:
                                                const TextStyle(fontSize: 10)),
                                      ],
                                    ))))
                      ]),
                )
              ]),
            )));
  }
}
