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
            capital: 200,
            resources: 20,
            deltaCapital: 10,
            deltaResources: 0.1,
            deltaCarbon: 0.025,
            deltaEnergy: 0.0,
            deltaHealth: 0.1,
            deltaMorale: 0.1,
            timeToPass: 2);

  static const name = 'carbon_tax';
  @override
  Future<void> onLoad() async {
    sprite = game.carbonTax;
    await super.onLoad();
  }
}
