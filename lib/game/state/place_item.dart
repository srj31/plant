import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/state/default.dart';

class PlaceItemState extends AbstractState {
  @override
  void handleTap(OurGame game, TapUpInfo info) {
    final tappedCel = game.getTappedCell(info);

    print('cell: ${tappedCel.row}; ${tappedCel.col}');
    // final tappedCel = estimateCallTime<TileInfo>(() {
    //     return _getTappedCell(info);
    //   },
    // );

    final spriteComponent =
        SpriteComponent(size: Vector2.all(64.0), sprite: game.toAdd)
          ..anchor = Anchor.center
          ..position = Vector2(tappedCel.center.dx, tappedCel.center.dy)
          ..priority = 1;
    game.mapComponent.add(spriteComponent);
  }
}
