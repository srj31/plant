import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/game/structures/upgrade/upgrade.dart';

class RecyclingFactory extends Structure {
  RecyclingFactory(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
          capital: 300,
          resources: 30,
          deltaCapital: 5,
          deltaResources: 0,
          deltaCarbon: 0.05,
          deltaEnergy: -0.1,
          deltaHealth: 0.1,
          deltaMorale: 0.1,
          timeToBuild: 3,
          fullName: "Recycling Factory",
        );

  final name = 'recycling_factory';

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprites = {
      BuildingState.start: game.underConstruction,
      BuildingState.done: game.recyclingFactory,
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
