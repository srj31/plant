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

enum BuildingState {
  start,
  building,
  done,
}

class Structure extends SpriteGroupComponent<BuildingState>
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
  bool isDone = false;

  late List<Upgrade> upgrades;
  late double timeLeft;

  @override
  void onLongTapDown(TapDownEvent event) {
    game.selectedStructure = this;
    game.overlays.add(StructureInfo.id);
    super.onLongTapDown(event);
  }

  @override
  void update(double dt) {
    timeLeft = max(0, timeLeft - dt);
    if (timeLeft == 0) {
      if (!isDone) {
        AudioManager.playSfx('when_built.wav', game.soundVolume);
        add(FinishBuildingEffect(
            size: Vector2.all(100),
            priority: 1000,
            position: Vector2.all(0)));
      }
      isDone = true;
      current = BuildingState.done;
    }
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
        return House(position: location, priority: 1, anchor: Anchor.center);

      default:
        return throw Exception("Unknown type $name");
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
                      structure,
                      Vector2(game.size.x * 0.70, game.size.y * 0.80),
                      structure.sprite!,
                      structure.fullName,
                      "Delta for all thigs",
                      "Details about upgrading the structure"),
                ]))));
  }
}

class ElevatedCard extends StatefulWidget {
  const ElevatedCard(this.game, this.structure, this.size, this.spriteImage,
      this.heading, this.subheading, this.description,
      {super.key});
  final OurGame game;
  final String heading;
  final String subheading;
  final String description;

  final Structure structure;

  final Vector2 size;
  final Sprite spriteImage;

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
                  child: SizedBox(
                    width: widget.size.x,
                    height: widget.size.y,
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
                        ),
                        child: RawImage(
                          image: widget.spriteImage.toImageSync(),
                        ),
                      ),
                    )),
                Positioned(
                  top: 10,
                  right: 0,
                  width: widget.size.x / 2 - 5,
                  height: widget.size.y,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.heading,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(widget.subheading,
                            style: const TextStyle(fontSize: 12)),
                        Text(widget.description,
                            style: const TextStyle(fontSize: 10)),
                        ...widget.structure.upgrades
                            .map((upgrade) => UpgradeWidget(upgrade))
                            .toList(),
                      ]),
                )
              ]),
            )));
  }
}
