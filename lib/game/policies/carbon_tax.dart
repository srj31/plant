import 'package:game_name/game/policies/policy.dart';

class CarbonTax extends Policy {
  CarbonTax(
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
            deltaEnergy: 0.1,
            deltaHealth: 0.1,
            deltaMorale: 0.1,
            timeToBuild: 1000);

  static const name = 'carbon_tax';
  @override
  Future<void> onLoad() async {
    sprite = game.carbonTax;
    await super.onLoad();
  }
}
