import 'package:game_name/game/policies/policy.dart';

class GlobalTreaty extends Policy {
  GlobalTreaty(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 300,
            resources: 20,
            deltaCapital: 20,
            deltaResources: 0.1,
            deltaCarbon: 0.0,
            deltaEnergy: 0.0,
            deltaHealth: 0.05,
            deltaMorale: 0.2,
            timeToPass: 2,
            id: 'global_treaty');

  @override
  Future<void> onLoad() async {
    sprite = game.globalTreaty;
    await super.onLoad();
  }
}
