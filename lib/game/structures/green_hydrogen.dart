import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/game/structures/upgrade/upgrade.dart';

class GreenHydrogen extends Structure {
  GreenHydrogen(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
          capital: 1000,
          resources: 50,
          deltaCapital: -2,
          deltaResources: 0.2,
          deltaCarbon: 0.1,
          deltaEnergy: -0.05,
          deltaHealth: 0.1,
          deltaMorale: 0.1,
          timeToBuild: 3,
          fullName: "Green Hydrogen",
        );

  final name = 'green_hydrogen';

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    displaySprite = game.getSpriteFromSheet("green_hydrogen.png");
    animations = {
      BuildingState.start: game.underConstruction,
      BuildingState.done: game.greenHydrogen,
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
  }
}
