import 'package:game_name/game/non_green/non_green.dart';
import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/game/structures/upgrade/upgrade.dart';

class FossilFuel extends NonGreenStructure {
  FossilFuel(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
          capital: 50,
          resources: 10,
          deltaCapital: 10,
          deltaResources: -0.5,
          deltaCarbon: -0.5,
          deltaEnergy: 0.3,
          deltaHealth: -0.05,
          deltaMorale: 0.05,
          timeToBuild: 2,
          fullName: "Fossil Fuel",
        );

  static const name = 'fossil_fuel';

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprites = {
      BuildingState.start: game.evFactory,
      BuildingState.done: game.fossilFuel,
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
