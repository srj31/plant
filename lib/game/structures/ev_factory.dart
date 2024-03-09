import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/game/structures/upgrade/upgrade.dart';

class EvFactory extends Structure {
  EvFactory(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
          capital: 100,
          resources: 20,
          deltaCapital: 10,
          deltaResources: 0.05,
          deltaCarbon: 0.05,
          deltaEnergy: 0.05,
          deltaHealth: 0.002,
          deltaMorale: 0.2,
          timeToBuild: 2,
          fullName: "EV Factory",
        );

  final name = 'ev_factory';

  @override
  Future<void> onLoad() async {
    displaySprite = game.getSpriteFromSheet("ev_factory.png");
    animations = {
      BuildingState.start: game.underConstruction,
      BuildingState.done: game.evFactory,
    };
    current = BuildingState.start;
    upgrades = [
      Upgrade(
          name: 'Automated Assembly Line',
          capital: 50,
          resources: 10,
          deltaCapital: -0.05,
          deltaResources: -0.1,
          deltaCarbon: 0.05,
          deltaEnergy: 0.1,
          deltaHealth: 0.01,
          deltaMorale: 0.01,
          timeToUpgrade: 1,
          description: "Enhance production efficiency with robotic automation",
          game: game),
      Upgrade(
          name: 'Battery Technology Research Lab',
          capital: 50,
          resources: 10,
          deltaCapital: -0.05,
          deltaResources: -0.1,
          deltaCarbon: 0.05,
          deltaEnergy: 0.1,
          deltaHealth: 0.01,
          deltaMorale: 0.01,
          timeToUpgrade: 1,
          description: "Innovate longer-lasting, high-performance EV batteries",
          game: game),
      Upgrade(
          name: 'Charging Station Network Expansion',
          capital: 50,
          resources: 10,
          deltaCapital: -0.05,
          deltaResources: -0.1,
          deltaCarbon: 0.05,
          deltaEnergy: 0.1,
          deltaHealth: 0.01,
          deltaMorale: 0.01,
          timeToUpgrade: 1,
          description: "Expand convenient access to EV charging infrastructure",
          game: game)
    ];
    await super.onLoad();
  }
}
