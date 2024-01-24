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
            capital: 2000,
            resources: 30,
            deltaCapital: 0.05,
            deltaResources: 0.1,
            deltaCarbon: -0.3,
            deltaEnergy: 0.1,
            deltaHealth: 0.1,
            deltaMorale: 0.1,
            timeToBuild: 1000);

  static const name = 'green_hydrogen';

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = game.greenHydrogen;
  }
}
