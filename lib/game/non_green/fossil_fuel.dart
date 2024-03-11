import 'package:flame/components.dart';
import 'package:game_name/game/misc/text_popup.dart';
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
          displayName: "Fossil Fuel",
          description:
              "Embrace the allure of fossil fuels to rapidly boost energy production. Harness the power of traditional energy sources, but beware of the environmental consequences as carbon emissions soar and air quality declines.",
          id: "fossil_fuel",
        );

  @override
  Future<void> onLoad() async {
    displaySprite = game.getSpriteFromSheet("fossil_fuel.png");
    animations = {
      BuildingState.start: game.underConstruction,
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
    await super.onLoad();
  }

  @override
  void displayTextPopup() {
    popup = TextPopup(
        "Fossil fuel combustion is the largest contributor to CO2 emissions, a major driver of climate change.",
        true,
        position: Vector2(size.x * 0.5, 0),
        size: Vector2(300, 100),
        anchor: Anchor.center);

    addTextPopup(popup!);

    Future.delayed(const Duration(seconds: 7), () {
      hasPopup = false;
      remove(popup!);
    });
  }
}
