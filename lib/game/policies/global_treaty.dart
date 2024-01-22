
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
            capital: 1000,
            resources: 20,
            deltaCapital: 0.1,
            deltaResources: 0.1,
            deltaCarbon: -0.1,
            deltaEnergy: 0.1,
            deltaHealth: 0.1,
            deltaMorale: 0.1,
            timeToBuild: 1000);

  static const name = 'global_treaty';
  @override
  Future<void> onLoad() async {
    sprite = game.globalTreaty;
    await super.onLoad();
  }
}
