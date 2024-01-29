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
            capital: 500,
            resources: 10,
            deltaCapital: 0.1,
            deltaResources: -0.1,
            deltaCarbon: -0.1,
            deltaEnergy: 0.1,
            deltaHealth: 0.1,
            deltaMorale: 0.1,
            timeToBuild: 6);

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
