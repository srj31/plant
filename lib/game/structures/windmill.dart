import 'package:game_name/game/structures/structures.dart';

class WindMill extends Structure {
  WindMill(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 2000,
            resources: 30,
            deltaCapital: -0.05,
            deltaResources: 0.1,
            deltaCarbon: -0.1,
            deltaEnergy: 0.1,
            deltaHealth: 0.005,
            deltaMorale: 0.1,
            timeToBuild: 2);

  static const name = 'windmill';

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprites = {
      BuildingState.start: game.evFactory,
      BuildingState.done: game.windmill,
    };
    current = BuildingState.start;
  }
}
