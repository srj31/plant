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
            capital: 500,
            resources: 10,
            deltaCapital: 0.1,
            deltaResources: -0.1,
            deltaCarbon: -0.1,
            deltaEnergy: 0.1,
            deltaHealth: -0.01,
            deltaMorale: 0.1,
            timeToBuild: 5);

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
