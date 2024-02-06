import 'package:game_name/game/research/researh.dart';

class Biodegradable extends Research {
  Biodegradable(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 100,
            resources: 20,
            deltaCapital: -0.1,
            deltaResources: 0.1,
            deltaCarbon: 0.2,
            deltaEnergy: -0.1,
            deltaHealth: 0.1,
            deltaMorale: 0.01,
            timeToImplement: 2);

  static const name = 'biodegradable';
  @override
  Future<void> onLoad() async {
    sprite = game.biodegradable;
    await super.onLoad();
  }
}
