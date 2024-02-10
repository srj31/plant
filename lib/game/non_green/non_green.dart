import 'package:flame/events.dart';
import 'package:game_name/game/structures/structures.dart';

class NonGreenStructure extends Structure {
  NonGreenStructure({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
    required super.capital,
    required super.resources,
    required super.deltaCapital,
    required super.deltaResources,
    required super.deltaCarbon,
    required super.deltaEnergy,
    required super.deltaHealth,
    required super.deltaMorale,
    required super.timeToBuild,
    required super.fullName,
  });

  @override
  void onTapUp(TapUpEvent event) {
    game.selectedStructure = this;
    game.overlays.add(StructureInfo.id);
  }
}
