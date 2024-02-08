import 'package:game_name/game/policies/policy.dart';

class Afforestation extends Policy {
  Afforestation(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 100,
            resources: 20,
            deltaCapital: 0.0,
            deltaResources: 0.002,
            deltaCarbon: 0.05,
            deltaEnergy: 0.0,
            deltaHealth: 0.005,
            deltaMorale: 0.05,
            timeToPass: 1);

  static const name = 'afforestation';
  @override
  Future<void> onLoad() async {
    sprite = game.afforestation;
    await super.onLoad();
  }
}
