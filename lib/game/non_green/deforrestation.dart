import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/game/structures/upgrade/upgrade.dart';

class Deforrestation extends Structure {
  Deforrestation(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
          capital: 25,
          resources: 10,
          deltaCapital: 2,
          deltaResources: -0.1,
          deltaCarbon: -0.05,
          deltaEnergy: -0.05,
          deltaHealth: -0.1,
          deltaMorale: 0.1,
          timeToBuild: 1,
          fullName: "Deforrestation",
        );

  static const name = 'deforrestation';

  @override
  Future<void> onLoad() async {
    displaySprite = game.getSpriteFromSheet("resources.png");
    animations = {
      BuildingState.start: game.underConstruction,
      BuildingState.done: game.deforestation,
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
}
