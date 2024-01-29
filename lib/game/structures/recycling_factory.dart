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
            capital: 3000,
            resources: 300,
            deltaCapital: 0.1,
            deltaResources: 0.1,
            deltaCarbon: -0.1,
            deltaEnergy: 0.1,
            deltaHealth: 0.1,
            deltaMorale: 0.1,
            timeToBuild: 5);

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
