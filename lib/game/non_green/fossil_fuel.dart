import 'package:game_name/game/non_green/non_green.dart';
import 'package:game_name/game/structures/structures.dart';

class FossilFuel extends NonGreenStructure {
  FossilFuel(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 50,
            resources: 10,
            deltaCapital: 10,
            deltaResources: -0.5,
            deltaCarbon: -0.5,
            deltaEnergy: 0.3,
            deltaHealth: -0.05,
            deltaMorale: 0.05,
            timeToBuild: 2);

  static const name = 'fossil_fuel';

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprites = {
      BuildingState.start: game.evFactory,
      BuildingState.done: game.fossilFuel,
    };
    current = BuildingState.start;
  }
}
