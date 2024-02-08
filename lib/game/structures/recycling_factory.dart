import 'package:game_name/game/structures/structures.dart';

class RecyclingFactory extends Structure {
  RecyclingFactory(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 300,
            resources: 30,
            deltaCapital: 5,
            deltaResources: 0,
            deltaCarbon: 0.05,
            deltaEnergy: -0.1,
            deltaHealth: 0.1,
            deltaMorale: 0.1,
            timeToBuild: 3);

  static const name = 'recycling_factory';

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprites = {
      BuildingState.start: game.evFactory,
      BuildingState.done: game.recyclingFactory,
    };
    current = BuildingState.start;
  }
}
