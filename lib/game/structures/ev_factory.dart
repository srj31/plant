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
          upgrades: [
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
            )
          ],
        );

  final name = 'ev_factory';

  @override
  Future<void> onLoad() async {
    sprites = {
      BuildingState.start: game.evFactory,
      BuildingState.done: game.evFactory,
    };
    current = BuildingState.start;
    await super.onLoad();
  }
}
