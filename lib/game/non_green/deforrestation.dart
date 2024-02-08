import 'package:game_name/game/structures/structures.dart';

class Deforrestation extends Structure {
  Deforrestation(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 25,
            resources: 10,
            deltaCapital: 2,
            deltaResources: -0.1,
            deltaCarbon: -0.05,
            deltaEnergy: -0.05,
            deltaHealth: -0.1,
            deltaMorale: 0.1,
            timeToBuild: 1);

  static const name = 'deforrestation';

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprites = {
      BuildingState.start: game.evFactory,
      BuildingState.done: game.deforestation,
    };
    current = BuildingState.start;
  }
}
