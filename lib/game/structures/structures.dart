import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_tiled/flame_tiled.dart' as flame_tiled;
import 'package:flutter/material.dart';
import 'package:game_name/game/non_green/fossil_fuel.dart';
import 'package:game_name/game/non_green/plastic.dart';
import 'package:game_name/game/non_green/waste_incineration.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/structures/ev_factory.dart';
import 'package:game_name/game/structures/green_hydrogen.dart';
import 'package:game_name/game/structures/recycling_factory.dart';
import 'package:game_name/game/structures/windmill.dart';

class Structure extends SpriteComponent
    with TapCallbacks, HasGameReference<OurGame> {
  Structure({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
    required this.capital,
    required this.resources,
    required this.deltaCapital,
    required this.deltaResources,
    required this.deltaCarbon,
    required this.deltaEnergy,
    required this.deltaHealth,
    required this.deltaMorale,
    required this.timeToBuild,
  });

  final double capital;
  final double resources;

  final double deltaCapital;
  final double deltaResources;
  final double deltaCarbon;
  final double deltaEnergy;
  final double deltaHealth;
  final double deltaMorale;
  final double timeToBuild;

  @override
  void onTapUp(TapUpEvent event) {
    game.selectedStructure = this;
    game.overlays.add(StructureInfo.id);
  }

  factory Structure.factory(flame_tiled.TiledObject building) {
    final (x, y) = (building.x, building.y + 142 / 2);
    switch (building.properties["type"]?.value) {
      case "fossil":
        return FossilFuel(
            position: Vector2(x, y), priority: 1, anchor: Anchor.topCenter);

      case "plastic":
        return PlasticPlants(
            position: Vector2(x, y), priority: 1, anchor: Anchor.topCenter);
      case "waste_incineration":
        return WasteIncineration(
            position: Vector2(x, y), priority: 1, anchor: Anchor.topCenter);
      case "ev_factory":
        return EvFactory(
            position: Vector2(x, y), priority: 1, anchor: Anchor.topCenter);
      case "green_hydrogen":
        return GreenHydrogen(
            position: Vector2(x, y), priority: 1, anchor: Anchor.topCenter);
      case "recycling_factory":
        return RecyclingFactory(
            position: Vector2(x, y), priority: 1, anchor: Anchor.topCenter);
      case "windmill":
        return WindMill(
            position: Vector2(x, y), priority: 1, anchor: Anchor.center);
      case "house":
        return EvFactory(
            position: Vector2(x, y), priority: 1, anchor: Anchor.topCenter);

      default:
        return throw Exception("Unknown type ${building.properties["type"]}");
    }
  }
}

class StructureInfo extends StatelessWidget {
  static const id = 'StructureInfo';
  final OurGame game;
  late final Structure structure;

  StructureInfo({super.key, required this.game}) {
    structure = game.selectedStructure;
  }

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
                  ElevatedCard(
                      game,
                      Vector2(game.size.x * 0.70, game.size.y * 0.80),
                      structure.sprite!,
                      "Structure Name",
                      "Delta for all thigs",
                      "Details about upgrading the structure"),
                ]))));
  }
}

class ElevatedCard extends StatelessWidget {
  const ElevatedCard(this.game, this.size, this.spriteImage, this.heading,
      this.subheading, this.description,
      {super.key});
  final OurGame game;
  final String heading;
  final String subheading;
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
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                      fixedSize: MaterialStateProperty.all(
                                          Size(size.x / 3, 20)),
                                    ),
                                    child: const Text("Upgrade"))))
                      ]),
                )
              ]),
            )));
  }
}
