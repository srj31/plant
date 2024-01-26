import 'package:game_name/game/non_green/non_green.dart';

class PlasticPlants extends NonGreenStructure {
  PlasticPlants(
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
            timeToBuild: 500);

  static const name = 'plastic_plants';

  @override
  Future<void> onLoad() async {
    sprite = game.plastic;
    await super.onLoad();
  }
}