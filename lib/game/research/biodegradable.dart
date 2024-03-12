import 'package:game_name/game/research/researh.dart';
import 'package:game_name/util/delta.dart';

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
            timeToImplement: 2,
            displayName: "Biodegradable Materials",
            description:
                "Introduce eco-friendly alternatives that naturally decompose, mitigating pollution and waste while promoting sustainable practices.",
            id: 'biodegradable');

  static const name = 'biodegradable';
  @override
  Future<void> onLoad() async {
    sprite = game.biodegradable;
    await super.onLoad();
  }

  @override
  ParamDelta getResearchBonus() {
    return ParamDelta(
          deltaCarbon: 0.1,
          deltaResources: 0.4,
          deltaCapital: 0.0,
          deltaMorale: 0.1,
          deltaEnergy: 0.0,
          deltaHealth: 0.1,
        ) *
        game.builtItems.length.toDouble();
  }
}
