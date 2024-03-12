import 'package:game_name/game/research/researh.dart';
import 'package:game_name/util/delta.dart';

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
            timeToImplement: 3,
            displayName: "Nanotechnology for Air Filtration",
            description:
                "Unlocks the potential to develop nanotechnology-based solutions for environmental issues, such as air and water filtration, energy storage, and pollution.",
            id: 'nano_technology');

  static const name = 'nano_technology';
  @override
  Future<void> onLoad() async {
    sprite = game.nanoTechnology;
    await super.onLoad();
  }

  @override
  ParamDelta getResearchBonus() {
    return ParamDelta(
          deltaCarbon: 0.1,
          deltaResources: 0.1,
          deltaCapital: 0.2,
          deltaMorale: 0.1,
          deltaEnergy: 0.1,
          deltaHealth: 0.1,
        ) *
        game.builtItems.length.toDouble();
  }
}
