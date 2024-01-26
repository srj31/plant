import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/state/default.dart';
import 'package:game_name/game/tile_info.dart';

class PlaceItemState extends AbstractState {
  @override
  void handleTap(OurGame game, TapDownEvent info) {
    final tappedCel = game.getTappedCell(info);
    final data =
        game.mapComponent.tileMap.getLayer<TileLayer>("Map")!.tileData!;
    print(data[tappedCel.row][tappedCel.col].tile);
    if (data[tappedCel.row][tappedCel.col].tile == 0) {
      print("Not part of map");
      return;
    }
    final spriteComponent = game.toAdd
      ..anchor = Anchor.center
      ..position = Vector2(tappedCel.center.dx, tappedCel.center.dy)
      ..priority = 1;

    game.addBuiltItem(spriteComponent);

    game.state = DefaultState();
  }
}
