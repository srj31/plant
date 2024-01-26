import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:game_name/game/our_game.dart';

class NonGreenStructure extends Structure {
  NonGreen({
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
}

