import 'package:game_name/game/research/researh.dart';

class NanoTechnology extends Research {
  NanoTechnology(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
            capital: 300,
            resources: 20,
            deltaCapital: 1,
            deltaResources: 0.1,
            deltaCarbon: 0.2,
            deltaEnergy: -0.1,
            deltaHealth: 0.05,
            deltaMorale: 0.05,
            timeToImplement: 3);

  static const name = 'nano_technology';
  @override
  Future<void> onLoad() async {
    sprite = game.nanoTechnology;
    await super.onLoad();
  }
}
