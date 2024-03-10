import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/game/structures/upgrade/upgrade.dart';
import 'package:game_name/util/delta.dart';

class WindMill extends Structure {
  WindMill(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
          capital: 150,
          resources: 20,
          deltaCapital: -0.5,
          deltaResources: 0.01,
          deltaCarbon: 0.1,
          deltaEnergy: 0.1,
          deltaHealth: 0.1,
          deltaMorale: 0.01,
          timeToBuild: 2,
          fullName: "Wind Mill",
        );

  final name = 'windmill';

  @override
  Future<void> onLoad() async {
    displaySprite = game.getSpriteFromSheet('windmill.png');
    animations = {
      BuildingState.start: game.underConstruction,
      BuildingState.done: game.windmill,
    };
    current = BuildingState.start;
    upgrades = [
      Upgrade(
          name: 'Solar Panel',
          capital: 50,
          resources: 10,
          deltaCapital: -0.05,
          deltaResources: -0.1,
          deltaCarbon: 0.05,
          deltaEnergy: 0.1,
          deltaHealth: 0.01,
          deltaMorale: 0.01,
          timeToUpgrade: 1,
          description:
              "Install solar panels to save on energy bills and reduce carbon footprint.",
          game: game)
    ];
    await super.onLoad();
  }

  @override
  ParamDelta bonusWind() {
    return ParamDelta(
      deltaHealth: 0.0,
      deltaMorale: 0.0,
      deltaCarbon: 0.1,
      deltaResources: 0.01,
      deltaEnergy: 0.05,
      deltaCapital: 0.0,
    );
  }
}
