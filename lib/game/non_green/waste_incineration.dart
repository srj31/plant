import 'package:game_name/game/non_green/non_green.dart';
import 'package:game_name/game/structures/structures.dart';

class WasteIncineration extends NonGreenStructure {
  WasteIncineration(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 200,
            resources: 10,
            deltaCapital: 2,
            deltaResources: -0.1,
            deltaCarbon: -0.2,
            deltaEnergy: 0.0,
            deltaHealth: -0.1,
            deltaMorale: 0.05,
            timeToBuild: 2);

  static const name = 'waste_incineration';

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprites = {
      BuildingState.start: game.evFactory,
      BuildingState.done: game.wasteIncineration,
    };
    current = BuildingState.start;
  }
}
