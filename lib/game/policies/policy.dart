import 'package:flame/components.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/util/delta.dart';

class Policy extends SpriteComponent with HasGameReference<OurGame> {
  Policy({
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
    required this.timeToPass,
  });

  final double capital;
  final double resources;

  final double deltaCapital;
  final double deltaResources;
  final double deltaCarbon;
  final double deltaEnergy;
  final double deltaHealth;
  final double deltaMorale;
  final double timeToPass;

  ParamDelta get paramDelta => ParamDelta(
        deltaHealth: deltaHealth,
        deltaMorale: deltaMorale,
        deltaCarbon: deltaCarbon,
        deltaResources: deltaResources,
        deltaEnergy: deltaEnergy,
        deltaCapital: deltaCapital,
      );
}
