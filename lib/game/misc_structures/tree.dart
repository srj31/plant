import 'package:flame/components.dart';
import 'package:game_name/game/misc/bubble_popup.dart';
import 'package:game_name/game/structures/structures.dart';

class Tree extends Structure {
  Tree(
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
            timeToBuild: 1);

  final name = 'tree';
  var showBubble = true;

  @override
  Future<void> onLoad() async {
    sprites = {
      BuildingState.start: game.evFactory,
      BuildingState.done: game.afforestation,
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
