import 'package:game_name/game/research/researh.dart';

class CarbonTechnology extends Research {
  CarbonTechnology(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 200,
            resources: 30,
            deltaCapital: 0.5,
            deltaResources: 0.1,
            deltaCarbon: 0.1,
            deltaEnergy: -0.05,
            deltaHealth: 0.1,
            deltaMorale: 0.05,
            timeToImplement: 3,
            id: 'carbon_technology');

  static const name = 'carbon_technology';
  @override
  Future<void> onLoad() async {
    sprite = game.carbonTechnology;
    await super.onLoad();
  }
}
