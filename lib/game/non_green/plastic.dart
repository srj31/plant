import 'package:game_name/game/non_green/non_green.dart';
import 'package:game_name/game/structures/structures.dart';

class PlasticPlants extends NonGreenStructure {
  PlasticPlants(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 100,
            resources: 10,
            deltaCapital: 20,
            deltaResources: -0.05,
            deltaCarbon: -0.1,
            deltaEnergy: -0.05,
            deltaHealth: -0.1,
            deltaMorale: 0.1,
            timeToBuild: 2);

  static const name = 'plastic_plants';

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprites = {
      BuildingState.start: game.evFactory,
      BuildingState.done: game.plastic,
    };
    current = BuildingState.start;
  }
}
