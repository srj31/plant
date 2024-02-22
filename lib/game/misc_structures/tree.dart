import 'package:flame/components.dart';
import 'package:game_name/game/misc/bubble_popup.dart';
import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/game/structures/upgrade/upgrade.dart';

class TreeStructure extends Structure {
  TreeStructure(
      {super.position,
      super.size,
      super.scale,
      super.angle,
      super.anchor,
      super.priority})
      : super(
          capital: 100,
          resources: 20,
          deltaCapital: -0.5,
          deltaResources: 0.1,
          deltaCarbon: 0.05,
          deltaEnergy: -0.01,
          deltaHealth: 0.01,
          deltaMorale: 0.0,
          timeToBuild: 1,
          fullName: "Tree",
        );

  final name = 'tree';
  var showBubble = true;

  @override
  Future<void> onLoad() async {
    displaySprite = game.getSpriteFromSheet("tree_animation.png");
    animations = {
      BuildingState.start: game.underConstruction,
      BuildingState.done: game.tree,
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
  void update(double dt) {
    super.update(dt);

    if (!showBubble) {
      return;
    }

    switch (current) {
      case BuildingState.done:
        {
          showBubble = false;
          add(BubblePopup(
              priority: 100,
              size: Vector2.all(75),
              sprite: game.resourcesSprite,
              position: Vector2(0, 0),
              onTap: () {
                game.resources += 0.1;
              }));
        }
      case _:
        {}
    }
  }
}
