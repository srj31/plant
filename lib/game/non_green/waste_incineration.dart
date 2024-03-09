import 'package:game_name/game/non_green/non_green.dart';
import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/game/structures/upgrade/upgrade.dart';

class WasteIncineration extends NonGreenStructure {
  WasteIncineration(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
          capital: 200,
          resources: 10,
          deltaCapital: 2,
          deltaResources: -0.1,
          deltaCarbon: -0.2,
          deltaEnergy: 0.0,
          deltaHealth: -0.1,
          deltaMorale: 0.05,
          timeToBuild: 2,
          fullName: "Waste Incineration",
        );

  static const name = 'waste_incineration';

  @override
  Future<void> onLoad() async {
    displaySprite = game.getSpriteFromSheet("waste.png");
    animations = {
      BuildingState.start: game.underConstruction,
      BuildingState.done: game.wasteIncineration,
    };
    current = BuildingState.start;
    upgrades = [
      Upgrade(
        game: game,
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
    ];
    await super.onLoad();
  }
}
