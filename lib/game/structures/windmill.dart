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
            capital: 150,
            resources: 20,
            deltaCapital: -0.5,
            deltaResources: 0.01,
            deltaCarbon: 0.1,
            deltaEnergy: 0.1,
            deltaHealth: 0.1,
            deltaMorale: 0.01,
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
