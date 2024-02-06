import 'package:game_name/game/structures/structures.dart';

class GreenHydrogen extends Structure {
  GreenHydrogen(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 1000,
            resources: 50,
            deltaCapital: -0.1,
            deltaResources: 0.2,
            deltaCarbon: 0.1,
            deltaEnergy: -0.05,
            deltaHealth: 0.1,
            deltaMorale: 0.1,
            timeToBuild: 3);

  static const name = 'green_hydrogen';

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprites = {
      BuildingState.start: game.evFactory,
      BuildingState.done: game.greenHydrogen,
    };
    current = BuildingState.start;
  }
}
