import 'package:flame/game.dart';
import 'package:game_name/game/misc/bubble_popup.dart';
import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/game/structures/upgrade/upgrade.dart';

class HouseStructure extends Structure {
  HouseStructure(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
          capital: 200,
          resources: 50,
          deltaCapital: 0.5,
          deltaResources: -0.12,
          deltaCarbon: -0.025,
          deltaEnergy: -0.05,
          deltaHealth: -0.01,
          deltaMorale: 0.1,
          timeToBuild: 2,
          displayName: "House",
          description:
              "Building new homes increases morale by providing shelter and fostering community growth. Enhance public sentiment and support for environmental initiatives with improved living conditions.",
          id: 'house',
        );

  var showBubble = true;

  @override
  void displayBubble() {
    addBubblePop(BubblePopup(
        priority: 100,
        size: Vector2.all(75),
        sprite: game.moraleSprite,
        position: Vector2(size.x * 0.25, size.y * -0.25),
        onTap: () {
          hasPopup = false;
          game.morale += 0.1;
        }));
  }

  @override
  Future<void> onLoad() async {
    displaySprite = game.getSpriteFromSheet("house.png");
    animations = {
      BuildingState.start: game.underConstruction,
      BuildingState.done: game.house,
    };
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
        game: game,
      ),
      Upgrade(
          name: 'Energy-Efficient Appliances',
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
              "Reduce electricity usage by upgrading to energy-efficient appliances",
          game: game),
      Upgrade(
        name: 'Smart Home Automation',
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
            "Integrate smart technology to reduce energy waste and increase efficiency",
        game: game,
      )
    ];
    current = BuildingState.start;
    await super.onLoad();
  }
}
