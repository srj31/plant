import 'package:flame/components.dart';
import 'package:game_name/game/our_game.dart';

class Specialization extends SpriteComponent with HasGameReference<OurGame> {
  Specialization({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
    required this.deltaCapital,
    required this.deltaResources,
    required this.deltaCarbon,
    required this.deltaEnergy,
    required this.deltaHealth,
    required this.deltaMorale,
    required this.timeToBuild,
  });

  final double deltaCapital;
  final double deltaResources;
  final double deltaCarbon;
  final double deltaEnergy;
  final double deltaHealth;
  final double deltaMorale;
  final double timeToBuild;
}
