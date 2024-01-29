import 'package:game_name/game/structures/structures.dart';

class EvFactory extends Structure {
  EvFactory(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 1000,
            resources: 20,
            deltaCapital: 0.1,
            deltaResources: 0.1,
            deltaCarbon: -0.1,
            deltaEnergy: 0.005,
            deltaHealth: 0.002,
            deltaMorale: 0.1,
            timeToBuild: 5);

  static const name = 'ev_factory';

  @override
  Future<void> onLoad() async {
    sprites = {
      BuildingState.start: game.evFactory,
      BuildingState.done: game.evFactory,
    };
    current = BuildingState.start;
    await super.onLoad();
  }
}
