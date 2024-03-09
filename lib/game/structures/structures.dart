import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/audio_manager.dart';
import 'package:game_name/game/misc/finish_building_effect.dart';
import 'package:game_name/game/misc_structures/house.dart';
import 'package:game_name/game/non_green/fossil_fuel.dart';
import 'package:game_name/game/non_green/plastic.dart';
import 'package:game_name/game/non_green/waste_incineration.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/structures/ev_factory.dart';
import 'package:game_name/game/structures/green_hydrogen.dart';
import 'package:game_name/game/structures/recycling_factory.dart';
import 'package:game_name/game/structures/upgrade/upgrade.dart';
import 'package:game_name/game/structures/windmill.dart';
import 'package:game_name/util/delta.dart';
import 'package:google_fonts/google_fonts.dart';

enum BuildingState {
  start,
  building,
  done,
}

class Structure extends SpriteAnimationGroupComponent<BuildingState>
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
    required this.fullName,
  }) {
    timeLeft = timeToBuild;
  }

  final double capital;
  final double resources;

  final double deltaCapital;
  final double deltaResources;
  final double deltaCarbon;
  final double deltaEnergy;
  final double deltaHealth;
  final double deltaMorale;
  final double timeToBuild;
  final String fullName;

  late Sprite displaySprite;
  bool isDone = false;

  late List<Upgrade> upgrades;
  late double timeLeft;

  @override
  void onLongTapDown(TapDownEvent event) {
    game.selectedStructure = this;
    game.overlays.add(StructureInfo.id);
    print(fullName);
    print(current);
    super.onLongTapDown(event);
  }

  void finishBuilding() {
    AudioManager.playSfx('when_built.wav', game.soundVolume);
    add(FinishBuildingEffect(
        size: Vector2.all(100), priority: 1000, position: Vector2.all(0)));
    isDone = true;
    current = BuildingState.done;
    print("current: ${current}");
  }

  factory Structure.factory(String name, Vector2 location) {
    switch (name) {
      case "fossil":
        return FossilFuel(
            position: location, priority: 1, anchor: Anchor.center);
      case "plastic":
        return PlasticPlants(
            position: location, priority: 1, anchor: Anchor.center);
      case "waste_incineration":
        return WasteIncineration(
            position: location, priority: 1, anchor: Anchor.center);
      case "ev_factory":
        return EvFactory(
            position: location, priority: 1, anchor: Anchor.center);
      case "green_hydrogen":
        return GreenHydrogen(
            position: location, priority: 1, anchor: Anchor.center);
      case "recycling_factory":
        return RecyclingFactory(
            position: location, priority: 1, anchor: Anchor.center);
      case "windmill":
        return WindMill(position: location, priority: 1, anchor: Anchor.center);
      case "house":
        return HouseStructure(
            position: location, priority: 1, anchor: Anchor.center);

      default:
        return throw Exception("Unknown type $name");
    }
  }

  ParamDelta get paramDelta {
    return ParamDelta(
        deltaHealth: deltaHealth,
        deltaMorale: deltaMorale,
        deltaCarbon: deltaCarbon,
        deltaResources: deltaResources,
        deltaEnergy: deltaEnergy,
        deltaCapital: deltaCapital);
  }

  ParamDelta bonusWind() {
    return ParamDelta.zero();
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
                      structure,
                      Vector2(game.size.x * 0.70, game.size.y * 0.80),
                      structure.displaySprite,
                      structure.fullName,
                      "Details about upgrading the structure",
                      true),
                ]))));
  }
}

class ElevatedCard extends StatefulWidget {
  const ElevatedCard(this.game, this.structure, this.size, this.spriteImage,
      this.heading, this.description, this.isGreen,
      {super.key});
  final OurGame game;
  final String heading;
  final String description;

  final Structure structure;

  final Vector2 size;
  final Sprite spriteImage;

  final bool isGreen;

  @override
  ElevatedCardState createState() => ElevatedCardState(game);
}

class ElevatedCardState extends State<ElevatedCard> {
  ElevatedCardState(this.game)
      : capital = game.capital,
        resources = game.resources;
  final OurGame game;

  double capital;
  double resources;

  void deltaCapitalResources(double deltaCapital, double deltaResources) {
    setState(() {
      capital += deltaCapital;
      resources += deltaResources;
    });
  }

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
                        colors: widget.isGreen
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
                      ),
                    ),
                    child: SizedBox(
                      width: widget.size.x,
                      height: widget.size.y,
                    ),
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
                        width: widget.size.x / 2,
                        height: widget.size.y,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: RadialGradient(
                            radius: 0.5,
                            colors: widget.isGreen
                                ? [
                                    Colors.green.shade800,
                                    Colors.lightGreen,
                                  ]
                                : [Colors.grey.shade700, Colors.grey],
                          ),
                        ),
                        child: RawImage(
                          image: widget.spriteImage.toImageSync(),
                          scale: 0.5,
                        ),
                      ),
                    )),
                Positioned(
                  top: 10,
                  right: 10,
                  width: widget.size.x * 0.5 - 20,
                  height: widget.size.y - 20,
                  child: Column(children: [
                    Container(
                      decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 1.0,
                              spreadRadius: 0.0,
                              offset: Offset(0.0, 0.0),
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.green,
                              Colors.lightGreen,
                              Colors.green
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          )),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          child: Text(widget.heading,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: GoogleFonts.play().fontFamily,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: widget.isGreen
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
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 1.0,
                                spreadRadius: 0.0,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                            color: Colors.green.shade600.withAlpha(255),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.description,
                                  style: const TextStyle(fontSize: 12)),
                              ...widget.structure.upgrades
                                  .map((upgrade) => UpgradeWidget(upgrade))
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                )
              ]),
            )));
  }
}
