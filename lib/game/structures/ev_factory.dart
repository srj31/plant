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
            capital: 100,
            resources: 20,
            deltaCapital: 10,
            deltaResources: 0.05,
            deltaCarbon: 0.05,
            deltaEnergy: 0.05,
            deltaHealth: 0.002,
            deltaMorale: 0.2,
            timeToBuild: 2);

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
