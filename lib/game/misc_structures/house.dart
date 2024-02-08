import 'package:flame/components.dart';
import 'package:game_name/game/misc/bubble_popup.dart';
import 'package:game_name/game/structures/structures.dart';
import 'package:game_name/game/structures/upgrade/upgrade.dart';

class House extends Structure {
  House(
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
          fullName: "House",
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

  final name = 'house';
  var showBubble = true;

  @override
  Future<void> onLoad() async {
    sprites = {
      BuildingState.start: game.evFactory,
      BuildingState.done: game.house,
    };
    current = BuildingState.start;
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
              priority: 1000,
              size: Vector2.all(75),
              sprite: game.moraleSprite,
              position: Vector2(size.x * 0.25, 0),
              onTap: () {
                game.morale += 0.1;
              }));
        }
      case _:
        {}
    }
  }
}
