import 'package:game_name/game/non_green/non_green.dart';
import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/game/structures/upgrade/upgrade.dart';

class PlasticPlants extends NonGreenStructure {
  PlasticPlants(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
          capital: 100,
          resources: 10,
          deltaCapital: 20,
          deltaResources: -0.05,
          deltaCarbon: -0.1,
          deltaEnergy: -0.05,
          deltaHealth: -0.1,
          deltaMorale: 0.1,
          timeToBuild: 2,
          displayName: "Plastic Plant",
          description:
              "Dive into the world of plastic production to meet consumer demand. Fuel economic growth with mass-produced plastics, but grapple with the environmental fallout of pollution, marine debris, and ecosystem degradation.",
          id: 'plastic_plant',
        );

  @override
  Future<void> onLoad() async {
    displaySprite = game.getSpriteFromSheet("plastic_plant.png");
    animations = {
      BuildingState.start: game.underConstruction,
      BuildingState.done: game.plastic,
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
