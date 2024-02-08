import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_name/game/our_game.dart';
import 'package:game_name/game/state/default.dart';

class PlaceItemState extends AbstractState {
  void displayGrids(OurGame game) {
    const emptyTileId = 22;
    final data =
        game.mapComponent.tileMap.getLayer<TileLayer>("Map")!.tileData!;
    final nonEmptyTiles = game.getNonEmptyTiles();
    for (var i = 0; i < data.length; i++) {
      for (var j = 0; j < data[0].length; j++) {
        if (data[i][j].tile == emptyTileId && nonEmptyTiles[i][j] == false) {
          game.mapComponent.tileMap
              .setTileData(layerId: 0, x: j, y: i, gid: Gid.fromInt(23));
        }
      }
    }
  }

  @override
  void handleTap(OurGame game, TapDownEvent info) {
    final tappedCel = game.getTappedCell(info);
    final data =
        game.mapComponent.tileMap.getLayer<TileLayer>("Map")!.tileData!;
    if (tappedCel.row < 0 ||
        tappedCel.col < 0 ||
        data[tappedCel.row][tappedCel.col].tile == 0) {
      return;
    }
    for (var i = 0; i < data.length; i++) {
      for (var j = 0; j < data[0].length; j++) {
        if (data[i][j].tile == 23) {
          game.mapComponent.tileMap.setTileData(
              layerId: 0, x: j, y: i, gid: game.cachedTiledData[i][j]);
        }
      }
    }
    final spriteComponent = game.toAdd
      ..anchor = Anchor.center
      ..position = Vector2(tappedCel.center.x, tappedCel.center.y)
      ..priority = 1;

    game.addBuiltItem(item: spriteComponent);

    game.state = DefaultState();
  }
}
